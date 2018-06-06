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
	numModifier_keys := [""]
	return numModifier_keys
}
l14_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l15_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l16_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}


r11_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r12_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r13_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r14_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r15_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
r16_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}



; Top Row
;-------------------------------------------------

l21_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
l22_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_NoCap("{", "}")
	return numModifier_keys
}
l23_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("[", "]")
	return numModifier_keys
}
l24_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	WriteNestLevelIfApplicable_Closing(nestLevel)
	numModifier_keys := numModifierKeys_Closing("]", nestLevel)
	return numModifier_keys
}
l25_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	WriteNestLevelIfApplicable_Closing(nestLevel)
	numModifier_keys := numModifierKeys_Closing("}", nestLevel)
	return numModifier_keys
}
l26_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("'", "'")
	return numModifier_keys
}


r21_numModifier() {
	if(GetKeyState(rawState))
	{
		numModifier_keys := ["%"]
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
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("/", "/")
	return numModifier_keys
}
r23_numModifier() {
	if(GetKeyState(rawState))
	{
		numModifier_keys := ["-"]
	}
	else if(GetKeyState(regSpacing))
	{			
		numModifier_keys := ["Backspace", "-"]
	}
	else if(GetKeyState(capSpacing))
	{
		numModifier_keys := ["Backspace", "-", regSpacingDn, capSpacingUp]
	}
	else
	{
		numModifier_keys := ["-", regSpacingDn]
	}
	return numModifier_keys
}
r24_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("*", "*")
	return numModifier_keys
}
r25_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_PassThroughCap("+", "+")
	return numModifier_keys
}
r26_numModifier() {
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	WriteNestLevelIfApplicable_Opening(nestLevel)
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
if(GetKeyState(rawState))
	{
		numModifier_keys := ["."]
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
	if(GetKeyState(rawState))
	{
		numModifier_keys := ["|"]
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
	if(GetKeyState(rawState))
	{
		numModifier_keys := ["$"]
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
	WriteNestLevelIfApplicable_Opening(nestLevel)
	numModifier_keys := numModifierKeys_Opening_NoCap("=", "=")
	return numModifier_keys
}
r43_numModifier() {
	numModifier_keys := numModifierKeys_Opening_NoCap("<", ">")
	return numModifier_keys
}
r44_numModifier() {
	numModifier_keys := numModifierKeys_Closing(">", nestLevel)
	return numModifier_keys
}
r45_numModifier() {
	if(GetKeyState(rawState))
	{
		numModifier_keys := ["&"]
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
	if(GetKeyState(rawState))
	{
		numModifier_keys := [":"]
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
lt2_numModifier() {
	if(GetKeyState(rawState))
	{
		numModifier_keys := [";"]
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
	numModifier_keys := [""]
	return numModifier_keys
}
rt3_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
rt4_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
rt5_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
rt6_numModifier() {
	numModifier_keys := [""]
	return numModifier_keys
}
