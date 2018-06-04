SendMode Input
#NoEnv
#SingleInstance force



; Import Functions and Layers
;-------------------------------------------------

#Include <dual/dual>
#Include <functions>

#Include <layers/expdLeader>
#Include <layers/expdModifier>
#Include <layers/numLeader>
#Include <layers/numModifier>
#Include <layers/shiftLeader>
#Include <layers/shiftModifier>
#Include <layers/afterNum>



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07  



; Initialize Objects And Status Variables
;-------------------------------------------------

; Make dual object
dual := new Dual

; Store the nest level in an .ini file so it is accessible in the expand script
nestLevel := 0
IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

; Store the quote status in an .ini file so it is accessible in the expand script
inQuote := false
IniWrite, %inQuote%, Status.ini, nestVars, inQuote 

; To allow for the deletion of paired characters as long as nothing else has been typed
lastOpenPairDown := A_TickCount
IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown 

; Enable passing through capitalization for commands as a block (rather than capitalizing the first letter of the command).
command_PassThroughAutospacing := "none"
IniWrite, %command_PassThroughAutospacing%, Status.ini, commandVars, command_PassThroughAutospacing

; To allow for Enters pressed close together to function differently from those pressed far apart
lastEnterDown := A_TickCount 

; Track keypresses before layers are activated to use in place of A_PriorHotkey (which returns the layer key, not the actual prior key)
lastRealKeyDown := ""



; Initialize Layer Keys
;-------------------------------------------------

; Num keys come before shift keys so that you can use the number layer when shift is locked down (double tapped)
; Num keys and shift keys come before expd keys so that you can expand a wider subset of characters

; To use these as keys in associative arrays, you have to enclose them in parentheses. 
; For example: ~{(numLeader): numLeader_keys}~

global numLeader := "VK88"
global numModifier := "VK89"
global shiftLeader := "VK8A"
global shiftModifier := "VK8B"
global expdLeader := "VK8C"
global expdModifier := "VK8D"
global afterNum := "VK8E"
global rawLeader := "VK8F"
global rawState := "VK97"
global regSpacing := "VK98"
global capSpacing := "VK99"
global nestedPunctuation := "VKD8"

; Explicit down and up variables are defined for ease of use: using expression syntax and straight key definitions,
; you would need concatenation like ~keyVar . " Down"~ and ~keyVar . " Up"~, which is a bit verbose.
; I have found AHK's expression/%traditional syntax% quite bug-prone, so have opted to do it this way.

global numLeaderDn := "VK88 Down"
global numModifierDn := "VK89 Down"
global shiftLeaderDn := "VK8A Down"
global shiftModifierDn := "VK8B Down"
global expdLeaderDn := "VK8C Down"
global expdModifierDn := "VK8D Down"
global afterNumDn := "VK8E Down"
global rawLeaderDn := "VK8F Down"
global rawStateDn := "VK97 Down"
global regSpacingDn := "VK98 Down"
global capSpacingDn := "VK99 Down"
global nestedPunctuationDn := "VKD8 Down"

global numLeaderUp := "VK88 Up"
global numModifierUp := "VK89 Up"
global shiftLeaderUp := "VK8A Up"
global shiftModifierUp := "VK8B Up"
global expdLeaderUp := "VK8C Up"
global expdModifierUp := "VK8D Up"
global afterNumUp := "VK8E Up"
global rawLeaderUp := "VK8F Up"
global rawStateUp := "VK97 Up"
global regSpacingUp := "VK98 Up"
global capSpacingUp := "VK99 Up"
global nestedPunctuationUp := "VKD8 Up"



; Number Row
;-------------------------------------------------

*=::
	numModifier_keys := l11_numModifier()
	shiftModifier_keys := l11_shiftModifier()
	expdModifier_keys := l11_expdModifier()
	numLeader_keys := l11_numLeader(numModifier_keys)
	shiftLeader_keys := l11_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l11_expdLeader(expdModifier_keys)
	l11_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*RShift:
	numModifier_keys := l12_numModifier()
	shiftModifier_keys := l12_shiftModifier()
	expdModifier_keys := l12_expdModifier()
	numLeader_keys := l12_numLeader(numModifier_keys)
	shiftLeader_keys := l12_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l12_expdLeader(expdModifier_keys)
	l12_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*RCtrl::
	numModifier_keys := l13_numModifier()
	shiftModifier_keys := l13_shiftModifier()
	expdModifier_keys := l13_expdModifier()
	numLeader_keys := l13_numLeader(numModifier_keys)
	shiftLeader_keys := l13_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l13_expdLeader(expdModifier_keys)
	l13_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Del::
	numModifier_keys := l14_numModifier()
	shiftModifier_keys := l14_shiftModifier()
	expdModifier_keys := l14_expdModifier()
	numLeader_keys := l14_numLeader(numModifier_keys)
	shiftLeader_keys := l14_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l14_expdLeader(expdModifier_keys)
	l14_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*4::
	numModifier_keys := l15_numModifier()
	shiftModifier_keys := l15_shiftModifier()
	expdModifier_keys := l15_expdModifier()
	numLeader_keys := l15_numLeader(numModifier_keys)
	shiftLeader_keys := l15_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l15_expdLeader(expdModifier_keys)
	l15_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*5::
	numModifier_keys := l16_numModifier()
	shiftModifier_keys := l16_shiftModifier()
	expdModifier_keys := l16_expdModifier()
	numLeader_keys := l16_numLeader(numModifier_keys)
	shiftLeader_keys := l16_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l16_expdLeader(expdModifier_keys)
	l16_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return


