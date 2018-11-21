Hotstring("(\\paired)1", "f_paired", 3, 0)
f_paired(matchObj)
{
	CommandBrief(matchObj)

	IniRead, nestingType, Status.ini, nestVars, nestingType
	
	if(nestingType = "paired")
	{
		nestingType = "unpaired"
		IniWrite, %nestingType%, Status.ini, nestVars, nestingType
	}
	else  ; nestingType = "unpaired"
	{
		nestingType = "paired"
		IniWrite, %nestingType%, Status.ini, nestVars, nestingType
	}
}
