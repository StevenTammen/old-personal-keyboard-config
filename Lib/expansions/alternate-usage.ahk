#If !(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())

; ------------------- _{Spc} -------------------

Hotstring("[^\\]2  ", "f_subscript", 3, 0)
f_subscript(matchObj)
{
	if(GetKeyState(regSpacing))
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}
	}
	else if(GetKeyState(capSpacing))
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}{%regSpacingDn%}{%capSpacingUp%}
		subscript_PassThroughCap := true
		IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
	}
	else
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}{%regSpacingDn%}
	}

	return
}

; ------------------- ^{Spc} -------------------

Hotstring("[^\\]3q ", "f_superscript", 3, 0)
f_superscript(matchObj)
{
	if(GetKeyState(regSpacing))
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}
	}
	else if(GetKeyState(capSpacing))
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}{%regSpacingDn%}{%capSpacingUp%}
		superscript_PassThroughCap := true
		IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap
	}
	else
	{
		SendInput {Backspace 2}{Right}{{}{}}{Left}{%regSpacingDn%}
	}

	return
}

; ------------------- *{Spc} -------------------
	
:*?b0:3l ::

	KeyWait Space

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
	
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChars := RemoveClosingCharFromStack(closingChars)
	IniWrite, %closingChars%, Status.ini, nestVars, closingChars

	if(nestLevel > 0)
	{
		SendInput {Backspace}{Right}{Space}
	}
	else
	{
		SendInput {Backspace}{Right}{Space}{%nestedPunctuationUp%}
	}

	return
	
; ------------------- ={Spc} -------------------

:*?b0:3g ::

	KeyWait Space

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
	
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChars := RemoveClosingCharFromStack(closingChars)
	IniWrite, %closingChars%, Status.ini, nestVars, closingChars

	if(nestLevel > 0)
	{
		SendInput {Backspace}{Right}{Space}
	}
	else
	{
		SendInput {Backspace}{Right}{Space}{%nestedPunctuationUp%}
	}

	return

; ------------------- {Spc}~ -------------------

:*?b0: 1.::
	
	KeyWait .
	
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
	
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChars := RemoveClosingCharFromStack(closingChars)
	IniWrite, %closingChars%, Status.ini, nestVars, closingChars

	if(nestLevel > 0)
	{
		SendInput {Backspace 2}{Right}
	}
	else
	{
		SendInput {Backspace 2}{Right}{%nestedPunctuationUp%}
	}

	return

#If