*6::
	numModifier_keys := r11_numModifier()
	shiftModifier_keys := r11_shiftModifier()
	expdModifier_keys := r11_expdModifier()
	numLeader_keys := r11_numLeader(numModifier_keys)
	shiftLeader_keys := r11_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r11_expdLeader(expdModifier_keys)
	r11_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*7::
	numModifier_keys := r12_numModifier()
	shiftModifier_keys := r12_shiftModifier()
	expdModifier_keys := r12_expdModifier()
	numLeader_keys := r12_numLeader(numModifier_keys)
	shiftLeader_keys := r12_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r12_expdLeader(expdModifier_keys)
	r12_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*8::
	numModifier_keys := r13_numModifier()
	shiftModifier_keys := r13_shiftModifier()
	expdModifier_keys := r13_expdModifier()
	numLeader_keys := r13_numLeader(numModifier_keys)
	shiftLeader_keys := r13_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r13_expdLeader(expdModifier_keys)
	r13_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*9::
	numModifier_keys := r14_numModifier()
	shiftModifier_keys := r14_shiftModifier()
	expdModifier_keys := r14_expdModifier()
	numLeader_keys := r14_numLeader(numModifier_keys)
	shiftLeader_keys := r14_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r14_expdLeader(expdModifier_keys)
	r14_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*0::
	numModifier_keys := r15_numModifier()
	shiftModifier_keys := r15_shiftModifier()
	expdModifier_keys := r15_expdModifier()
	numLeader_keys := r15_numLeader(numModifier_keys)
	shiftLeader_keys := r15_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r15_expdLeader(expdModifier_keys)
	r15_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*-::
	numModifier_keys := r16_numModifier()
	shiftModifier_keys := r16_shiftModifier()
	expdModifier_keys := r16_expdModifier()
	numLeader_keys := r16_numLeader(numModifier_keys)
	shiftLeader_keys := r16_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r16_expdLeader(expdModifier_keys)
	r16_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return




; Top Row
;-------------------------------------------------

*Tab::
	numModifier_keys := l21_numModifier()
	shiftModifier_keys := l21_shiftModifier()
	expdModifier_keys := l21_expdModifier()
	numLeader_keys := l21_numLeader(numModifier_keys)
	shiftLeader_keys := l21_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l21_expdLeader(expdModifier_keys)
	l21_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*b::
	numModifier_keys := l22_numModifier()
	shiftModifier_keys := l22_shiftModifier()
	expdModifier_keys := l22_expdModifier()
	numLeader_keys := l22_numLeader(numModifier_keys)
	shiftLeader_keys := l22_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l22_expdLeader(expdModifier_keys)
	l22_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["b", regSpacingUp], (capSpacing): ["B", capSpacingUp], (regSpacing): ["b", regSpacingUp], (capSpacing): ["B", capSpacingUp]})
	return
*y::
	numModifier_keys := l23_numModifier()
	shiftModifier_keys := l23_shiftModifier()
	expdModifier_keys := l23_expdModifier()
	numLeader_keys := l23_numLeader(numModifier_keys)
	shiftLeader_keys := l23_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l23_expdLeader(expdModifier_keys)
	l23_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["y", regSpacingUp], (capSpacing): ["Y", capSpacingUp], (regSpacing): ["y", regSpacingUp], (capSpacing): ["Y", capSpacingUp]})
	return
*o::
	numModifier_keys := l24_numModifier()
	shiftModifier_keys := l24_shiftModifier()
	expdModifier_keys := l24_expdModifier()
	numLeader_keys := l24_numLeader(numModifier_keys)
	shiftLeader_keys := l24_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l24_expdLeader(expdModifier_keys)
	l24_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["o", regSpacingUp], (capSpacing): ["O", capSpacingUp], (regSpacing): ["o", regSpacingUp], (capSpacing): ["O", capSpacingUp]})
	return
