parser <- R6::R6Class("Parser",
  public = list(
    tokens = TOKENS[TOKENS != "COMMENT"],
    literals = LITERALS,
    name_stack = c(),
    obj_stack = list(list()),
    p_label = function(doc="label : record
                                  | label record
                                  | label END", p) {
      if (p$length() == 2) {
        p$set(1, list(p$get(2)))
      } else if (length(p$get(3)) == 1 && p$get(3) == "END") {
        p$set(1, p$get(2))
      } else {
        tmp <- p$get(2)
        tmp[[length(tmp) + 1]] <- p$get(3)
        p$set(1, tmp)
      }
    },
    p_value = function(doc="value : STRING
                                  | SYMBOL
                                  | DATE
                                  | TIME
                                  | IDENTIFIER
                                  | number
                                  | quantity
                                  | sequence", p) {

      p$set(1, p$get(2))
    },
    p_number = function(doc="number : DINT
                                    | BINT
                                    | REAL", p) {
      p$set(1, p$get(2))
    },
    p_sequence = function(doc="sequence : '(' value ')'
                                        | '(' sequence_values ')'
                                        | '{' value '}'
                                        | '{' sequence_values '}'", p) {
      p$set(1, p$get(3))
    },
    p_sequence_values = function(doc="sequence_values : value ','
                                                      | sequence_values value ','
                                                      | sequence_values value", p) {
      if (p$length() == 3 && p$get(3) == ",") {
        p$set(1, p$get(2))
      } else if (typeof(p$get(2)) == "list" && !is.null(p$get(2)$unit)) {
        p$set(1, list(p$get(2), p$get(3)))
      } else {
        tmp <- p$get(2)
        tmp[[length(tmp) + 1]] <- p$get(3)
        p$set(1, tmp)
      }
    },
    p_value_quantity = function(doc="quantity : number UNIT", p) {
      p$set(1, list(value = p$get(2), unit = p$get(3)))
    },
    p_detailed_pointer = function(doc="pointer : POINTER '=' '(' STRING ',' DINT ')'
                                               | POINTER '=' STRING", p) {
      tmp <- list(action = "pointer", name = p$get(2))
      if (p$length() == 4) {
        tmp$value <- p$get(4)
        tmp$offset <- -1
      } else {
        tmp$value <- p$get(5)
        tmp$offset <- p$get(7)
      }
      p$set(1, tmp)
    },
    p_assignment = function(doc="assignment : IDENTIFIER '=' value", p) {
      tmp <- list(action = "assignment",
                  name   = p$get(2),
                  value  = p$get(4))
      p$set(1, tmp)
    },
    p_record = function(doc="record : assignment
                                    | pointer
                                    | nest_start
                                    | nest_end", p) {
      p$set(1, p$get(2))
    },
    p_nest_begin = function(doc = "nest_start : BEGIN_GROUP '=' IDENTIFIER
                                              | BEGIN_OBJECT '=' IDENTIFIER", p) {
      tmp <- list(action = "group_start",
                  name   = p$get(4))
      p$set(1, tmp)
    },
    p_nest_end = function(doc = "nest_end : END_GROUP '=' IDENTIFIER
                                          | END_GROUP
                                          | END_OBJECT '=' IDENTIFIER
                                          | END_OBJECT", p) {
      tmp <- list(action = "group_end")
      if (p$length() == 4) {
        tmp$name <- p$get(4)
      }
      p$set(1, tmp)
    },
    p_error = function(p) {
      cat("ERR")
      if (is.null(p)) cat("Syntax error at EOF")
      else            cat(sprintf("Syntax error at '%s'", p$value))
    }
  )
)
