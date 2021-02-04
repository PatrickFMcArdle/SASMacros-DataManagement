%macro ODSOn(); /* call after BY-group processing */
ods graphics on;
ods exclude none;
ods results on;
options notes;
%mend;
