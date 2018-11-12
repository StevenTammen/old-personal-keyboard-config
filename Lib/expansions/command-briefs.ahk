Hotstring("(\\practice)1", "f_practice", 3, 0)
f_practice(matchObj)
{
	CommandBrief(matchObj)

	IniRead, nestingType, Status.ini, nestVars, nestingType
	
	if(nestingType = "normal")
	{
		nestingType = "practice"
		IniWrite, %nestingType%, Status.ini, nestVars, nestingType
	}
	else  ; nestingType = "practice"
	{
		nestingType = "normal"
		IniWrite, %nestingType%, Status.ini, nestVars, nestingType
	}
}
