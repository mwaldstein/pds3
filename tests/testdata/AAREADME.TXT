PDS_VERSION_ID         = PDS3
RECORD_TYPE            = STREAM
OBJECT                 = TEXT
  PUBLICATION_DATE     = 2007-06-10
  INTERCHANGE_FORMAT   = ASCII
  NOTE                 = "Readme file for HiRISE EDR and
                          RDR Archive Volumes"
END_OBJECT             = TEXT
END

       HIGH RESOLUTION IMAGING SCIENCE EXPERIMENT EDR AND RDR
                            ARCHIVE VOLUME


AAREADME CONTENTS
=================
1. Introduction
2. Volume Format3. File Formats4. Volume Contents
5. Errata and Disclaimer
6. Contact Information

1. Introduction
===============
The High Resolution Imaging Science Experiment archive is comprised of 
a single volume for EDR and RDR products.
Experimental Data Record (EDR) Products are the permanent record of the 
raw images obtained by HiRISE. The EDRs have the properties of 
unprocessed and unrectified imaging maintaining the original spacecraft 
viewing orientation and optical distortion properties. As part of the 
EDR generation process, FELICS-compressed  (FELICS stands for Fast 
and Efficient Lossless image compression System) images are 
decompressed and organized as raster images.  EDRs are organized at the 
channel level with two EDRs needed for each operating CCD (Charge 
Couple Device). Up to 28 EDR products are needed to capture a single 
HiRISE observation. Maintaining an archive of EDR products enables 
reprocessing of the raw science observations as calibration and geometry 
processing routines improve. Investigators interested in applying 
advanced calibration methods or needing to understand the properties 
of the raw imaging will find the EDRs a useful product. However, most 
science investigators will be interested in using the RDR products as 
geometry and radiometric processing has been applied to these products.

RDR products are radiometrically-corrected images resampled to a standard
map projection. They are formatted and organized according to the 
standards of the PDS.  A RDR image is stored in the JPEG2000 (Joint 
Photographic Experts Group) format recently adopted by the PDS.  The 
JPEG2000 images are accompanied by a PDS detached label providing 
supporting information about the observation. There will typically be two 
RDR standard products per HiRISE observation a single-color RDR product 
built from the operating red-filter CCDs, and a three-color RDR product 
if the blue-green and near-infrared CCDs were additionally operating. The 
three-color RDR products will be released a time later then the release 
of the red-filter RDR products.
Several Software Inteface Specification (SIS) documents describe the 
HiRISE Data products and the contents of the volume. For more information
Refer to the following documents:
   Software Interface Specification for HiRISE Reduced Data Record 
   Products, JPL D-32006, May 15, 2007

   Software Interface Specification for HiRISE Experimental Data Record 
   Products, JPL D-32004, March 17, 2006
   
   HiRISE EDR & RDR Archive Volumes Software Interface Specification, 
   JPL D-32005, June 1, 2006

2. Volume Format
================

During active MRO mission operations the HiRISE Data Node will maintain 
an on-line archive of HiRISE standard products in a volume organization 
described as described in the HiRISE EDR and RDR volume SIS. The archive 
will be housed on a disk storage array using RAID technology.  At the end 
of the project, the Data Node server hardware and disk storage arrays will 
be delivered to the PDS Imaging Node for inclusion in their on-line 
services

3. File Format
==============

Document File Format:

