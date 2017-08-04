/****************************************************
Program: getFromGitHub.sas
Author: Patrick F. McArdle
Date: 4 August 2017

This user defined function creates a BMI calcuator.

Inputs:
	HIEGHT in ft' in" format (e.g. 5' 10")
	WEIGHT in pounds

***************************************************/

proc fcmp outlib=WORK.funcs.calc; 
	function calcBMI(_HEIGHT $, _WEIGHT) ;

		* Parse Height;
		if _HEIGHT ne "" then do;
			_FT = input(substr(_HEIGHT,1,1), best12.);
			_IN = input(substr(_HEIGHT,index(_HEIGHT,"'")+1,index(_HEIGHT,'"')-index(_HEIGHT,"'")-1), best12.);
			_HIN = _FT*12 + _IN;
			end;

		* Calculate BMI;
		_BMI = (_WEIGHT*0.45359237)/((_HIN*0.0254)**2);

		return (_BMI);
	endsub;
run;
quit;