#If (!GetKeyState(rawState))

; ------------------- Base Layer -------------------

:*?: .::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right}.{Space}{%capSpacingDn%}{%regSpacingUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right}.{Space}
		}
		else
		{
			SendInput {Right}.{Space}{%capSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right}.{Space}{%capSpacingDn%}{%regSpacingUp%}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right}.{Space}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Right}.{Space}{%capSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return

:*?: ,::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right},{Space}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%capSpacingUp%}
		}
		else
		{
			SendInput {Right},{Space}{%regSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right},{Space}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%capSpacingUp%}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
; ------------------- Shift Layer -------------------
	
:*?b0: 2/::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}?{Space}{%capSpacingDn%}{%regSpacingUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}?{Space}
		}
		else
		{
			SendInput {Backspace 3}{Right}?{Space}{%capSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}?{Space}{%capSpacingDn%}{%regSpacingUp%}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}?{Space}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right}?{Space}{%capSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
:*?b0: 2,::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 2}{Right}—
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 2}{Right}—{%regSpacingDn%}{%capSpacingUp%}
		}
		else
		{
			SendInput {Backspace 2}{Right}—{%regSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 2}{Right}—{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 2}{Right}—{%regSpacingDn%}{%capSpacingUp%}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Backspace 2}{Right}—{%regSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
:*?b0: 2``::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}{!}{Space}{%capSpacingDn%}{%regSpacingUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}{!}{Space}
		}
		else
		{
			SendInput {Backspace 3}{Right}{!}{Space}{%capSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}{!}{Space}{%capSpacingDn%}{%regSpacingUp%}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}{!}{Space}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right}{!}{Space}{%capSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
; ------------------- Number Layer -------------------

:*?b0: 3 ::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}:{Space}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}:{Space}{%regSpacingDn%}{%capSpacingUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right}:{Space}{%regSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right}:{Space}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right}:{Space}{%regSpacingDn%}{%capSpacingUp%}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right}:{Space}{%regSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return

:*?b0: 31::

	; We need this line since dual-role keys act weird in hotstrings if you don't ensure they are up when you start processing
	KeyWait 1

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right};{Space}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right};{Space}{%regSpacingDn%}{%capSpacingUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right};{%Space%}{%regSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Backspace 3}{Right};{Space}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Backspace 3}{Right};{Space}{%regSpacingDn%}{%capSpacingUp%}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Backspace 3}{Right};{Space}{%regSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
#If