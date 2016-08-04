/****************************************************
Program: getFromGitHub.sas
Author: Patrick F. McArdle
Date: 2 August 2016

This macros retrieves the specified file from the master
branch of specified GitHub respository.

Example: retreive this file from my GitHub repository
and put in on the local C drive

filename _fileOut "C:\getFromGitHub.sas";
%getFromGitHub(username=PatrickFMcArdle, repo=SASMacros-DataManagement, fileIn=getFromGitHub.sas, fileOut=_fileOut);

***************************************************/

%macro getFromGitHub(username,repo,fileIn,fileOut);

* Get current version of code from GitHub;
proc http
	url="https://github.com/&username/&repo/raw/master/&fileIn"
	method="GET"
	out=&fileOut;
run;

%mend getFromGitHub;
quit;
				
