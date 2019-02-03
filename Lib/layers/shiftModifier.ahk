; shiftber Row
;-------------------------------------------------

l11_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l12_shiftModifier() {
	AssociateActiveWindowWithLocation("unlayered", "farLeft")
	return
}
l13_shiftModifier() {
	AssociateActiveWindowWithLocation("unlayered", "midLeft")
	return
}
l14_shiftModifier() {
	AssociateActiveWindowWithLocation("unlayered", "midRight")
	return
}
l15_shiftModifier() {
	AssociateActiveWindowWithLocation("unlayered", "farRight")
	return
}
l16_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}


r11_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r12_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r13_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r14_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r15_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r16_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}



; Top Row
;-------------------------------------------------

l21_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l22_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("B")
	return shiftModifier_keys
}
l23_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("Y")
	return shiftModifier_keys
}
l24_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("O")
	return shiftModifier_keys
}
l25_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("U")
	return shiftModifier_keys
}
l26_shiftModifier() {
	shiftModifier_keys := ["``"]
	return shiftModifier_keys
}


r21_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("K")
	return shiftModifier_keys
}
r22_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("D")
	return shiftModifier_keys
}
r23_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("C")
	return shiftModifier_keys
}
r24_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("L")
	return shiftModifier_keys
}
r25_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("P")
	return shiftModifier_keys
}
r26_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("Q")
	return shiftModifier_keys
}



; Home Row
;-------------------------------------------------

l31_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l32_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("H")
	return shiftModifier_keys
}
l33_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("I")
	return shiftModifier_keys
}
l34_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("E")
	return shiftModifier_keys
}
l35_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("A")
	return shiftModifier_keys
}
l36_shiftModifier() {
	shiftModifier_keys := ["."]
	return shiftModifier_keys
}


r31_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("M")
	return shiftModifier_keys
}
r32_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("T")
	return shiftModifier_keys
}
r33_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("S")
	return shiftModifier_keys
}
r34_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("R")
	return shiftModifier_keys
}
r35_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("N")
	return shiftModifier_keys
}
r36_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("V")
	return shiftModifier_keys
}



; Bottom Row
;-------------------------------------------------

l41_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l42_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("X")
	return shiftModifier_keys
}
l43_shiftModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		shiftModifier_keys := ["!"]
	}
	else if(GetKeyState(rawLeader))
	{
		shiftModifier_keys := ["Backspace", "!", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		shiftModifier_keys := ["Backspace", "!", "Space", capSpacingDn, regSpacingUp]
	}
	else if(GetKeyState(capSpacing))
	{
		shiftModifier_keys := ["Backspace", "!", "Space"]
	}
	else
	{
		shiftModifier_keys := ["!", "Space", capSpacingDn]
	}
	return shiftModifier_keys
}
l44_shiftModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		shiftModifier_keys := ["?"]
	}
	else if(GetKeyState(rawLeader))
	{
		shiftModifier_keys := ["Backspace", "?", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		shiftModifier_keys := ["Backspace", "?", "Space", capSpacingDn, regSpacingUp]
	}
	else if(GetKeyState(capSpacing))
	{
		shiftModifier_keys := ["Backspace", "?", "Space"]
	}
	else
	{
		shiftModifier_keys := ["?", "Space", capSpacingDn]
	}
	return shiftModifier_keys
}
; Not used intentionally; using comma default behavior instead in remap.ahk
l45_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l46_shiftModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		shiftModifier_keys := ["–"]
	}
	else if(GetKeyState(rawLeader))
	{
		shiftModifier_keys := ["Backspace", "–", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		shiftModifier_keys := ["Backspace", "–"]
	}
	else if(GetKeyState(capSpacing))
	{
		shiftModifier_keys := ["Backspace", "–", regSpacingDn, capSpacingUp]
	}
	else
	{
		shiftModifier_keys := ["–", regSpacingDn]
	}
	return shiftModifier_keys
}


r41_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("W")
	return shiftModifier_keys
}
r42_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("G")
	return shiftModifier_keys
}
r43_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("F")
	return shiftModifier_keys
}
r44_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("J")
	return shiftModifier_keys
}
r45_shiftModifier() {
	shiftModifier_keys := shiftModifierKeys_Letter("Z")
	return shiftModifier_keys
}
r46_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}



; Extra Row
;-------------------------------------------------

l52_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l53_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l54_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
l55_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}


r52_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r53_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r54_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
r55_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}



; Thumbs
;-------------------------------------------------

lt1_shiftModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		shiftModifier_keys := ["_"]
	}
	else if(GetKeyState(rawLeader))
	{
		shiftModifier_keys := ["Backspace", "_", rawLeaderUp]
	}
	else
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel + 1
		
		actuallyNeedToWrite := GetKeyState(shiftLeader) or shiftDownNoUp or (GetKeyState(shiftAfter) and !(GetKeyState(shiftLeader) or shiftDownNoUp))

		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			lastOpenPairDown := A_TickCount
			IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
			
			IniRead, closingChars, Status.ini, nestVars, closingChars
			closingChars := AddClosingCharToStack("_", closingChars)
			IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		}
		
		IniRead, nestingType, Status.ini, nestVars, nestingType
	
		if(nestingType = "paired")
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					shiftModifier_keys := ["_", "_", "Left"]
				}
				else if(GetKeyState(capSpacing))
				{
					shiftModifier_keys := ["_", "_", "Left"]
				}
				else
				{
					shiftModifier_keys := ["Space", "_", "_", "Left", regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					shiftModifier_keys := ["_", "_", "Left", nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					shiftModifier_keys := ["_", "_", "Left", nestedPunctuationDn]
				}
				else
				{
					shiftModifier_keys := ["Space", "_", "_", "Left", regSpacingDn, nestedPunctuationDn]
				}
			}
		}
		
		else  ; nestingType = "unpaired"
		{
			if(GetKeyState(nestedPunctuation))
			{
				if(GetKeyState(regSpacing))
				{			
					shiftModifier_keys := ["_"]
				}
				else if(GetKeyState(capSpacing))
				{
					shiftModifier_keys := ["_"]
				}
				else
				{
					shiftModifier_keys := ["Space", "_", regSpacingDn]
				}
			}
			else
			{
				if(GetKeyState(regSpacing))
				{			
					shiftModifier_keys := ["_", nestedPunctuationDn]
				}
				else if(GetKeyState(capSpacing))
				{
					shiftModifier_keys := ["_", nestedPunctuationDn]
				}
				else
				{
					shiftModifier_keys := ["Space", "_", regSpacingDn, nestedPunctuationDn]
				}
			}
		}
	}
	
	return shiftModifier_keys
}
lt2_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
lt3_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
lt4_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
lt5_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
lt6_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}


rt1_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
rt2_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
rt3_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
rt4_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
rt5_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
rt6_shiftModifier() {
	shiftModifier_keys := [""]
	return shiftModifier_keys
}
