#If (!GetKeyState(rawState))

; ------------------- _{Spc} -------------------

:*?b0:2; ::

	if(GetKeyState(regSpacing))
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}
	}
	else if(GetKeyState(capSpacing))
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}{%regSpacingDn%}{%capSpacingUp%}
		subscript_PassThroughCap := true
		IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
	}
	else
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}{%regSpacingDn%}
	}

	return

; ------------------- *{Spc} -------------------
	
:*?b0:3l ::

	KeyWait Space

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	if(nestLevel > 0)
	{
		SendInput {Backspace 3}{Right}{Space}
	}
	else
	{
		SendInput {Backspace 3}{Right}{Space}{%nestedPunctuationUp%}
	}

	return
	
; ------------------- ^{Spc} -------------------

:*?b0:3q ::

	if(GetKeyState(regSpacing))
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}
	}
	else if(GetKeyState(capSpacing))
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}{%regSpacingDn%}{%capSpacingUp%}
		superscript_PassThroughCap := true
		IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap
	}
	else
	{
		SendInput {Backspace 3}{Right}{{}{}}{Left}{%regSpacingDn%}
	}

	return
	
; ------------------- ={Spc} -------------------

:*?b0:3g ::

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	if(nestLevel > 0)
	{
		SendInput {Backspace 2}{Right}{Space}
	}
	else
	{
		SendInput {Backspace 2}{Right}{Space}{%nestedPunctuationUp%}
	}

	return

; ------------------- {Spc}~ -------------------

:*?b0: 1.::

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

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