*u::
	numModifier_keys := l25_numModifier()
	shiftModifier_keys := l25_shiftModifier()
	expdModifier_keys := l25_expdModifier()
	numLeader_keys := l25_numLeader(numModifier_keys)
	shiftLeader_keys := l25_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l25_expdLeader(expdModifier_keys)
	l25_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["u", regSpacingUp], (capSpacing): ["U", capSpacingUp], (regSpacing): ["u", regSpacingUp], (capSpacing): ["U", capSpacingUp]})
	return
*'::
	numModifier_keys := l26_numModifier()
	shiftModifier_keys := l26_shiftModifier()
	expdModifier_keys := l26_expdModifier()
	numLeader_keys := l26_numLeader(numModifier_keys)
	shiftLeader_keys := l26_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l26_expdLeader(expdModifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (afterNum): afterNum_keys})
	return


*k::
	numModifier_keys := r21_numModifier()
	shiftModifier_keys := r21_shiftModifier()
	expdModifier_keys := r21_expdModifier()
	numLeader_keys := r21_numLeader(numModifier_keys)
	shiftLeader_keys := r21_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r21_expdLeader(expdModifier_keys)
	r21_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["k", regSpacingUp], (capSpacing): ["K", capSpacingUp], (regSpacing): ["k", regSpacingUp], (capSpacing): ["K", capSpacingUp]})
	return
*d::
	numModifier_keys := r22_numModifier()
	shiftModifier_keys := r22_shiftModifier()
	expdModifier_keys := r22_expdModifier()
	numLeader_keys := r22_numLeader(numModifier_keys)
	shiftLeader_keys := r22_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r22_expdLeader(expdModifier_keys)
	r22_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["d", regSpacingUp], (capSpacing): ["D", capSpacingUp], (regSpacing): ["d", regSpacingUp], (capSpacing): ["D", capSpacingUp]})
	return
*c::
	numModifier_keys := r23_numModifier()
	shiftModifier_keys := r23_shiftModifier()
	expdModifier_keys := r23_expdModifier()
	numLeader_keys := r23_numLeader(numModifier_keys)
	shiftLeader_keys := r23_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r23_expdLeader(expdModifier_keys)
	r23_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["c", regSpacingUp], (capSpacing): ["C", capSpacingUp], (regSpacing): ["c", regSpacingUp], (capSpacing): ["C", capSpacingUp]})
	return
*l::
	numModifier_keys := r24_numModifier()
	shiftModifier_keys := r24_shiftModifier()
	expdModifier_keys := r24_expdModifier()
	numLeader_keys := r24_numLeader(numModifier_keys)
	shiftLeader_keys := r24_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r24_expdLeader(expdModifier_keys)
	r24_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["l", regSpacingUp], (capSpacing): ["L", capSpacingUp], (regSpacing): ["l", regSpacingUp], (capSpacing): ["L", capSpacingUp]})
	return
*p::
	numModifier_keys := r25_numModifier()
	shiftModifier_keys := r25_shiftModifier()
	expdModifier_keys := r25_expdModifier()
	numLeader_keys := r25_numLeader(numModifier_keys)
	shiftLeader_keys := r25_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r25_expdLeader(expdModifier_keys)
	r25_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["p", regSpacingUp], (capSpacing): ["P", capSpacingUp], (regSpacing): ["p", regSpacingUp], (capSpacing): ["P", capSpacingUp]})
	return
*q::
	numModifier_keys := r26_numModifier()
	shiftModifier_keys := r26_shiftModifier()
	expdModifier_keys := r26_expdModifier()
	numLeader_keys := r26_numLeader(numModifier_keys)
	shiftLeader_keys := r26_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r26_expdLeader(expdModifier_keys)
	r26_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["q", regSpacingUp], (capSpacing): ["Q", capSpacingUp], (regSpacing): ["q", regSpacingUp], (capSpacing): ["Q", capSpacingUp]})
	return




; Home Row
;-------------------------------------------------

*Backspace::
	numModifier_keys := l31_numModifier()
	shiftModifier_keys := l31_shiftModifier()
	expdModifier_keys := l31_expdModifier()
	numLeader_keys := l31_numLeader(numModifier_keys)
	shiftLeader_keys := l31_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l31_expdLeader(expdModifier_keys)
	l31_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*h::
	numModifier_keys := l32_numModifier()
	shiftModifier_keys := l32_shiftModifier()
	expdModifier_keys := l32_expdModifier()
	numLeader_keys := l32_numLeader(numModifier_keys)
	shiftLeader_keys := l32_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l32_expdLeader(expdModifier_keys)
	l32_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["h", regSpacingUp], (capSpacing): ["H", capSpacingUp]})
	return
