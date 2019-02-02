; Number Row
;-------------------------------------------------

l11_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l12_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l13_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l14_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l15_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l16_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r11_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r12_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r13_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r14_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r15_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r16_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Top Row
;-------------------------------------------------

l21_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l22_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l23_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l24_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l25_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l26_expd1Modifier() {
	expd1Modifier_keys := ["#"]
	return expd1Modifier_keys
}


r21_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r22_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r23_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r24_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r25_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r26_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Home Row
;-------------------------------------------------

l31_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l32_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l33_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l34_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l35_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l36_expd1Modifier() {

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel + 1
	
	; hardcoded here since this is the expd1 layer unlike the num layer
	; that the WriteNestVarsIfApplicable_Opening() is written for
	actuallyNeedToWrite := (GetKeyState(expd1Leader) or expd1DownNoUp)
	if(actuallyNeedToWrite)
	{
		IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		lastOpenPairDown := A_TickCount
		IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
		
		IniRead, closingChars, Status.ini, nestVars, closingChars
		closingChars := AddClosingCharToStack("~", closingChars)
		IniWrite, %closingChars%, Status.ini, nestVars, closingChars
	}
	
	expd1Modifier_keys := numModifierKeys_Opening_NoCap("~", "~")
	return expd1Modifier_keys
}


r31_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r32_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r33_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r34_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r35_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r36_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Bottom Row
;-------------------------------------------------

l41_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l42_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l43_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l44_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l45_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l46_expd1Modifier() {
	expd1Modifier_keys := ["@"]
	return expd1Modifier_keys
}


r41_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r42_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r43_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r44_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r45_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r46_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Extra Row
;-------------------------------------------------

l52_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l53_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l54_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l55_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r52_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r53_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r54_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r55_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Thumbs
;-------------------------------------------------

lt1_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt2_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt3_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt4_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt5_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt6_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


rt1_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt2_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt3_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt4_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt5_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt6_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
