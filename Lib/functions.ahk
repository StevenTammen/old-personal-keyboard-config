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
	
	if(GetKeyState(altLeader))
	{
		mods := mods . "Alt"
		SendInput {%altLeaderUp%}
	}
	
	sendLeaderUp := false
	if(GetKeyState(shiftLeader))
	{
		mods := mods . "Shift"
		sendLeaderUp := true
	}
	
	if(GetKeyState(winLeader))
	{
		mods := mods . "Win"
		SendInput {%winLeaderUp%}
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift. We need to put
	; the shiftLeader key back down if we get here and realize that only shift is down.
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


ExitNestedPair(spacingType, nestLevel)
{
	IniRead, subscript_PassThroughCap, Status.ini, nestVars, subscript_PassThroughCap
	IniRead, superscript_PassThroughCap, Status.ini, nestVars, superscript_PassThroughCap
	
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
		if(GetKeyState(nestedPunctuation))
		{
			if(GetKeyState(regSpacing))
			{			
				numModifierKeys := [openingChar, ClosingChar, "Left"]
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
				numModifierKeys := [openingChar, ClosingChar, "Left", nestedPunctuationDn]
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

	return numModifierKeys
}


numModifierKeys_Closing(closingChar, nestLevel)
{
	if(GetKeyState(nestedPunctuation))
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
	else
	{
		numModifierKeys := [closingChar]
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


WriteNestLevelIfApplicable_Opening(nestLevel)
{	
	actuallyNeedToWrite := (GetKeyState(numLeader) or GetKeyState(numModifier))
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		lastOpenPairDown := A_TickCount
		IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
	}
}

WriteNestLevelIfApplicable_Closing(nestLevel)
{	
	actuallyNeedToWrite := (GetKeyState(numLeader) or GetKeyState(numModifier))
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
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
		for i, value in ["h", "i", "e", "a", "w", "m", "t", "s", "r", "n", "Space"]
		{
			if((lastKey = value) and regSpacingIsDown) ; The keys above will only be a number if regSpacing is down. We don't want a leading space for these
			{
				specialCaseKeys.Push("Backspace")
			}
		}
	}
	return specialCaseKeys
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