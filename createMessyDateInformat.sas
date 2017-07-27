/****************************************************
Program: createMessyDateInformat.sas
Author: Patrick F. McArdle
Date: 25 July 2017

This creates a new informat in the WORK library that 
transforms a messy date field into a SAS date

It assumes if delimited digits are given, month preceeds days (mmddyyyy).
This is a limitaion of the anydtdte informat.

If 4 digits are given, it assumes it is a year and creates a date 
based on January 1 of that year.

***************************************************/


proc format;   
	invalue messyDate
		"/^\d{1,2}\D\d{1,2}\D\d{4}/" (regexp)	= [mmddyy10.]    
		"/^\d{4}/" (regexp) 					= [B8601DA4.]
		other 									= [anydtdte32.]
	;
run;

quit;


