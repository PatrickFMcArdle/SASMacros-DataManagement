/****************************************************
Program: removeCarriageReturns.sas
Author: Patrick F. McArdle
Date: 22 AUG 2025

Call with: %removeCarriageReturns(_fileRefIn, _fileRefOut);

This macro 
	  removes all carriage returns from quoted strings
   in the specified file

***************************************************/

%macro removeCarriageReturns(inFileRef, outFileRef);
data _null_;
  infile &inFileRef recfm=n ;
  file &outFileRef recfm=n;
  retain quoted 0 quote '"';
  input ch $char1. ;
  if ch=quote then quoted = mod(quoted+(ch=quote),2);
  if ch in ('0D'x,'0A'x) and quoted then put '|' ;
  else put ch $char1.;
run;
%mend removeCarriageReturns;


quit;
