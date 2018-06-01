
<!-- README.md is generated from README.Rmd. Please edit that file -->
pds3
====

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/pds3)](https://cran.r-project.org/package=pds3) [![Travis-CI Build Status](https://travis-ci.org/mwaldstein/pds3.svg?branch=master)](https://travis-ci.org/mwaldstein/pds3) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mwaldstein/pds3?branch=master&svg=true)](https://ci.appveyor.com/project/mwaldstein/pds3) [![codecov.io](https://codecov.io/github/mwaldstein/pds3/coverage.svg?branch=master)](https://codecov.io/github/mwaldstein/pds3?branch=master)

pds3 reads [PDS3](https://pds.jpl.nasa.gov/datastandards/pds3/) files, a standard published by JPL and used throughout NASA space missions. While PDS3 is being supplanted by PDS4, a XML based standard, PDS3 is still being used and is needed for accessing historic data.

References
----------

-   [PDS3 Data Standards](https://pds.jpl.nasa.gov/datastandards/pds3/)
-   [PDS3 Standards Reference](https://pds.jpl.nasa.gov/datastandards/pds3/standards/)
-   [PDS Data Archive](https://pds.jpl.nasa.gov/)

Installation
------------

pds3 is not yet stable enough to be on [CRAN](https://CRAN.R-project.org). You can install the development version using devtools with:

``` r
devtools::install_github("mwaldstein/pds3")
```

Basic Use
---------

``` r
pds_label <- '
PDS_VERSION_ID                = PDS3

/* FILE CHARACTERISTICS */

RECORD_TYPE                   = FIXED_LENGTH
RECORD_BYTES                  = 3296
FILE_RECORDS                  = 3072

/* POINTERS TO DATA OBJECTS */

^IMAGE                        = "JNCR_2016345_03C00002_V01.IMG"

/* IDENTIFICATION DATA ELEMENTS */

FILE_NAME                     = "JNCR_2016345_03C00002_V01.IMG"
SPACECRAFT_NAME               = JUNO
MISSION_PHASE_NAME            = "SCIENCE ORBITS"
TARGET_NAME                   = JUPITER
INSTRUMENT_ID                 = "JNC"
INSTRUMENT_HOST_NAME          = "JUNO"
INSTRUMENT_NAME               = "JUNO EPO CAMERA"
PRODUCER_ID                   = JUNO_JUNOCAM_TEAM
DATA_SET_ID                   = "JUNO-J-JUNOCAM-3-RDR-L1A-V1.0"
STANDARD_DATA_PRODUCT_ID      = "JUNOCAM-RDR"
PRODUCT_CREATION_TIME         = 2017-05-31T18:42:49
PRODUCT_VERSION_ID            = "01"
PRODUCT_ID                    = "JNCR_2016345_03C00002_V01"
SOURCE_PRODUCT_ID             = "3D-0900010002-2016-349T17.19.13"
START_TIME                    = 2016-12-10T17:15:14.358
IMAGE_TIME                    = 2016-12-10T17:15:14.358
STOP_TIME                     = 2016-12-10T17:15:17.350
SPACECRAFT_CLOCK_START_COUNT  = "534662301:164"
SPACECRAFT_CLOCK_STOP_COUNT   = "N/A"

OBJECT                        = IMAGE
  LINES                       = 3072
  LINE_SAMPLES                = 1648
  SAMPLE_TYPE                 = UNSIGNED_INTEGER
  LINE_PREFIX_BYTES           = 0
  LINE_SUFFIX_BYTES           = 0
  SAMPLE_BITS                 = 16
  SAMPLE_BIT_MASK             = 2#1111111111111111#
  MD5_CHECKSUM                = "9ab98a1df127b82047e073e569cff24f"
END_OBJECT                    = IMAGE
END
'

lbl_object <- pds3_read(pds_label)
str(lbl_object)
#> List of 3
#>  $ label     : chr "\nPDS_VERSION_ID                = PDS3\n\n/* FILE CHARACTERISTICS */\n\nRECORD_TYPE                   = FIXED_L"| __truncated__
#>  $ extra_data: chr ""
#>  $ odl       :List of 25
#>   ..$ PDS_VERSION_ID              : chr "PDS3"
#>   ..$ RECORD_TYPE                 : chr "FIXED_LENGTH"
#>   ..$ RECORD_BYTES                : int 3296
#>   ..$ FILE_RECORDS                : int 3072
#>   ..$ ^IMAGE                      :List of 2
#>   .. ..$ value : chr "JNCR_2016345_03C00002_V01.IMG"
#>   .. ..$ offset: num -1
#>   ..$ FILE_NAME                   : chr "JNCR_2016345_03C00002_V01.IMG"
#>   ..$ SPACECRAFT_NAME             : chr "JUNO"
#>   ..$ MISSION_PHASE_NAME          : chr "SCIENCE ORBITS"
#>   ..$ TARGET_NAME                 : chr "JUPITER"
#>   ..$ INSTRUMENT_ID               : chr "JNC"
#>   ..$ INSTRUMENT_HOST_NAME        : chr "JUNO"
#>   ..$ INSTRUMENT_NAME             : chr "JUNO EPO CAMERA"
#>   ..$ PRODUCER_ID                 : chr "JUNO_JUNOCAM_TEAM"
#>   ..$ DATA_SET_ID                 : chr "JUNO-J-JUNOCAM-3-RDR-L1A-V1.0"
#>   ..$ STANDARD_DATA_PRODUCT_ID    : chr "JUNOCAM-RDR"
#>   ..$ PRODUCT_CREATION_TIME       : POSIXlt[1:1], format: "2017-05-31 18:42:49"
#>   ..$ PRODUCT_VERSION_ID          : chr "01"
#>   ..$ PRODUCT_ID                  : chr "JNCR_2016345_03C00002_V01"
#>   ..$ SOURCE_PRODUCT_ID           : chr "3D-0900010002-2016-349T17.19.13"
#>   ..$ START_TIME                  : POSIXlt[1:1], format: "2016-12-10 17:15:14"
#>   ..$ IMAGE_TIME                  : POSIXlt[1:1], format: "2016-12-10 17:15:14"
#>   ..$ STOP_TIME                   : POSIXlt[1:1], format: "2016-12-10 17:15:17"
#>   ..$ SPACECRAFT_CLOCK_START_COUNT: chr "534662301:164"
#>   ..$ SPACECRAFT_CLOCK_STOP_COUNT : chr "N/A"
#>   ..$ IMAGE                       :List of 8
#>   .. ..$ LINES            : int 3072
#>   .. ..$ LINE_SAMPLES     : int 1648
#>   .. ..$ SAMPLE_TYPE      : chr "UNSIGNED_INTEGER"
#>   .. ..$ LINE_PREFIX_BYTES: int 0
#>   .. ..$ LINE_SUFFIX_BYTES: int 0
#>   .. ..$ SAMPLE_BITS      : int 16
#>   .. ..$ SAMPLE_BIT_MASK  : int 65535
#>   .. ..$ MD5_CHECKSUM     : chr "9ab98a1df127b82047e073e569cff24f"
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