*i::
	numModifier_keys := l33_numModifier()
	shiftModifier_keys := l33_shiftModifier()
	expdModifier_keys := l33_expdModifier()
	numLeader_keys := l33_numLeader(numModifier_keys)
	shiftLeader_keys := l33_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l33_expdLeader(expdModifier_keys)
	l33_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["i", regSpacingUp], (capSpacing): ["I", capSpacingUp], (regSpacing): ["i", regSpacingUp], (capSpacing): ["I", capSpacingUp]})
	return
*e::
	numModifier_keys := l34_numModifier()
	shiftModifier_keys := l34_shiftModifier()
	expdModifier_keys := l34_expdModifier()
	numLeader_keys := l34_numLeader(numModifier_keys)
	shiftLeader_keys := l34_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l34_expdLeader(expdModifier_keys)
	l34_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["e", regSpacingUp], (capSpacing): ["E", capSpacingUp], (regSpacing): ["e", regSpacingUp], (capSpacing): ["E", capSpacingUp]})
	return
*a::
	numModifier_keys := l35_numModifier()
	shiftModifier_keys := l35_shiftModifier()
	expdModifier_keys := l35_expdModifier()
	numLeader_keys := l35_numLeader(numModifier_keys)
	shiftLeader_keys := l35_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l35_expdLeader(expdModifier_keys)
	l35_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["a", regSpacingUp], (capSpacing): ["A", capSpacingUp], (regSpacing): ["a", regSpacingUp], (capSpacing): ["A", capSpacingUp]})
	return
*.::
	if(GetKeyState(rawState))
	{
		defaultKeys := ["."]
		regSpacingKeys := ["."]
		capSpacingKeys := ["."]
	}
	else
	{
		defaultKeys := [".", "Space", capSpacingDn]
		regSpacingKeys := ["Backspace", ".", "Space", capSpacingDn, regSpacingUp]
		capSpacingKeys := ["Backspace", ".", "Space"]
	}

	numModifier_keys := l36_numModifier()
	shiftModifier_keys := l36_shiftModifier()
	expdModifier_keys := l36_expdModifier()
	numLeader_keys := l36_numLeader(numModifier_keys)
	shiftLeader_keys := l36_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l36_expdLeader(expdModifier_keys)
	l36_afterNum()
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return


*m::
	numModifier_keys := r31_numModifier()
	shiftModifier_keys := r31_shiftModifier()
	expdModifier_keys := r31_expdModifier()
	numLeader_keys := r31_numLeader(numModifier_keys)
	shiftLeader_keys := r31_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r31_expdLeader(expdModifier_keys)
	r31_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["m", regSpacingUp], (capSpacing): ["M", capSpacingUp], (regSpacing): ["m", regSpacingUp], (capSpacing): ["M", capSpacingUp]})
	return
*t::
	numModifier_keys := r32_numModifier()
	shiftModifier_keys := r32_shiftModifier()
	expdModifier_keys := r32_expdModifier()
	numLeader_keys := r32_numLeader(numModifier_keys)
	shiftLeader_keys := r32_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r32_expdLeader(expdModifier_keys)
	r32_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["t", regSpacingUp], (capSpacing): ["T", capSpacingUp], (regSpacing): ["t", regSpacingUp], (capSpacing): ["T", capSpacingUp]})
	return
*s::
	numModifier_keys := r33_numModifier()
	shiftModifier_keys := r33_shiftModifier()
	expdModifier_keys := r33_expdModifier()
	numLeader_keys := r33_numLeader(numModifier_keys)
	shiftLeader_keys := r33_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r33_expdLeader(expdModifier_keys)
	r33_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["s", regSpacingUp], (capSpacing): ["S", capSpacingUp], (regSpacing): ["s", regSpacingUp], (capSpacing): ["S", capSpacingUp]})
	return
*r::
	numModifier_keys := r34_numModifier()
	shiftModifier_keys := r34_shiftModifier()
	expdModifier_keys := r34_expdModifier()
	numLeader_keys := r34_numLeader(numModifier_keys)
	shiftLeader_keys := r34_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r34_expdLeader(expdModifier_keys)
	r34_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["r", regSpacingUp], (capSpacing): ["R", capSpacingUp], (regSpacing): ["r", regSpacingUp], (capSpacing): ["R", capSpacingUp]})
	return
*n::
	numModifier_keys := r35_numModifier()
	shiftModifier_keys := r35_shiftModifier()
	expdModifier_keys := r35_expdModifier()
	numLeader_keys := r35_numLeader(numModifier_keys)
	shiftLeader_keys := r35_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r35_expdLeader(expdModifier_keys)
	r35_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["n", regSpacingUp], (capSpacing): ["N", capSpacingUp], (regSpacing): ["n", regSpacingUp], (capSpacing): ["N", capSpacingUp]})
	return
