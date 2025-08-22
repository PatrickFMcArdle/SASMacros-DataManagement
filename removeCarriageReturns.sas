/*******************************
This macro removes carriage return from quoted strings within
a specified file

It is helpful to remove do this before loading into a dataset

Call:
%removeCarriageReturns(_my_out, _fixed);

*****************************/


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
