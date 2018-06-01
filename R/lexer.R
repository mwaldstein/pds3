# Reference: https://pds.jpl.nasa.gov/datastandards/pds3/standards/sr/Chapter12.pdf
# We don't strictly follow the token naming due to more liberal parsing in R,
# but it is all close enough
# Also: https://pds.nasa.gov/tools/about/pds3-tools/pds-tools-package.shtml

TOKENS <- c("IDENTIFIER", "POINTER", "STRING", "SYMBOL",
            "DATE", "TIME",
            "REAL", "BINT", "DINT",
            "UNIT",
            "END", "END_GROUP", "END_OBJECT",
            "BEGIN_GROUP", "BEGIN_OBJECT",
            "COMMENT")
LITERALS <- c("(", ")", ",", "=", "{", "}")

odl_lexer <- R6::R6Class("Lexer",
  public = list(
    tokens = TOKENS,
    literals = LITERALS,
    # Order is important here!
    t_POINTER = function(re="\\^[A-Z][A-Z0-9_]+", t) {
      return(t)
    },
    t_STRING = function(re="\"[^\"]+\"", t) {
      # Remove quotes
      t$value <- substring(t$value, 2, nchar(t$value) - 1)
      return(t)
    },
    t_SYMBOL = function(re="'[^']+'", t) {
      # Remove quotes
      t$value <- substring(t$value, 2, nchar(t$value) - 1)
      return(t)
    },
    # Date, with or without a time
    t_DATE = function(re=
      "\\d{4}\\-(\\d{2}\\-\\d{2}|\\d{3})(T\\d{2}:\\d{2}(:\\d{1,2}(.\\d+)?)?)?(\\+\\d+|\\-\\d+|Z)?",
    t) {
      # Change any zone to more standard format

      if (grepl(":\\d{1,2}(.\\d+)?[\\+\\-][\\d:]+$", t$value, perl = T)) {
        m <- regexec("[\\d:]+$", t$value, perl = T)
        tz_offset <- regmatches(t$value, m)

        if (grepl(":", tz_offset, fixed = TRUE)) {
          tz_offset <- paste0(
            lapply(strsplit(tz_offset, ":"), function(comp) {
                sprintf("%02d", strtoi(comp))
              }
            )[[1]], collapse = "")
        } else if (nchar(tz_offset) == 4) {
          # We're already in expected form
        } else {
          # Assume an integer offset
          tz_offset <- sprintf("%02d00", strtoi(tz_offset))
        }
        t$value <- paste0(substr(t$value, 1, m[[1]] - 1), tz_offset)
      }

      # Trailing Z = UTC which is the default already
      t$value <- sub("[zZ]$", "", t$value)

      date_formats <- c("%Y-%j", "%Y-%m-%d")
      time_formats <- c("%H:%M",
                        "%H:%M:%OS")
      zone_formats <- c("", "%z")

      time_zone_formats <- paste(rep(time_formats,
                                     each = length(zone_formats)),
                                 zone_formats, sep = "")
      time_zone_formats <- c("", paste0("T", time_zone_formats))
      try_formats <- paste(rep(date_formats,
                               each = length(time_zone_formats)),
                           time_zone_formats, sep = "")

      # Re-order to ensure we're trying the most detailed formats first
      try_formats <- try_formats[order(nchar(try_formats),
                                       try_formats,
                                       decreasing = TRUE)]

      t$value <- as.POSIXlt(t$value,
                            tz = "UTC",
                            tryFormats = try_formats)
      return(t)
    },
    # Time without a date
    t_TIME =
      # NOTE the seconds can be 1 or 2 digits - this is based on files in the
      # wild - see tests/testdata/PSP_010737_2050_COLOR.LBL
      function(re="\\d{2}:\\d{2}(:\\d{1,2}(\\.\\d*)?)?(\\+\\d+|\\-\\d+|Z)?", t) {
        return(t)
      },
    t_REAL = function(re=
      "[+-]?(\\d+[Ee][+-]?[0-9]+|((\\d+\\.\\d+|\\d+\\.|\\.\\d+)([Ee][+-]?[0-9]+)?))",
      t) {
      t$value <- as.numeric(t$value)
      return(t)
    },
    # Based Integer
    t_BINT = function(re="[0-9]+#[+-]?[0-9A-Fa-f]+#", t) {
      components <- strsplit(t$value, "#")[[1]]
      t$value <- strtoi(components[2], components[1])
      return(t)
    },
    # Standard Integer
    t_DINT = function(re="[+-]?[0-9]+", t) {
      t$value <- strtoi(t$value)
      return(t)
    },
    t_UNIT = function(re="<[^>]+>", t) {
      # Remove brackets
      t$value <- substring(t$value, 2, nchar(t$value) - 1)
      return(t)
    },
    t_IDENTIFIER = function(re="[A-Z][A-Z0-9_:]+", t) {
      if (t$value == "END") t$type <- "END"
      else if (t$value == "END_GROUP") t$type <- "END_GROUP"
      else if (t$value == "END_OBJECT") t$type <- "END_OBJECT"
      else if (t$value == "GROUP") t$type <- "BEGIN_GROUP"
      else if (t$value == "OBJECT") t$type <- "BEGIN_OBJECT"
      else if (t$value == "BEGIN_OBJECT") t$type <- "BEGIN_OBJECT"

      return(t)
    },
    t_COMMENT = function(re="/\\*.+?\\*/", t) {
      return()
    },
    t_ignore = " \t\r\n",
    t_error = function(t) {
      cat(sprintf("Illegal character '%s'", t$value[1]))
      t$lexer$skip(1)
      return(t)
    }
  )
)
