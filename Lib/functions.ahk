Modifiers(position, regKey, numKey)
{
	
	; Always arrange modifiers in the order of Ctrl > Alt > Shift > Win
	; Will allow for a dynamic function call below
	
	mods := ""
	
	if(GetKeyState(ctrlLeader))
	{
		mods := mods . "Ctrl"
		SendInput {%ctrlLeaderUp%}
	}
	else if(ctrlDownNoUp)
	{
		mods := mods . "Ctrl"
	}
	
	if(GetKeyState(altLeader))
	{
		mods := mods . "Alt"
		SendInput {%altLeaderUp%}
	}
	else if(altDownNoUp)
	{
		mods := mods . "Alt"
	}
	
	sendLeaderUp := false
	if(GetKeyState(shiftLeader))
	{
		mods := mods . "Shift"
		sendLeaderUp := true
	}
	else if(shiftDownNoUp)
	{
		mods := mods . "Shift"
	}
	
	if(GetKeyState(winLeader))
	{
		mods := mods . "Win"
		SendInput {%winLeaderUp%}
	}
	else if(winDownNoUp)
	{
		mods := mods . "Win"
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift.
	if(mods = "Shift")
	{
		return false
	}
	else if(mods = "")
	{
		return false
	}
	else
	{
	
		if(GetKeyState(numLeader))
		{
			key := numKey
			SendInput {%numLeaderUp%}		
		}
		else if(numDownNoUp)
		{
			key := numKey	
		}
		else
		{
			key := regKey
		}
		
		if(sendLeaderUp)
		{
			SendInput {%shiftLeaderUp%}
		}
		
		%position%_%mods%(key)
		return true
	}
}


AddClosingCharToStack(closingChar, closingChars)
{
	closingChars := closingChar . closingChars
	return closingChars
}


GetClosingCharFromStack(closingChars)
{
	closingChar := SubStr(closingChars, 1, 1)
	return closingChar
}


RemoveClosingCharFromStack(closingChars)
{
	closingChars := SubStr(closingChars, 2)
	return closingChars
}


AddKeyUp(keys, keyUp) 
{
	newKeys := []
	Loop % keys.Length()
	{
	    newKeys.Push(keys[A_Index])
	}
	newKeys.Push(keyUp)
	return newKeys
}


DealWithSubscriptAndSuperscriptPassThrough()
{
	subscript_PassThroughCap := false
	IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
		
	superscript_PassThroughCap := false
	IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap
}


ExitNestedPair(spacingType, nestLevel, closingChar)
{
	IniRead, subscript_PassThroughCap, Status.ini, nestVars, subscript_PassThroughCap
	IniRead, superscript_PassThroughCap, Status.ini, nestVars, superscript_PassThroughCap
	
	IniRead, nestingType, Status.ini, nestVars, nestingType
	
	if(nestingType = "paired")
	{
		if(subscript_PassThroughCap)
		{
			subscript_PassThroughCap := false
			IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
			
			defaultKeys := ["Right", "Space", capSpacingDn]
			regSpacingKeys := ["Backspace", "Right", "Space", regSpacingUp, capSpacingDn]
			capSpacingKeys := ["Backspace", "Right", "Space"]
		}
		else if(superscript_PassThroughCap)
		{
			superscript_PassThroughCap := false
			IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap

			defaultKeys := ["Right", "Space", capSpacingDn]
			regSpacingKeys := ["Backspace", "Right", "Space", regSpacingUp, capSpacingDn]
			capSpacingKeys := ["Backspace", "Right", "Space"]
		}
		else
		{
			defaultKeys := ["Right", "Space", regSpacingDn]
			regSpacingKeys := ["Backspace", "Right", "Space"]
			capSpacingKeys := ["Backspace", "Right", "Space"]
		}
	}
	
	else ; nestingType = "unpaired"
	{	
		if(subscript_PassThroughCap)
		{
			subscript_PassThroughCap := false
			IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
			
			defaultKeys := [closingChar, "Space", capSpacingDn]
			regSpacingKeys := ["Backspace", closingChar, "Space", regSpacingUp, capSpacingDn]
			capSpacingKeys := ["Backspace", closingChar, "Space"]
		}
		else if(superscript_PassThroughCap)
		{
			superscript_PassThroughCap := false
			IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap

			defaultKeys := [closingChar, "Space", capSpacingDn]
			regSpacingKeys := ["Backspace", closingChar, "Space", regSpacingUp, capSpacingDn]
			capSpacingKeys := ["Backspace", closingChar, "Space"]
		}
		else
		{
			defaultKeys := [closingChar, "Space", regSpacingDn]
			regSpacingKeys := ["Backspace", closingChar, "Space"]
			capSpacingKeys := ["Backspace", closingChar, "Space"]
		}
	}
	
	; Exit the nested state if the nestLevel is zero
	if(nestLevel = 0)
	{
		defaultKeys := AddKeyUp(defaultKeys, nestedPunctuationUp) 
		regSpacingKeys := AddKeyUp(regSpacingKeys, nestedPunctuationUp) 
		capSpacingKeys := AddKeyUp(capSpacingKeys, nestedPunctuationUp) 
	}	
	
	; Return the correct keys for the spacing type specified in the function call
	if(spacingType = "default")
	{
		return defaultKeys
	}
	else if(spacingType = "regSpacing")
	{
		return regSpacingKeys
	}
	else
	{
		return capSpacingKeys
	}
}


shiftModifierKeys_Letter(letter)
{
	if(GetKeyState(rawLeader))
	{			
		shiftModifierKeys := [letter, rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		shiftModifierKeys := [letter, regSpacingUp]
	}
	else if(GetKeyState(capSpacing))
	{
		shiftModifierKeys := [letter, capSpacingUp]
	}
	else
	{
		shiftModifierKeys := [letter]
	}

	return shiftModifierKeys
}


numModifierKeys_Number(num)
{
	numModifierKeys := GetSpecialCaseKeys()

	if(GetKeyState(rawState))
	{
		numModifierKeys := [num]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifierKeys := ["Backspace", num, rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifierKeys.Push(num, "Space")
	}
	else if(GetKeyState(capSpacing))
	{
		numModifierKeys.Push(num, "Space", regSpacingDn, capSpacingUp)
	}
	else
	{
		numModifierKeys.Push("Space", num, "Space", regSpacingDn)
	}

	return numModifierKeys
}


numModifierKeys_Opening_PassThroughCap(openingChar, closingChar)
{
	if(GetKeyState(rawState))
	{
		numModifierKeys := [openingChar]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifierKeys := ["Backspace", openingChar, rawLeaderUp]
	}
	else
	{
		IniRead, nestingType, Status.ini, nestVars, nestingType
	
		if(nestingType = "paired")
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, closingChar, "Left"]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, closingChar, "Left"]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, closingChar, "Left", regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, closingChar, "Left", nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, closingChar, "Left", nestedPunctuationDn]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, closingChar, "Left", regSpacingDn, nestedPunctuationDn]
				}
			}
		}
		
		else  ; nestingType = "unpaired"
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, nestedPunctuationDn]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, regSpacingDn, nestedPunctuationDn]
				}
			}
		}
	}

	return numModifierKeys
}


