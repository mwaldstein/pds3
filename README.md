
<!-- README.md is generated from README.Rmd. Please edit that file -->
pds3
====

[![Travis-CI Build Status](https://travis-ci.org/mwaldstein/pds3.svg?branch=master)](https://travis-ci.org/mwaldstein/pds3) [![codecov.io](https://codecov.io/github/mwaldstein/pds3/coverage.svg?branch=master)](https://codecov.io/github/mwaldstein/pds3?branch=master)

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

Implementation Notes
--------------------

Formal documentation will be created before release, but there are some general notes worth knowing for now -

-   Data Types:
    -   \[x\] Numbers, including those in alternate bases, are interpreted
    -   \[ \] Dates and times are converted to native formats
    -   \[x\] Values with units are returned as lists with value and unit fields
    -   \[x\] Pointers are returned as a list with a value and optionally an offset
-   Objects/Groups:
    -   \[x\] Created as nested lists
-   \[ \] Capture trailing data after label ends

Example
-------

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
