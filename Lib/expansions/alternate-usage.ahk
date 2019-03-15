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
	KeyWait Space
	SendInput {%regSpacingUp%}{%capSpacingDn%}
	return
}

/*
Same thing except for one nest level in
*/
Hotstring("[\n] 3c ", "f_listitem1", 3, 0)
f_listitem1(matchObj)
{
	KeyWait Space
	SendInput {Left 2}{Space 2}{Right 2}{%regSpacingUp%}{%capSpacingDn%}
	return
}

/*
Same thing except for two nest levels in
*/
Hotstring("[\n]  3c ", "f_listitem2", 3, 0)
f_listitem2(matchObj)
{
	KeyWait Space
	SendInput {Left 2}{Space 6}{Right 2}{%regSpacingUp%}{%capSpacingDn%}
	return
}

/*
Same thing except for three nest levels in
*/
Hotstring("[\n]   3c ", "f_listitem3", 3, 0)
f_listitem3(matchObj)
{
	KeyWait Space
	SendInput {Left 2}{Space 8}{Right 2}{%regSpacingUp%}{%capSpacingDn%}
	return
}


; Similar to hotstrings for Org headlines (see below)

:*?b0:`n3ca::
	KeyWait a
	SendInput {Backspace}{Space}{%capSpacingDn%}
	return
:*?b0:`n3ce::
	KeyWait e
	SendInput {Backspace}{Left}{Space 3}{Right}{Space}{%capSpacingDn%}
	return
:*?b0:`n3ci::
	KeyWait i
	SendInput {Backspace}{Left}{Space 6}{Right}{Space}{%capSpacingDn%}
	return
:*?b0:`n3ch::
	KeyWait h
	SendInput {Backspace}{Left}{Space 9}{Right}{Space}{%capSpacingDn%}
	return

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

; ------------------- Org headlines -------------------

RemoveAsteriskPairing()
{
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
}

:*?b0:`n3la::
	KeyWait a
	SendInput {Backspace}
	RemoveAsteriskPairing()
	SendInput {Space}{%capSpacingDn%}
	return

:*?b0:`n3le::
	KeyWait e
	SendInput {Backspace}
	RemoveAsteriskPairing()
	SendInput {*}{Space}{%capSpacingDn%}
	return
	
:*?b0:`n3li::
	KeyWait i
	SendInput {Backspace}
	RemoveAsteriskPairing()
	SendInput {*}{*}{Space}{%capSpacingDn%}
	return
	
:*?b0:`n3lh::
	KeyWait h
	SendInput {Backspace}
	RemoveAsteriskPairing()
	SendInput {*}{*}{*}{Space}{%capSpacingDn%}
	return
	
; Can also use for getting ****.
:*?b0:3l    ::
	KeyWait Space
	SendInput {Backspace}{*}{Space}
	return

; Can also use for getting ***.
:*?b0:3l   ::
	KeyWait Space
	SendInput {Backspace}{*}{Space}
	return
	
; Can also use for getting **.
:*?b0:3l  ::
	KeyWait Space
	SendInput {Backspace}{*}{Space}
	return
	
; Can also use for getting *.
:*?b0:3l ::
	KeyWait Space
	RemoveAsteriskPairing()
	SendInput {Space}
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