*v::
	numModifier_keys := r36_numModifier()
	shiftModifier_keys := r36_shiftModifier()
	expdModifier_keys := r36_expdModifier()
	numLeader_keys := r36_numLeader(numModifier_keys)
	shiftLeader_keys := r36_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r36_expdLeader(expdModifier_keys)
	r36_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["v", regSpacingUp], (capSpacing): ["V", capSpacingUp], (regSpacing): ["v", regSpacingUp], (capSpacing): ["V", capSpacingUp]})
	return
	



; Bottom Row
;-------------------------------------------------

*Esc::
	numModifier_keys := l41_numModifier()
	shiftModifier_keys := l41_shiftModifier()
	expdModifier_keys := l41_expdModifier()
	numLeader_keys := l41_numLeader(numModifier_keys)
	shiftLeader_keys := l41_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l41_expdLeader(expdModifier_keys)
	l41_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*x::
	numModifier_keys := l42_numModifier()
	shiftModifier_keys := l42_shiftModifier()
	expdModifier_keys := l42_expdModifier()
	numLeader_keys := l42_numLeader(numModifier_keys)
	shiftLeader_keys := l42_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l42_expdLeader(expdModifier_keys)
	l42_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["x", regSpacingUp], (capSpacing): ["X", capSpacingUp]})
	return
