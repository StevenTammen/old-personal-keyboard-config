; Number Row
;-------------------------------------------------

l11_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l12_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l13_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChar := GetClosingCharFromStack(closingChars)
	WriteNestVarsIfApplicable_Closing(nestLevel, closingChars)
	numModifier_keys := numModifierKeys_Closing("}", closingChar, nestLevel)
	return numModifier_keys
}
l14_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingChar := GetClosingCharFromStack(closingChars)
	WriteNestVarsIfApplicable_Closing(nestLevel, closingChars)
	numModifier_keys := numModifierKeys_Closing("]", closingChar, nestLevel)
	return numModifier_keys
}
l15_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, ")")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("(", ")")
	return numModifier_keys
}
l16_numModifier() {
	numModifier_keys := ["``"]
	return numModifier_keys
}


r11_numModifier() {
	numModifier_keys := ["#"]
	return numModifier_keys
}
r12_numModifier() {
	numModifier_keys := ["="]
	return numModifier_keys
}
r13_numModifier() {
	numModifier_keys := ["<", "-"]
	return numModifier_keys
}
r14_numModifier() {
	numModifier_keys := ["-", ">"]
	return numModifier_keys
}
r15_numModifier() {
	numModifier_keys := ["#", "+"]
	SendInput {%shiftLeaderUp%}{%shiftModifierDn%}
	return numModifier_keys
}
; Temporary location for partial stopping behavior
r16_numModifier() {
	; Exit everything but KP and iswitchw
	ExitAllAHK()
	Run C:\Users\steve\Desktop\Projects\personal-keyboard-config\iswitchw.ahk
	ExitApp
}



; Top Row
;-------------------------------------------------

l21_numModifier() {
	numModifier_keys := ["@"]
	return numModifier_keys
}
l22_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "~")
	numModifier_keys := numModifierKeys_Opening_NoCap("~", "~")
	return numModifier_keys
}
l23_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "}")
	numModifier_keys := numModifierKeys_Opening_NoCap("{", "}")
	return numModifier_keys
}
l24_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "]")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("[", "]")
	return numModifier_keys
}
l25_numModifier() {
	if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["\", rawLeaderDn, afterNumUp, regSpacingUp]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["\", rawLeaderDn, afterNumUp, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["\", rawLeaderDn, afterNumUp]
	}
	return numModifier_keys
}
l26_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "'")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("'", "'")
	return numModifier_keys
}


r21_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["%"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "%", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["Backspace", "%", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", "%", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["%", "Space", regSpacingDn]
	}
	return numModifier_keys
}
r22_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "/")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("/", "/")
	return numModifier_keys
}
r23_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["-"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "-", rawLeaderUp]
	}
	; regSpacing after hyphen if after number, no spacing otherwise
	else if(GetKeyState(regSpacing))
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
		
		lastKeyIsNumber := False
		for i, value in ["h", "i", "e", "a", "w", "m", "t", "s", "r", "n"]
		{
			if(lastKey = value)
			{
				lastKeyIsNumber := True
			}
		}
		
		if(lastKeyIsNumber)
		{
			numModifier_keys := ["Backspace", "-"]
		}
		else
		{
			numModifier_keys := ["-", regSpacingUp]
		}
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["-", capSpacingUp]
	}
	else
	{
		numModifier_keys := ["-"]
	}
	return numModifier_keys
}
r24_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "*")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("*", "*")
	return numModifier_keys
}
r25_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "+")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("+", "+")
	return numModifier_keys
}
r26_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "^")
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("^", "^")
	return numModifier_keys
}



; Home Row
;-------------------------------------------------

l31_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l32_numModifier() {
	numModifier_keys := numModifierKeys_Number("2")
	return numModifier_keys
}
l33_numModifier() {
	numModifier_keys := numModifierKeys_Number("3")
	return numModifier_keys
}
l34_numModifier() {
	numModifier_keys := numModifierKeys_Number("5")
	return numModifier_keys
}
l35_numModifier() {
	numModifier_keys := numModifierKeys_Number("7")
	return numModifier_keys
}
l36_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["."]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ".", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["Backspace", "."]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", ".", capSpacingUp, regSpacingDn]
	}
	else
	{
		numModifier_keys := [".", regSpacingDn]
	}
	return numModifier_keys
}


r31_numModifier() {
	numModifier_keys := numModifierKeys_Number("8")
	return numModifier_keys
}
r32_numModifier() {
	numModifier_keys := numModifierKeys_Number("0")
	return numModifier_keys
}
r33_numModifier() {
	numModifier_keys := numModifierKeys_Number("6")
	return numModifier_keys
}
r34_numModifier() {
	numModifier_keys := numModifierKeys_Number("4")
	return numModifier_keys
}
r35_numModifier() {
	numModifier_keys := numModifierKeys_Number("1")
	return numModifier_keys
}
r36_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["|"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "|", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["|", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["|", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["Space", "|", "Space", regSpacingDn]
	}
	return numModifier_keys
}



; Bottom Row
;-------------------------------------------------

l41_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l42_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["$"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "$", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["$"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["$", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["Space", "$", regSpacingDn]
	}
	return numModifier_keys
}
; Not used intentionally; using quote default behavior instead in remap.ahk
l43_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
; Not used intentionally; using close paren default behavior instead in remap.ahk
l44_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
; Not used intentionally; using comma default behavior instead in remap.ahk
l45_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
; Not used intentionally; using open paren default behavior instead in remap.ahk
l46_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}


r41_numModifier() {
	numModifier_keys := numModifierKeys_Number("9")
	return numModifier_keys
}
r42_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestVarsIfApplicable_Opening(nestLevel, "=")
	numModifier_keys := numModifierKeys_Opening_NoCap("=", "=")
	return numModifier_keys
}
r43_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["<"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "<", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["<", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["<", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["Space", "<", "Space", regSpacingDn]
	}
	return numModifier_keys
}
r44_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := [">"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ">", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := [">", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := [">", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["Space", ">", "Space", regSpacingDn]
	}
	return numModifier_keys
}
r45_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := ["&"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", "&", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["&"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["&", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["Space", "&", regSpacingDn]
	}
	return numModifier_keys
}
r46_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}



; Extra Row
;-------------------------------------------------

l52_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l53_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l54_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l55_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}


r52_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r53_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r54_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r55_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}



; Thumbs
;-------------------------------------------------

lt1_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
lt2_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
lt3_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
lt4_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
lt5_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
lt6_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}


rt1_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
rt2_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := [":"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ":", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{
		numModifier_keys := ["Backspace", ":", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", ":", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := [":", "Space", regSpacingDn]
	}
	return numModifier_keys
}
rt3_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := [";"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ";", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{	
		numModifier_keys := ["Backspace", ";", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", ";", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := [";", "Space", regSpacingDn]
	}
	return numModifier_keys
}
rt4_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
rt5_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := [":"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ":", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{
		numModifier_keys := ["Backspace", ":", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", ":", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := [":", "Space", regSpacingDn]
	}
	return numModifier_keys
}
rt6_numModifier() {
	if(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())
	{
		numModifier_keys := [";"]
	}
	else if(GetKeyState(rawLeader))
	{
		numModifier_keys := ["Backspace", ";", rawLeaderUp]
	}
	else if(GetKeyState(regSpacing))
	{	
		numModifier_keys := ["Backspace", ";", "Space"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", ";", "Space", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := [";", "Space", regSpacingDn]
	}
	return numModifier_keys
}
