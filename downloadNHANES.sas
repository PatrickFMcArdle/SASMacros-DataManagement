/***************************************************************
Name: downloadNHANES
Author: Patrick F. McArdle
Date: 2/28/2016

This macro downloads the specified NHANES file from the CDC website, 
and unpackages the transport files into the specified directory.

This macro utilizes the FCOPY function, which is only available in v9.4 and later.

year: 		The year of the NHANES data requested.  This is used in the URL on the CDC website
			and is in the format 2011-2012
fileNm:		The name of the file to be downloaded from the CDC website, e.g. DEMO_G
dirPath:	The directory path where the sas datasets will ultimately sit

e.g.

%let myNHANESdir = C:\NHANES;
%downloadNHANES(year=2011-2012, filenm=DEMO_G, dirPath=&myNHANESdir);

**************************************************************/

%macro downloadNHANES(year= , fileNm= , dirPath= );

* Create library;
libname _outLIB "&dirPath";

* Create filenames;
filename _bcin TEMP recfm=n ;
filename _bcout "&dirPath/&fileNm..XPT" recfm=n;

* Copy files from cdc website to the specified directory;
proc http method="get"  url="http://wwwn.cdc.gov/Nchs/Nhanes/&year/&fileNm..XPT"  out=_bcin; run;
data _null_;
   length msg $ 384;
   rc=fcopy('_bcin', '_bcout');
   if rc=0 then
      put 'Copied _bcin to _bcout.';
   else do;
      msg=sysmsg();
      put rc= msg=;
   end;
run;

* Unpack the transport files;                
libname _XPLib xport "&dirPath/&fileNm..XPT";
proc copy in=_XPLib out=_outLIB ; run;

* Delete the XPT file in the temp directory;
data _null_;
    fname="tempfile";
    rc=filename(fname, "&dirPath/&fileNm..XPT");
    if rc = 0 and fexist(fname) then
       rc=fdelete(fname);
    rc=filename(fname);
run;

filename _bcin clear;
filename _bcout clear;
libname _outLib clear;
libname _XPLib clear;

quit;
%mend;

quit;

