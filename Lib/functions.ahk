WriteNestLevelIfApplicable_Opening(nestLevel)
{	
	actuallyNeedToWrite := (GetKeyState("VK88") or GetKeyState("VK8C"))
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		lastOpenPairDown := A_TickCount
		IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
	}
}

WriteNestLevelIfApplicable_Closing(nestLevel)
{	
	actuallyNeedToWrite := (GetKeyState("VK88") or GetKeyState("VK8C"))
	
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
	}
}


VK88Keys_Number(num, lastRealKeyDown)
{
	VK88Keys := GetSpecialCaseKeys(lastRealKeyDown)

	if(GetKeyState("VK97"))
	{
		VK88Keys := [num, "VK88 Up"]
	}
	else if(GetKeyState("VK98"))
	{			
		VK88Keys.Push(num, "Space", "VK88 Up")
	}
	else if(GetKeyState("VK99"))
	{
		VK88Keys.Push(num, "Space", "VK98 Down", "VK99 Up", "VK88 Up")
	}
	else
	{
		VK88Keys.Push("Space", num, "Space", "VK98 Down", "VK88 Up")
	}

	return VK88Keys
}


VK88Keys_Opening_PassThroughCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK88Keys := [openingChar, "VK88 Up"]
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := [openingChar, ClosingChar, "Left", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := [openingChar, closingChar, "Left", "VK88 Up"]
			}
			else
			{
				VK88Keys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VK88 Up"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := [openingChar, ClosingChar, "Left", "VKD8 Down", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := [openingChar, closingChar, "Left", "VKD8 Down", "VK88 Up"]
			}
			else
			{
				VK88Keys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down", "VK88 Up"]
			}
		}
	}
	
	return VK88Keys
}


VK88Keys_Opening_NoCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK88Keys := [openingChar, "VK88 Up"]
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := [openingChar, closingChar, "Left", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := [openingChar, closingChar, "Left", "VK98 Down", "VK88 Up", "VK99 Up"]
			}
			else
			{
				VK88Keys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VK88 Up"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := [openingChar, closingChar, "Left", "VKD8 Down", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := [openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down", "VK88 Up", "VK99 Up"]
			}
			else
			{
				VK88Keys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down", "VK88 Up"]
			}
		}
	}

	return VK88Keys
}


VK88Keys_Closing(closingChar, nestLevel)
{
	if(GetKeyState("VKD8"))
	{
		if(nestLevel > 0)
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := ["Backspace", "Right", "Space", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := ["Backspace", "Right", "Space", "VK88 Up"]
			}
			else
			{
				VK88Keys := ["Right", "Space", "VK98 Down", "VK88 Up"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK88Keys := ["Backspace", "Right", "Space", "VKD8 Up", "VK88 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK88Keys := ["Backspace", "Right", "Space", "VKD8 Up", "VK88 Up"]
			}
			else
			{
				VK88Keys := ["Right", "Space", "VK98 Down", "VKD8 Up", "VK88 Up"]
			}
		}
	}
	else
	{
		VK88Keys := [closingChar, "VK88 Up"]
	}

	return VK88Keys
}


VK88Keys_PuncCombinator(defaultKeys, VK98Keys, VK99Keys)
{
	VK88Keys := []

	if(GetKeyState("VK97"))
	{
		Loop % defaultKeys.Length()
		{
	    		VK88Keys.Push(defaultKeys[A_Index])
		}

		VK88Keys.Push("VK88 Up")
	}
	else if(GetKeyState("VK98"))
	{		
		Loop % VK98Keys.Length()
		{
	    		VK88Keys.Push(VK98Keys[A_Index])
		}

		VK88Keys.Push("VK88 Up")
	}
	else if(GetKeyState("VK99"))
	{
		Loop % VK99Keys.Length()
		{
	    		VK88Keys.Push(VK99Keys[A_Index])
		}

		VK88Keys.Push("VK88 Up")
	}
	else
	{
		Loop % defaultKeys.Length()
		{
	    		VK88Keys.Push(defaultKeys[A_Index])
		}

		VK88Keys.Push("VK88 Up")
	}

	return VK88Keys
}


VK89Keys_Letter(letter)
{
	if(GetKeyState("VK98"))
	{			
		VK89Keys := [letter, "VK98 Up", "VK89 Up"]
	}
	else if(GetKeyState("VK99"))
	{
		VK89Keys := [letter, "VK99 Up", "VK89 Up"]
	}
	else
	{
		VK89Keys := [letter, "VK89 Up"]
	}

	return VK89Keys
}


VK8BKeys_Opening_PassThroughCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK8BKeys := [openingChar]
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK8BKeys := [openingChar, ClosingChar, "Left"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8BKeys := [openingChar, closingChar, "Left"]
			}
			else
			{
				VK8BKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK8BKeys := [openingChar, ClosingChar, "Left", "VKD8 Down"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8BKeys := [openingChar, closingChar, "Left", "VKD8 Down"]
			}
			else
			{
				VK8BKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down"]
			}
		}
	}
	
	return VK8BKeys
}


VK8BKeys_Opening_NoCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK8BKeys := [openingChar]
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK8BKeys := [openingChar, closingChar, "Left"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8BKeys := [openingChar, closingChar, "Left", "VK98 Down", "VK99 Up"]
			}
			else
			{
				VK8BKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK8BKeys := [openingChar, closingChar, "Left", "VKD8 Down"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8BKeys := [openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down", "VK99 Up"]
			}
			else
			{
				VK8BKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down"]
			}
		}
	}

	return VK8BKeys
}