numModifierKeys_Opening_NoCap(openingChar, closingChar)
{
	if(GetKeyState(rawState))
	{
		numModifierKeys := [openingChar]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifierKeys := ["Backspace", openingChar, rawLeaderUp]
	}
	else
	{
		IniRead, nestingType, Status.ini, nestVars, nestingType
	
		if(nestingType = "paired")
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, closingChar, "Left"]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, closingChar, "Left", regSpacingDn, capSpacingUp]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, closingChar, "Left", regSpacingDn]
				}

			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, closingChar, "Left", nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, closingChar, "Left", regSpacingDn, nestedPunctuationDn, capSpacingUp]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, closingChar, "Left", regSpacingDn, nestedPunctuationDn]
				}
			}
		}
		
		else  ; nestingType = "unpaired"
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, regSpacingDn, capSpacingUp]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, regSpacingDn]
				}

			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := [openingChar, nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := [openingChar, regSpacingDn, nestedPunctuationDn, capSpacingUp]
				}
				else
				{
					numModifierKeys := ["Space", openingChar, regSpacingDn, nestedPunctuationDn]
				}
			}
		}
	}

	return numModifierKeys
}


; This function defines generic closing behavior, similar to ). 
; When not nested, however, the specific closing character is sent.
numModifierKeys_Closing(specificClosingChar, generalClosingChar, nestLevel)
{
	if(GetKeyState(nestedPunctuation))
	{
		IniRead, nestingType, Status.ini, nestVars, nestingType
		
		if(nestingType = "paired")
		{
			if(nestLevel > 0)
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := ["Backspace", "Right", "Space"]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := ["Backspace", "Right", "Space"]
				}
				else
				{
					numModifierKeys := ["Right", "Space", regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := ["Backspace", "Right", "Space", nestedPunctuationUp]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := ["Backspace", "Right", "Space", nestedPunctuationUp]
				}
				else
				{
					numModifierKeys := ["Right", "Space", regSpacingDn, nestedPunctuationUp]
				}
			}
		}
		
		else  ; nestingType = "unpaired"
		{
			if(nestLevel > 0)
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := ["Backspace", generalClosingChar, "Space"]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := ["Backspace", generalClosingChar, "Space"]
				}
				else
				{
					numModifierKeys := [generalClosingChar, "Space", regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					numModifierKeys := ["Backspace", generalClosingChar, "Space", nestedPunctuationUp]
				}
				else if(GetKeyState(capSpacing))
				{
					numModifierKeys := ["Backspace", generalClosingChar, "Space", nestedPunctuationUp]
				}
				else
				{
					numModifierKeys := [generalClosingChar, "Space", regSpacingDn, nestedPunctuationUp]
				}
			}
		}
	}
	else
	{
		numModifierKeys := [specificClosingChar]
	}

	return numModifierKeys
}


numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
{
	if(GetKeyState(regSpacing))
	{			
		numModifierKeys := regSpacingKeys
	}
	else if(GetKeyState(capSpacing))
	{
		numModifierKeys := capSpacingKeys
	}
	else
	{
		numModifierKeys := defaultKeys
	}
	return numModifierKeys
}


WriteNestVarsIfApplicable_Opening(nestLevel, closingChar)
{	
	actuallyNeedToWrite := (GetKeyState(numLeader) or numDownNoUp)
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		lastOpenPairDown := A_TickCount
		IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
		
		IniRead, closingChars, Status.ini, nestVars, closingChars
		closingChars := AddClosingCharToStack(closingChar, closingChars)
		IniWrite, %closingChars%, Status.ini, nestVars, closingChars
	}
}

WriteNestVarsIfApplicable_Closing(nestLevel, closingChars)
{	
	actuallyNeedToWrite := (GetKeyState(numLeader) or numDownNoUp)
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		
		; remove closing character from stack
		closingChars := RemoveClosingCharFromStack(closingChars)
		IniWrite, %closingChars%, Status.ini, nestVars, closingChars
	}
}


GetSpecialCaseKeys()
{
	lastKey := A_PriorHotkey
	
	if((lastKey = "*3") or (lastKey = "*3 Up"))
	{
		lastKey := lastRealKeyDown
	}
	else
	{
		lastKey := Dual.cleanKey(lastKey)
	}

	regSpacingIsDown := GetKeyState(regSpacing)


	specialCaseKeys := []

	if((lastKey = "c") and regSpacingIsDown)
	{
		specialCaseKeys.Push("Backspace", "–")   ; replace hyphens with en dashes between numbers
	}
	else
	{
		for i, value in ["h", "i", "e", "a", "w", "m", "t", "s", "r", "n", "2"]
		{
			if((lastKey = value) and regSpacingIsDown) ; The keys above will only be a number if regSpacing is down. We don't want a leading space for these
			{
				specialCaseKeys.Push("Backspace")
			}
		}
	}
	return specialCaseKeys
}


VimWindowActive()
{
	; List of executable files (ahk_exe) that implement Vim behavior.
	; Vim mode will pass through appropriate keypresses and let these programs
	; handle the actual behavior.
	vimExecutables := ["emacs.exe", "mintty.exe", "clion64.exe", "idea64.exe", "pycharm64.exe"]
	
	for index, executable in vimExecutables
	{
		window := "ahk_exe " . executable
		if(WinActive(window))
		{
			return true
		}
	}
	
	return false
}


IDEWindowActive()
{
	; List of IDE programs
	IDEs := ["clion64.exe", "idea64.exe", "pycharm64.exe"]
	
	for index, executable in IDEs
	{
		window := "ahk_exe " . executable
		if(WinActive(window))
		{
			return true
		}
	}
	
	return false
}


TerminalActive()
{
	; List of terminal programs
	programs := ["mintty.exe"]
	
	for index, executable in programs
	{
		window := "ahk_exe " . executable
		if(WinActive(window))
		{
			return true
		}
	}
	
	return false
}


NeedToDragNonText()
{
	; List of programs that need to drag things that aren't 
	; text, like icons and what have you. Easier to define 
	; this negation than all the programs that need to drag text.
	; explorer.exe includes taskbar dragging and desktop dragging
	; as well as the file manager icon dragging, evidently 
	; (according to the window spy).
	programs := ["explorer.exe"]
	
	for index, executable in programs
	{
		window := "ahk_exe " . executable
		if(WinActive(window))
		{
			return true
		}
	}
	
	return false
}


; -----------------------------------------------------------------------------------------------------------


GetLastChar()
{
	Clipboard :=
	SendInput, +{Left}^c
	ClipWait, 0.1
}


InTextBox()
{
	clipboardCache := Clipboard

	; Try to highlight the character to the left:
	; if something gets highlighted, then we are definitely in a text box.
	GetLastChar()

	if (Clipboard = "")
	{
		Clipboard := clipboardCache
		return false
	}
	else
	{
		Clipboard := clipboardCache
		SendInput {Right}
		return true
	}
}


EndCommandMode()
{
	IniRead, command_PassThroughAutospacing, Status.ini, commandVars, command_PassThroughAutospacing
	IniRead, inTextBox, Status.ini, commandVars, inTextBox

	if(command_PassThroughAutospacing = regSpacing)
	{
		SendInput {regSpacing Down}
	}
	else if(command_PassThroughAutospacing = capSpacing)
	{
		SendInput {capSpacing Down}
	}
	
	SendInput {rawLeader Up}

	if(!inTextBox)
	{
		SendInput {Enter}
	}

	return
}