Documents with the .TXT suffix exist in the Root, Index, Catalog, and 
Label subdirectories. They are ASCII files with embedded PDS labels.  
All document files will contain a stream record data type as 
recommended by the PDS. All lines are terminated with a carriage-return 
(ASCII 13)/linefeed (ASCII 10) sequence and will not exceed a total of 
80 ASCII characters in length (including the carriage-return/linefeed 
sequence.

Tabular File Format:

Tabular files (.TAB suffix) exist in the Index directory. Tabular files 
are ASCII character text files formatted for direct reading into many 
database management systems and spreadsheet applications.  Commas 
separate all fields. Non-numeric text fields are enclosed in double 
quotation marks (", ASCII 34). Fields are padded with spaces (inside 
the quotation marks for text fields) to ensure that all fields of a 
column are the same length.  Text fields are left justified and numeric 
fields are right justified. The START_BYTE and BYTES values listed in 
the PDS labels describing the tabular files do not include the commas 
between fields or the quotation marks surrounding text fields.  The 
records are of fixed length and the last two bytes of each record 
contain the carriage-return/linefeed sequence. This allows a table to 
be treated as a fixed-length record file and as a text file with 
embedded line delimiters.  See Appendix A for a description of the 
columns that make up the index files. Detached PDS labels describe 
all tabular files in the HiRISE EDR archive volumes.  The PDS 
detached labels have the same name as the tabular file but with the 
extension .LBL. For example, the INDEX.LAB file, located in the same 
directory, accompanies the INDEX.TAB file. Catalog and Include File 
Format:
Catalog (suffix .CAT) and label include files (suffix .FMT) exist in 
the root and CATALOG, and LABEL directories. They are formatted using

ODL "keyword=value" statements. The files are in a stream record 
(variable line size) format.  For catalog and include Files, the line 
length is limited to 72 characters the carriage-return and linefeed 
characters for a total length of 74 ASCII characters per line.

EDR Product File Format:

The HiRISE EDR products have attached PDS labels. The primary object 
within an EDR file is the IMAGE object containing the observation image 
data acquired by a CCD channel. A complete description of the file 
format and organization can be found in the HiRISE EDR SIS 
[JPL D-32004, 2005].

RDR Product File Format:

The HiRISE RDR products have detached PDS labels. The primary object 
within the RDR file is the IMAGE object containing the observation 
image that has been radiometrically corrected and geometrically 
resampled to a standard map projection. The image is organized 
according to the JPEG2000 JP2 file format standard. 

PDS Label Formats:

PDS labels are object-oriented. The object to which the label 
refers (e.g., IMAGE, TABLE, etc.) is denoted by a statement of 
the form:

    ^object = location

in which the carat character ('^', also called a pointer in this
context) indicates that the object starts at the given location.  
For an object in the same file as the label, the location is an 
integer representing the starting record number of the object (the 
first record in the file is record 1).  For an object located 
outside the label file, the location denotes the name of the file 
containing the object, along with the starting record or byte 
number.  For example:

    ^IMAGE = ("N1294562651_1.IMG",3)

indicates that the IMAGE object begins at record 3 of the file
N1294562651_1.IMG, in the same directory as the detached label file. 
 
Below is a list of the possible formats that use the ^object 
keyword.

    ^object = n
    ^object = n <BYTES>
    ^object = "filename.ext"
    ^object = ("filename.ext",n)
    ^object = ("filename.ext",n <BYTES>)

where:

    n         starting record or byte number of the object,
              counting from beginning of the file (record 1,
              byte 1); default is record number.
    <BYTES>   indicates that number given is in units of bytes.
    filename  upper-case file name.
    ext       upper-case file extension.

4. Volume Contents
==================

This section describes the contents of the HiRISE volumes, including 
file names, file contents, file types, and directory organization. 
A volume will contain both EDR and RDR products. The required 
directories are INDEX, LABEL, CATALOG, EDR, RDR, and EXTRAS.

FILE                                           CONTENTS

Top-level directory

| - AAREADME.TXT                      The file you are reading. This 
|                                     file describes the volume 
|                                     organization and contents.
|
| - ERRATA.TXT                        Description of known anomalies 
|                                     and errors present on this 
|                                     volume.
|
| - VOLDESC.CAT                       Description of the contents of
|                                     this volume in a PDS format 
|                                     readable by both humans and 
|                                     computers.
|
| - [CATALOG]                         Directory containing information 
|      |                              about the HiRISE dataset.
|      |
|      | - CATINFO.TXT                Description of the contents of
|      |                              this directory.
|      |
|      | - EDR_DS.CAT                 PDS data set catalog description 
|      |                              of the EDR Products.
|      |
|      | - RDR_DS.CAT                 PDS data set catalog description 
|      |                              of the RDR Products.
|      |
|      | - MRO_HOST.CAT               PDS instrument host (spacecraft) 
|      |                              catalog description of the MRO
|      |                              Spacecraft.
|      |
|      | - HIRISE_INST.CAT            PDS instrument catalog 
|      |                              description of the HiRISE 
|      |                              instrument.
|      |
|      | - MISSION.CAT                PDS mission catalog description 
|      |                              of the MRO mission.
|      |
|      | - PERSON.CAT                 PDS personnel catalog description 
|      |                              of HiRISE Team members and other 
|      |                              persons involved with generation 
|      |                              of HiRISE data products.
|      |
|      | - REF.CAT                    HiRISE-related references 
|      |                              mentioned in other *.CAT files.
|
| - [DOCUMENT]                        Directory containing additional 
|      |                              documents related to the HiRISE 
|      |                              dataset.
|      |
|      | - JP2INFO.TXT                Description of the JPEG2000 
|      |                              standard.
|      |
| - [INDEX]                           Directory containing index files 
|      |                              related to this volume.
|      |
|      | - INDXINFO.TXT               Description of the contents of
|      |                              this directory.
|      |
|      | - EDRCUMINDEX.TAB            Table listing of HiRISE EDR 
|      |                              products published to date.
|      |
|      | - EDRCUMINDEX.LBL            PDS detached lable that describes 
|      |                              EDRCUMINDEX.TAB.
|      |
|      | - EDRINDEX.TAB               Table listing of HiRISE EDR 
|      |                              products on this volume most 
|      |                              recently released.  The table is 
|      |                              identically formatted to the 
|      |                              EDRCUMINDEX.TAB file.
|      |
|      | - EDRINDEX.LBL               PDS detached lable that describes 
|      |                              EDRINDEX.TAB.
|      |
|      | - RDRCUMINDEX.TAB            Table listing of HiRISE RDR 
|      |                              products published to date.
|      |
|      | - RDRCUMINDEX.LBL            PDS detached lable that describes 
|      |                              RDRCUMINDEX.TAB.
|      |
|      | - RDRINDEX.TAB               Table listing of HiRISE RDR 
|      |                              products on this volume most 
|      |                              recently released.  The table is 
|      |                              identically formatted to the 
|      |                              RDRCUMINDEX.TAB file.
|      |
|      | - RDRINDEX.LBL               PDS detached lable that describes 
|      |                              RDRINDEX.TAB.
|
| - [LABEL]                           Directory containing additional 
|      |                              PDS-label include files related 
|      |                              to this volume.
|      |
|      | - LABINFO.TXT                Description of the contents of
|      |                              this directory.
|      |
|      | - SCIENCE_CHANNEL_TABLE.FMT  Include file describing the 
|      |                              Science Channel Table object in 
|      |                              the EDR product.
|      |
|      | - CPMM_ENGINEERING_TABLE.FMT Include file describing the 
|      |                              CPMM Engineering Table object in 
|      |                              the EDR product.
|      |
|      | - LOOKUP_TABLE.FMT           Include file describing the 
|      |                              Lookup Table used in the 
|      |                              translation from 14-bit to 8-bit 
|      |                              pixels.

5. Errata and Disclaimer
========================

A cumulative list of anomalies and errors is maintained in the file 
ERRATA.TXT at the root directory of this volume. 

Although considerable care has gone into making this volume, errors are 
both possible and likely. Users of the data are advised to exercise the 
same caution as they would when dealing with any other unknown data set.

6. Contact Information
=======================
For questions concerning the HiRISE images on this volume,
contact:

    PDS Imaging Node
    HiRISE Data Node
    Eric Eliason
    Charles P. Sonett Space Sciences
    1541 E. University Blvd.
    Tucson, AZ 85721

    WWW Site:  http://hirise.lpl.arizona.edu
    E-mail:    HiRISE-Contact@hirise.lpl.arizona.edu

For questions related to HiRISE and related data analysis contact:

    Dr. Alfred McEwen
    University of Arizona
    Charles P. Sonett Space Sciences
    1541 E. University Blvd
    Tucson, AZ 85721

    WWW Site:  http://hirise.lpl.arizona.edu/
    E-mail:    HiRISE-Contact@hirise.lpl.arizona.edu