VK8CKeys_Number(num, lastRealKeyDown)
{
	VK8CKeys := GetSpecialCaseKeys(lastRealKeyDown)

	if(GetKeyState("VK97"))
	{
		VK8CKeys := num
	}
	else if(GetKeyState("VK98"))
	{			
		VK8CKeys.Push(num, "Space")
	}
	else if(GetKeyState("VK99"))
	{
		VK8CKeys.Push(num, "Space", "VK98 Down", "VK99 Up")
	}
	else
	{
		VK8CKeys.Push("Space", num, "Space", "VK98 Down")
	}

	return VK8CKeys
}


VK8CKeys_Opening_PassThroughCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK8CKeys := openingChar
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := [openingChar, ClosingChar, "Left"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := [openingChar, closingChar, "Left"]
			}
			else
			{
				VK8CKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := [openingChar, ClosingChar, "Left", "VKD8 Down"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := [openingChar, closingChar, "Left", "VKD8 Down"]
			}
			else
			{
				VK8CKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down"]
			}
		}
	}

	return VK8CKeys
}


VK8CKeys_Opening_NoCap(openingChar, closingChar)
{
	if(GetKeyState("VK97"))
	{
		VK8CKeys := openingChar
	}
	else
	{
		if(GetKeyState("VKD8"))
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := [openingChar, closingChar, "Left"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := [openingChar, closingChar, "Left", "VK98 Down", "VK99 Up"]
			}
			else
			{
				VK8CKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down"]
			}

		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := [openingChar, closingChar, "Left", "VKD8 Down"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := [openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down", "VK99 Up"]
			}
			else
			{
				VK8CKeys := ["Space", openingChar, closingChar, "Left", "VK98 Down", "VKD8 Down"]
			}
		}
	}

	return VK8CKeys
}


VK8CKeys_Closing(closingChar, nestLevel)
{
	if(GetKeyState("VKD8"))
	{
		if(nestLevel > 0)
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := ["Backspace", "Right", "Space"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := ["Backspace", "Right", "Space"]
			}
			else
			{
				VK8CKeys := ["Right", "Space", "VK98 Down"]
			}
		}
		else
		{
			if(GetKeyState("VK98"))
			{			
				VK8CKeys := ["Backspace", "Right", "Space", "VKD8 Up"]
			}
			else if(GetKeyState("VK99"))
			{
				VK8CKeys := ["Backspace", "Right", "Space", "VKD8 Up"]
			}
			else
			{
				VK8CKeys := ["Right", "Space", "VK98 Down", "VKD8 Up"]
			}
		}
	}
	else
	{
		VK8CKeys := closingChar
	}

	return VK8CKeys
}


VK8DKeys_Letter(letter)
{
	if(GetKeyState("VK98"))
	{			
		VK8DKeys := [letter, "VK98 Up"]
	}
	else if(GetKeyState("VK99"))
	{
		VK8DKeys := [letter, "VK99 Up"]
	}
	else
	{
		VK8DKeys := letter
	}

	return VK8DKeys
}


GetSpecialCaseKeys(lastRealKeyDown)
{
	lastKey := A_PriorHotkey

	if((lastKey = "*1") or (lastKey = "*1 Up"))
	{
		lastKey := lastRealKeyDown
	}
	else
	{
		lastKey := Dual.cleanKey(lastKey)
	}

	VK98IsDown := GetKeyState("VK98")


	specialCaseKeys := []

	if((lastKey = "c") and VK98IsDown)
	{
		specialCaseKeys.Push("Backspace", "–")   ; replace hyphens with en dashes between numbers
	}
	else
	{
		for i, value in ["h", "i", "e", "a", "w", "m", "t", "s", "r", "n", "2"]
		{
			if((lastKey = value) and VK98IsDown) ; The keys above will only be a number if VK98 is down. We don't want a leading space for these
			{
				specialCaseKeys.Push("Backspace")
			}
		}
	}
	
	return specialCaseKeys
}


DealWithSubscriptAndSuperscriptPassThrough_Tab()
{
	IniRead, subscript_PassThroughCap, Status.ini, nestVars, subscript_PassThroughCap
	if(subscript_PassThroughCap)
	{
		subscript_PassThroughCap := false
		IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
		
		; Add space to deal with the {Backspace} if VK99 down in expand.ahk
		SendInput {Space}{VK99 Down}
	}

	IniRead, superscript_PassThroughCap, Status.ini, nestVars, superscript_PassThroughCap
	if(superscript_PassThroughCap)
	{
		superscript_PassThroughCap := false
		IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap

		; Add space to deal with the {Backspace} if VK99 down in expand.ahk
		SendInput {Space}{VK99 Down}
	}
}


DealWithSubscriptAndSuperscriptPassThrough()
{
	subscript_PassThroughCap := false
	IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap
		
	superscript_PassThroughCap := false
	IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap
}


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

	if(command_PassThroughAutospacing = "VK98")
	{
		SendInput {VK98 Down}
	}
	else if(command_PassThroughAutospacing = "VK99")
	{
		SendInput {VK99 Down}
	}
	
	SendInput {VK8F Up}

	if(!inTextBox)
	{
		SendInput {Enter}
	}

	return
}