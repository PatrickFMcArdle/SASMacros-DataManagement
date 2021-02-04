/* From Rick Wicklin blog */
/* Turns off ODS destinations put allows ods output */
/* Useful for simulations */

%macro ODSOff(); /* call prior to BY-group processing */
	ods graphics off;
	ods exclude all; /* all open destinations */
	ods results off; /* no updates to tree view */
	options nonotes; /* optional, but sometimes useful */
%mend;
