global language := "java"


; ------------------- language switching -------------------

Hotstring("(\\java)1", "f_java", 3, 0)
f_java(matchObj)
{
	CodeBrief_language(matchObj, "java")
}

Hotstring("(\\python)1", "f_python", 3, 0)
f_python(matchObj)
{
	CodeBrief_language(matchObj, "python")
}


; ------------------- blocks -------------------

Hotstring("(\\while)1", "f_while", 3, 0)
f_while(matchObj)
{
	if(language = "java")
	{
		CodeBrief(matchObj, "while () {{}{Enter}{}} // while{Up}{End}{Left 3}")
	}
	else if(language = "python")
	{
		CodeBrief(matchObj, "while ():{Left 2}")
	}
}