*/::
	if(GetKeyState(rawState))
	{
		defaultKeys := [""""]
		regSpacingKeys := [""""]
		capSpacingKeys := [""""]
	}
	else
	{
		IniRead, inQuote, Status.ini, nestVars, inQuote
		IniRead, nestLevel, Status.ini, nestVars, nestLevel

		if(inQuote)
		{
			inQuote := false
			nestLevel := nestLevel - 1
			
			actuallyNeedToWrite := !(GetKeyState(shiftLeader) or GetKeyState(shiftModifier) or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or GetKeyState(numModifier))))
			
			if(actuallyNeedToWrite)
			{
				IniWrite, %inQuote%, Status.ini, nestVars, inQuote
				IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			}
		
			if(nestLevel > 0)
			{
				defaultKeys := ["Right", "Space", regSpacingDn]
				regSpacingKeys := ["Backspace", "Right", "Space"]
				capSpacingKeys := ["Backspace", "Right", "Space"]
			}
			else
			{
				defaultKeys := ["Right", "Space", regSpacingDn, nestedPunctuationUp]
				regSpacingKeys := ["Backspace", "Right", "Space", nestedPunctuationUp]
				capSpacingKeys := ["Backspace", "Right", "Space" nestedPunctuationUp]
			}
		}
		else
		{
			inQuote := true
			nestLevel := nestLevel + 1
			
			actuallyNeedToWrite := !(GetKeyState(shiftLeader) or GetKeyState(shiftModifier) or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or GetKeyState(numModifier))))
			
			if(actuallyNeedToWrite)
			{
				IniWrite, %inQuote%, Status.ini, nestVars, inQuote
				IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
				lastOpenPairDown := A_TickCount
				IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
			}
	
			if(GetKeyState(nestedPunctuation))
			{
				defaultKeys := ["Space", """", """", "Left", regSpacingDn]
				regSpacingKeys := ["""", """", "Left"]
				capSpacingKeys := ["""", """", "Left"]
			}
			else
			{
				defaultKeys := ["Space", """", """", "Left", regSpacingDn, nestedPunctuationDn]
				regSpacingKeys := ["""", """", "Left", nestedPunctuationDn]
				capSpacingKeys := ["""", """", "Left", nestedPunctuationDn]
			}
		}
	}
	
	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l43_shiftModifier()
	expdModifier_keys := l43_expdModifier()
	numLeader_keys := l43_numLeader(numModifier_keys)
	shiftLeader_keys := l43_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l43_expdLeader(expdModifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*;::
	if(GetKeyState(nestedPunctuation))
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel - 1
		
		actuallyNeedToWrite := !(GetKeyState(shiftLeader) or GetKeyState(shiftModifier) or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or GetKeyState(numModifier))))
			
		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
		}
	
		if(nestLevel > 0)

		{
			defaultKeys := ["Right", "Space", regSpacingDn]
			regSpacingKeys := ["Backspace", "Right", "Space"]
			capSpacingKeys := ["Backspace", "Right", "Space"]
		}
		else
		{
			defaultKeys := ["Right", "Space", regSpacingDn, nestedPunctuationUp]
			regSpacingKeys := ["Backspace", "Right", "Space", nestedPunctuationUp]
			capSpacingKeys := ["Backspace", "Right", "Space" nestedPunctuationUp]
		}
	}
	else
	{
		defaultKeys := [")"]
		regSpacingKeys := [")"]
		capSpacingKeys := [")"]
	}

	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l44_shiftModifier()
	expdModifier_keys := l44_expdModifier()
	numLeader_keys := l44_numLeader(numModifier_keys)
	shiftLeader_keys := l44_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l44_expdLeader(expdModifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*,::
	if(GetKeyState(rawState))
	{
		defaultKeys := [","]
		regSpacingKeys := [","]
		capSpacingKeys := [","]
	}
	else
	{	
		defaultKeys := [",", "Space", regSpacingDn]
		regSpacingKeys := ["Backspace", ",", "Space"]
		capSpacingKeys := ["Backspace", ",", regSpacingDn, capSpacingUp]
	}
	
	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	; We want normal comma behavior when holding shift down (=for VARS_LIKE_THIS), not em dashes
	; shiftModifier_keys := l45_shiftModifier()
	expdModifier_keys := l45_expdModifier()
	numLeader_keys := l45_numLeader(numModifier_keys)
	; No modifier keys defined above = no arguments
	shiftLeader_keys := l45_shiftLeader()
	expdLeader_keys := l45_expdLeader(expdModifier_keys)
	; Want em dash behavior. Redefine separately to avoid sending an extra shiftLeaderUp
	afterNum_keys := l45_afterNum()
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*`::
	if(GetKeyState(rawState))
	{
		defaultKeys := ["("]
		regSpacingKeys := ["("]
		capSpacingKeys := ["("]
	}
	else
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel + 1
		
		actuallyNeedToWrite := !(GetKeyState(shiftLeader) or GetKeyState(shiftModifier) or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or GetKeyState(numModifier))))
			
		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			lastOpenPairDown := A_TickCount
			IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
		}
		
		if(GetKeyState(nestedPunctuation))
		{
			defaultKeys := ["Space", "(", ")", "Left", regSpacingDn]
			regSpacingKeys := ["(", ")", "Left"]
			capSpacingKeys := ["(", ")", "Left"]
		}
		else
		{
			defaultKeys := ["Space", "(", ")", "Left", regSpacingDn, nestedPunctuationDn]
			regSpacingKeys := ["(", ")", "Left", nestedPunctuationDn]
			capSpacingKeys := ["(", ")", "Left", nestedPunctuationDn]
		}
	}

	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l46_shiftModifier()
	expdModifier_keys := l46_expdModifier()
	numLeader_keys := l46_numLeader(numModifier_keys)
	shiftLeader_keys := l46_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l46_expdLeader(expdModifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return


*w::
	numModifier_keys := r41_numModifier()
	shiftModifier_keys := r41_shiftModifier()
	expdModifier_keys := r41_expdModifier()
	numLeader_keys := r41_numLeader(numModifier_keys)
	shiftLeader_keys := r41_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r41_expdLeader(expdModifier_keys)
	r41_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["w", regSpacingUp], (capSpacing): ["W", capSpacingUp], (regSpacing): ["w", regSpacingUp], (capSpacing): ["W", capSpacingUp]})
	return
*g::
	numModifier_keys := r42_numModifier()
	shiftModifier_keys := r42_shiftModifier()
	expdModifier_keys := r42_expdModifier()
	numLeader_keys := r42_numLeader(numModifier_keys)
	shiftLeader_keys := r42_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r42_expdLeader(expdModifier_keys)
	r42_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["g", regSpacingUp], (capSpacing): ["G", capSpacingUp], (regSpacing): ["g", regSpacingUp], (capSpacing): ["G", capSpacingUp]})
	return
*f::
	numModifier_keys := r43_numModifier()
	shiftModifier_keys := r43_shiftModifier()
	expdModifier_keys := r43_expdModifier()
	numLeader_keys := r43_numLeader(numModifier_keys)
	shiftLeader_keys := r43_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r43_expdLeader(expdModifier_keys)
	r43_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["f", regSpacingUp], (capSpacing): ["F", capSpacingUp], (regSpacing): ["f", regSpacingUp], (capSpacing): ["F", capSpacingUp]})
	return
*j::
	numModifier_keys := r44_numModifier()
	shiftModifier_keys := r44_shiftModifier()
	expdModifier_keys := r44_expdModifier()
	numLeader_keys := r44_numLeader(numModifier_keys)
	shiftLeader_keys := r44_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r44_expdLeader(expdModifier_keys)
	r44_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["j", regSpacingUp], (capSpacing): ["J", capSpacingUp], (regSpacing): ["j", regSpacingUp], (capSpacing): ["J", capSpacingUp]})
	return
*z::
	numModifier_keys := r45_numModifier()
	shiftModifier_keys := r45_shiftModifier()
	expdModifier_keys := r45_expdModifier()
	numLeader_keys := r45_numLeader(numModifier_keys)
	shiftLeader_keys := r45_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r45_expdLeader(expdModifier_keys)
	r45_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (regSpacing): ["z", regSpacingUp], (capSpacing): ["Z", capSpacingUp], (regSpacing): ["z", regSpacingUp], (capSpacing): ["Z", capSpacingUp]})
	return
; Mirrored Vim key: not needed twice	
; *Esc::
;	expdLeader_keys := r46_expdLeader(expdModifier_keys)
;	expdModifier_keys := r46_expdModifier()
;	numLeader_keys := r46_numLeader(numModifier_keys)
;	numModifier_keys := r46_numModifier()
;	shiftLeader_keys := r46_shiftLeader(shiftModifier_keys)
;	shiftModifier_keys := r46_shiftModifier()
;	r46_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
;	return




; Extra Row
;-------------------------------------------------

*LShift::
	numModifier_keys := l52_numModifier()
	shiftModifier_keys := l52_shiftModifier()
	expdModifier_keys := l52_expdModifier()
	numLeader_keys := l52_numLeader(numModifier_keys)
	shiftLeader_keys := l52_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l52_expdLeader(expdModifier_keys)
	l52_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*CapsLock::
	numModifier_keys := l53_numModifier()
	shiftModifier_keys := l53_shiftModifier()
	expdModifier_keys := l53_expdModifier()
	numLeader_keys := l53_numLeader(numModifier_keys)
	shiftLeader_keys := l53_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l53_expdLeader(expdModifier_keys)
	l53_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Left::
	numModifier_keys := l54_numModifier()
	shiftModifier_keys := l54_shiftModifier()
	expdModifier_keys := l54_expdModifier()
	numLeader_keys := l54_numLeader(numModifier_keys)
	shiftLeader_keys := l54_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l54_expdLeader(expdModifier_keys)
	l54_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Right::
	numModifier_keys := l55_numModifier()
	shiftModifier_keys := l55_shiftModifier()
	expdModifier_keys := l55_expdModifier()
	numLeader_keys := l55_numLeader(numModifier_keys)
	shiftLeader_keys := l55_shiftLeader(shiftModifier_keys)
	expdLeader_keys := l55_expdLeader(expdModifier_keys)
	l55_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return


*Up::
	numModifier_keys := r52_numModifier()
	shiftModifier_keys := r52_shiftModifier()
	expdModifier_keys := r52_expdModifier()
	numLeader_keys := r52_numLeader(numModifier_keys)
	shiftLeader_keys := r52_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r52_expdLeader(expdModifier_keys)
	r52_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Down::
	numModifier_keys := r53_numModifier()
	shiftModifier_keys := r53_shiftModifier()
	expdModifier_keys := r53_expdModifier()
	numLeader_keys := r53_numLeader(numModifier_keys)
	shiftLeader_keys := r53_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r53_expdLeader(expdModifier_keys)
	r53_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*[::
	numModifier_keys := r54_numModifier()
	shiftModifier_keys := r54_shiftModifier()
	expdModifier_keys := r54_expdModifier()
	numLeader_keys := r54_numLeader(numModifier_keys)
	shiftLeader_keys := r54_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r54_expdLeader(expdModifier_keys)
	r54_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*]::
	numModifier_keys := r55_numModifier()
	shiftModifier_keys := r55_shiftModifier()
	expdModifier_keys := r55_expdModifier()
	numLeader_keys := r55_numLeader(numModifier_keys)
	shiftLeader_keys := r55_shiftLeader(shiftModifier_keys)
	expdLeader_keys := r55_expdLeader(expdModifier_keys)
	r55_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return




; Thumbs
;-------------------------------------------------

*Space::
	numModifier_keys := lt1_numModifier()
	shiftModifier_keys := lt1_shiftModifier()
	expdModifier_keys := lt1_expdModifier()
	numLeader_keys := lt1_numLeader(numModifier_keys)
	shiftLeader_keys := lt1_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt1_expdLeader(expdModifier_keys)
	lt1_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*1::
*1 Up::
	numModifier_keys := lt2_numModifier()
	shiftModifier_keys := lt2_shiftModifier()
	expdModifier_keys := lt2_expdModifier()
	numLeader_keys := lt2_numLeader(numModifier_keys)
	shiftLeader_keys := lt2_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt2_expdLeader(expdModifier_keys)
	lt2_afterNum()
	dual.combine(expdModifier, expdLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*LCtrl::
	numModifier_keys := lt3_numModifier()
	shiftModifier_keys := lt3_shiftModifier()
	expdModifier_keys := lt3_expdModifier()
	numLeader_keys := lt3_numLeader(numModifier_keys)
	shiftLeader_keys := lt3_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt3_expdLeader(expdModifier_keys)
	lt3_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*\::
	numModifier_keys := lt4_numModifier()
	shiftModifier_keys := lt4_shiftModifier()
	expdModifier_keys := lt4_expdModifier()
	numLeader_keys := lt4_numLeader(numModifier_keys)
	shiftLeader_keys := lt4_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt4_expdLeader(expdModifier_keys)
	lt4_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Home::
	numModifier_keys := lt5_numModifier()
	shiftModifier_keys := lt5_shiftModifier()
	expdModifier_keys := lt5_expdModifier()
	numLeader_keys := lt5_numLeader(numModifier_keys)
	shiftLeader_keys := lt5_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt5_expdLeader(expdModifier_keys)
	lt5_afterNum()
	; Handle toggle for autospacing
	dual.comboKey(rawStateDn, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys, (rawState): rawStateUp})
	return
*LAlt::
	numModifier_keys := lt6_numModifier()
	shiftModifier_keys := lt6_shiftModifier()
	expdModifier_keys := lt6_expdModifier()
	numLeader_keys := lt6_numLeader(numModifier_keys)
	shiftLeader_keys := lt6_shiftLeader(shiftModifier_keys)
	expdLeader_keys := lt6_expdLeader(expdModifier_keys)
	lt6_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return


*3::
	lastKey := A_PriorHotkey
	if(lastKey != "*3")
	{
		lastRealKeyDown := Dual.cleanKey(lastKey)
	}
	numModifier_keys := rt1_numModifier()
	shiftModifier_keys := rt1_shiftModifier()
	expdModifier_keys := rt1_expdModifier()
	numLeader_keys := rt1_numLeader(numModifier_keys)
	shiftLeader_keys := rt1_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt1_expdLeader(expdModifier_keys)
	rt1_afterNum()
	dual.combine(numModifier, numLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*3 Up::
	lastKey := A_PriorHotkey
	if(lastKey != "*3")
	{
		lastRealKeyDown := Dual.cleanKey(lastKey)
	}
	numModifier_keys := rt1_numModifier()
	shiftModifier_keys := rt1_shiftModifier()
	expdModifier_keys := rt1_expdModifier()
	numLeader_keys := rt1_numLeader(numModifier_keys)
	shiftLeader_keys := rt1_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt1_expdLeader(expdModifier_keys)
	rt1_afterNum()
	dual.combine(numModifier, numLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	
	; Activate afterNum layer on key-up to be able to type all punctuation after numbers
	SendInput {%afterNumDn%}
	
	return
*2::
*2 Up::
	numModifier_keys := rt2_numModifier()
	shiftModifier_keys := rt2_shiftModifier()
	expdModifier_keys := rt2_expdModifier()
	numLeader_keys := rt2_numLeader(numModifier_keys)
	shiftLeader_keys := rt2_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt2_expdLeader(expdModifier_keys)
	rt2_afterNum()
	dual.combine(shiftModifier, shiftLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*Enter::
	numModifier_keys := rt3_numModifier()
	shiftModifier_keys := rt3_shiftModifier()
	expdModifier_keys := rt3_expdModifier()
	numLeader_keys := rt3_numLeader(numModifier_keys)
	shiftLeader_keys := rt3_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt3_expdLeader(expdModifier_keys)
	rt3_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*PgDn::
	numModifier_keys := rt4_numModifier()
	shiftModifier_keys := rt4_shiftModifier()
	expdModifier_keys := rt4_expdModifier()
	numLeader_keys := rt4_numLeader(numModifier_keys)
	shiftLeader_keys := rt4_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt4_expdLeader(expdModifier_keys)
	rt4_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*PgUp::
	numModifier_keys := rt5_numModifier()
	shiftModifier_keys := rt5_shiftModifier()
	expdModifier_keys := rt5_expdModifier()
	numLeader_keys := rt5_numLeader(numModifier_keys)
	shiftLeader_keys := rt5_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt5_expdLeader(expdModifier_keys)
	rt5_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return
*RWin::
	numModifier_keys := rt6_numModifier()
	shiftModifier_keys := rt6_shiftModifier()
	expdModifier_keys := rt6_expdModifier()
	numLeader_keys := rt6_numLeader(numModifier_keys)
	shiftLeader_keys := rt6_shiftLeader(shiftModifier_keys)
	expdLeader_keys := rt6_expdLeader(expdModifier_keys)
	rt6_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expdLeader): expdLeader_keys, (expdModifier): expdModifier_keys})
	return




