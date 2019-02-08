#If !(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())

; ------------------- {Enter}-{Spc} -------------------

/*
This is to correctly allow for unordered lists using - as the list marker.
You start new list items on new lines, preceded by -{Space}. We would like 
to pass through the capitalization from {Enter}, hence this hotstring.
*/
Hotstring("[\n]3c ", "f_listitem", 3, 0)
f_listitem(matchObj)
{
	SendInput {Space}{%regSpacingUp%}{%capSpacingDn%}
	return
}

; ------------------- _{Spc} -------------------

Hotstring("(?<!3u)2  ", "f_subscript", 3, 0)
f_subscript(matchObj)
{
	if(nestingType = "paired")
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
	}
	
	else ; nestingType = "unpaired"
	{
		IniRead, closingChars, Status.ini, nestVars, closingChars
		closingChars := RemoveClosingCharFromStack(closingChars)
		closingChars := AddClosingCharToStack("}", closingChars)
		IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		
		if(GetKeyState(regSpacing))
		{
			SendInput {Left}{BackSpace}{Right}{{}}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Left}{BackSpace}{Right}{{}}{%regSpacingDn%}{%capSpacingUp%}
			subscript_PassThroughCap := true
			IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
		}
		else
		{
			SendInput {Left}{BackSpace}{Right}{{}}{%regSpacingDn%}
		}
	}
	
	return
}

; ------------------- ^{Spc} -------------------

Hotstring("(?<!3u)3q ", "f_superscript", 3, 0)
f_superscript(matchObj)
{
	if(nestingType = "paired")
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
	}
	
	else ; nestingType = "unpaired"
	{
		IniRead, closingChars, Status.ini, nestVars, closingChars
		closingChars := RemoveClosingCharFromStack(closingChars)
		closingChars := AddClosingCharToStack("}", closingChars)
		IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		
		if(GetKeyState(regSpacing))
		{
			SendInput {Left}{BackSpace}{Right}{{}}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Left}{BackSpace}{Right}{{}}{%regSpacingDn%}{%capSpacingUp%}
			subscript_PassThroughCap := true
			IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
		}
		else
		{
			SendInput {Left}{BackSpace}{Right}{{}}{%regSpacingDn%}
		}
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

	if(nestingType = "paired")
	{
		if(nestLevel > 0)
		{
			SendInput {Backspace}{Right}{Space}
		}
		else
		{
			SendInput {Backspace}{Right}{Space}{%nestedPunctuationUp%}
		}
	}
	
	else ; nestingType = "unpaired"
	{
		if(nestLevel > 0)
		{
			SendInput {Space}
		}
		else
		{
			SendInput {Space}{%nestedPunctuationUp%}
		}
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

	if(nestingType = "paired")
	{
		if(nestLevel > 0)
		{
			SendInput {Backspace}{Right}{Space}
		}
		else
		{
			SendInput {Backspace}{Right}{Space}{%nestedPunctuationUp%}
		}
	}
	
	else ; nestingType = "unpaired"
	{
		if(nestLevel > 0)
		{
			SendInput {Space}
		}
		else
		{
			SendInput {Space}{%nestedPunctuationUp%}
		}
	}

	return

; ------------------- {Spc}~ -------------------

:*?b0: 3b::
	
	KeyWait b
	
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
	
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChars := RemoveClosingCharFromStack(closingChars)
	IniWrite, %closingChars%, Status.ini, nestVars, closingChars

	if(nestingType = "paired")
	{
		if(nestLevel > 0)
		{
			SendInput {Backspace}{Right}
		}
		else
		{
			SendInput {Backspace}{Right}{%nestedPunctuationUp%}
		}
	}
	
	else ; nestingType = "unpaired"
	{
		if(nestLevel <= 0)
		{
			SendInput {%nestedPunctuationUp%}
		}
	}

	return

#If
