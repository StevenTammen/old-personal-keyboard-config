SendMode Input
#NoEnv
#SingleInstance force



; Import Functions and Layers
;-------------------------------------------------

#Include <dual/dual>
#Include <functions>

#Include <expdLeader>
#Include <expdModifier>
#Include <numLeader>
#Include <numModifier>
#Include <shiftLeader>
#Include <shiftModifier>
#Include <afterNum>



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07  



; Initialize Objects And Status Variables
;-------------------------------------------------

; Make dual object
global dual := new Dual

; Store the nest level in an .ini file so it is accessible in the expand script
global nestLevel := 0
IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

; Store the quote status in an .ini file so it is accessible in the expand script
global inQuote := false
IniWrite, %inQuote%, Status.ini, nestVars, inQuote 

; To allow for the deletion of paired characters as long as nothing else has been typed
global lastOpenPairDown := A_TickCount
IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown 

; Enable passing through capitalization for commands as a block (rather than capitalizing the first letter of the command).
global command_PassThroughAutospacing := "none"
IniWrite, %command_PassThroughAutospacing%, Status.ini, commandVars, command_PassThroughAutospacing

; To allow for Enters pressed close together to function differently from those pressed far apart
global lastEnterDown := A_TickCount 

; Track keypresses before layers are activated to use in place of A_PriorHotkey (which returns the layer key, not the actual prior key)
global lastRealKeyDown := ""



; Initialize Layer Keys
;-------------------------------------------------

; High to Low Priority: expd keys need to come first so that we can use the shift/num leaders for expansions.
; Num keys come before shift keys so that you can use the number layer when shift is locked down (double tapped)

global expdLeader := "VK88"
global expdModifier := "VK89"
global numLeader := "VK8A"
global numModifier := "VK8B"
global shiftLeader := "VK8C"
global shiftModifier := "VK8D"
global afterNum := "VK8E"
global rawLeader := "VK8F"
global rawState := "VK97"
global regSpacing := "VK98"
global capSpacing := "VK99"
global nestedPunctuation := "VKD8"



; Number Row
;-------------------------------------------------

*=::
	expdLeader_keys = l11_expdLeader()
	expdModifier_keys = l11_expdModifier()
	numLeader_keys = l11_numLeader()
	numModifier_keys = l11_numModifier()
	shiftLeader_keys = l11_shiftLeader()
	shiftModifier_keys = l11_shiftModifier()
	afterNum_keys = l11_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*RShift:
	expdLeader_keys = l12_expdLeader()
	expdModifier_keys = l12_expdModifier()
	numLeader_keys = l12_numLeader()
	numModifier_keys = l12_numModifier()
	shiftLeader_keys = l12_shiftLeader()
	shiftModifier_keys = l12_shiftModifier()
	afterNum_keys = l12_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*RCtrl::
	expdLeader_keys = l13_expdLeader()
	expdModifier_keys = l13_expdModifier()
	numLeader_keys = l13_numLeader()
	numModifier_keys = l13_numModifier()
	shiftLeader_keys = l13_shiftLeader()
	shiftModifier_keys = l13_shiftModifier()
	afterNum_keys = l13_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Del::
	expdLeader_keys = l14_expdLeader()
	expdModifier_keys = l14_expdModifier()
	numLeader_keys = l14_numLeader()
	numModifier_keys = l14_numModifier()
	shiftLeader_keys = l14_shiftLeader()
	shiftModifier_keys = l14_shiftModifier()
	afterNum_keys = l14_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*4::
	expdLeader_keys = l15_expdLeader()
	expdModifier_keys = l15_expdModifier()
	numLeader_keys = l15_numLeader()
	numModifier_keys = l15_numModifier()
	shiftLeader_keys = l15_shiftLeader()
	shiftModifier_keys = l15_shiftModifier()
	afterNum_keys = l15_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*5::
	expdLeader_keys = l16_expdLeader()
	expdModifier_keys = l16_expdModifier()
	numLeader_keys = l16_numLeader()
	numModifier_keys = l16_numModifier()
	shiftLeader_keys = l16_shiftLeader()
	shiftModifier_keys = l16_shiftModifier()
	afterNum_keys = l16_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*6::
	expdLeader_keys = r11_expdLeader()
	expdModifier_keys = r11_expdModifier()
	numLeader_keys = r11_numLeader()
	numModifier_keys = r11_numModifier()
	shiftLeader_keys = r11_shiftLeader()
	shiftModifier_keys = r11_shiftModifier()
	afterNum_keys = r11_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*7::
	expdLeader_keys = r12_expdLeader()
	expdModifier_keys = r12_expdModifier()
	numLeader_keys = r12_numLeader()
	numModifier_keys = r12_numModifier()
	shiftLeader_keys = r12_shiftLeader()
	shiftModifier_keys = r12_shiftModifier()
	afterNum_keys = r12_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*8::
	expdLeader_keys = r13_expdLeader()
	expdModifier_keys = r13_expdModifier()
	numLeader_keys = r13_numLeader()
	numModifier_keys = r13_numModifier()
	shiftLeader_keys = r13_shiftLeader()
	shiftModifier_keys = r13_shiftModifier()
	afterNum_keys = r13_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*9::
	expdLeader_keys = r14_expdLeader()
	expdModifier_keys = r14_expdModifier()
	numLeader_keys = r14_numLeader()
	numModifier_keys = r14_numModifier()
	shiftLeader_keys = r14_shiftLeader()
	shiftModifier_keys = r14_shiftModifier()
	afterNum_keys = r14_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*0::
	expdLeader_keys = r15_expdLeader()
	expdModifier_keys = r15_expdModifier()
	numLeader_keys = r15_numLeader()
	numModifier_keys = r15_numModifier()
	shiftLeader_keys = r15_shiftLeader()
	shiftModifier_keys = r15_shiftModifier()
	afterNum_keys = r15_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*-::
	expdLeader_keys = r16_expdLeader()
	expdModifier_keys = r16_expdModifier()
	numLeader_keys = r16_numLeader()
	numModifier_keys = r16_numModifier()
	shiftLeader_keys = r16_shiftLeader()
	shiftModifier_keys = r16_shiftModifier()
	afterNum_keys = r16_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return




; Top Row
;-------------------------------------------------

*Tab::
	expdLeader_keys = l21_expdLeader()
	expdModifier_keys = l21_expdModifier()
	numLeader_keys = l21_numLeader()
	numModifier_keys = l21_numModifier()
	shiftLeader_keys = l21_shiftLeader()
	shiftModifier_keys = l21_shiftModifier()
	afterNum_keys = l21_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*b:
	expdLeader_keys = l22_expdLeader()
	expdModifier_keys = l22_expdModifier()
	numLeader_keys = l22_numLeader()
	numModifier_keys = l22_numModifier()
	shiftLeader_keys = l22_shiftLeader()
	shiftModifier_keys = l22_shiftModifier()
	afterNum_keys = l22_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*y::
	expdLeader_keys = l23_expdLeader()
	expdModifier_keys = l23_expdModifier()
	numLeader_keys = l23_numLeader()
	numModifier_keys = l23_numModifier()
	shiftLeader_keys = l23_shiftLeader()
	shiftModifier_keys = l23_shiftModifier()
	afterNum_keys = l23_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*o::
	expdLeader_keys = l24_expdLeader()
	expdModifier_keys = l24_expdModifier()
	numLeader_keys = l24_numLeader()
	numModifier_keys = l24_numModifier()
	shiftLeader_keys = l24_shiftLeader()
	shiftModifier_keys = l24_shiftModifier()
	afterNum_keys = l24_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*u::
	expdLeader_keys = l25_expdLeader()
	expdModifier_keys = l25_expdModifier()
	numLeader_keys = l25_numLeader()
	numModifier_keys = l25_numModifier()
	shiftLeader_keys = l25_shiftLeader()
	shiftModifier_keys = l25_shiftModifier()
	afterNum_keys = l25_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*'::
	expdLeader_keys = l26_expdLeader()
	expdModifier_keys = l26_expdModifier()
	numLeader_keys = l26_numLeader()
	numModifier_keys = l26_numModifier()
	shiftLeader_keys = l26_shiftLeader()
	shiftModifier_keys = l26_shiftModifier()
	afterNum_keys = l26_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*k::
	expdLeader_keys = r21_expdLeader()
	expdModifier_keys = r21_expdModifier()
	numLeader_keys = r21_numLeader()
	numModifier_keys = r21_numModifier()
	shiftLeader_keys = r21_shiftLeader()
	shiftModifier_keys = r21_shiftModifier()
	afterNum_keys = r21_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*d::
	expdLeader_keys = r22_expdLeader()
	expdModifier_keys = r22_expdModifier()
	numLeader_keys = r22_numLeader()
	numModifier_keys = r22_numModifier()
	shiftLeader_keys = r22_shiftLeader()
	shiftModifier_keys = r22_shiftModifier()
	afterNum_keys = r22_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*c::
	expdLeader_keys = r23_expdLeader()
	expdModifier_keys = r23_expdModifier()
	numLeader_keys = r23_numLeader()
	numModifier_keys = r23_numModifier()
	shiftLeader_keys = r23_shiftLeader()
	shiftModifier_keys = r23_shiftModifier()
	afterNum_keys = r23_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*l::
	expdLeader_keys = r24_expdLeader()
	expdModifier_keys = r24_expdModifier()
	numLeader_keys = r24_numLeader()
	numModifier_keys = r24_numModifier()
	shiftLeader_keys = r24_shiftLeader()
	shiftModifier_keys = r24_shiftModifier()
	afterNum_keys = r24_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*p::
	expdLeader_keys = r25_expdLeader()
	expdModifier_keys = r25_expdModifier()
	numLeader_keys = r25_numLeader()
	numModifier_keys = r25_numModifier()
	shiftLeader_keys = r25_shiftLeader()
	shiftModifier_keys = r25_shiftModifier()
	afterNum_keys = r25_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*q::
	expdLeader_keys = r26_expdLeader()
	expdModifier_keys = r26_expdModifier()
	numLeader_keys = r26_numLeader()
	numModifier_keys = r26_numModifier()
	shiftLeader_keys = r26_shiftLeader()
	shiftModifier_keys = r26_shiftModifier()
	afterNum_keys = r26_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return




; Home Row
;-------------------------------------------------

*Backspace::
	expdLeader_keys = l31_expdLeader()
	expdModifier_keys = l31_expdModifier()
	numLeader_keys = l31_numLeader()
	numModifier_keys = l31_numModifier()
	shiftLeader_keys = l31_shiftLeader()
	shiftModifier_keys = l31_shiftModifier()
	afterNum_keys = l31_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*h:
	expdLeader_keys = l32_expdLeader()
	expdModifier_keys = l32_expdModifier()
	numLeader_keys = l32_numLeader()
	numModifier_keys = l32_numModifier()
	shiftLeader_keys = l32_shiftLeader()
	shiftModifier_keys = l32_shiftModifier()
	afterNum_keys = l32_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*i::
	expdLeader_keys = l33_expdLeader()
	expdModifier_keys = l33_expdModifier()
	numLeader_keys = l33_numLeader()
	numModifier_keys = l33_numModifier()
	shiftLeader_keys = l33_shiftLeader()
	shiftModifier_keys = l33_shiftModifier()
	afterNum_keys = l33_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*e::
	expdLeader_keys = l34_expdLeader()
	expdModifier_keys = l34_expdModifier()
	numLeader_keys = l34_numLeader()
	numModifier_keys = l34_numModifier()
	shiftLeader_keys = l34_shiftLeader()
	shiftModifier_keys = l34_shiftModifier()
	afterNum_keys = l34_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*a::
	expdLeader_keys = l35_expdLeader()
	expdModifier_keys = l35_expdModifier()
	numLeader_keys = l35_numLeader()
	numModifier_keys = l35_numModifier()
	shiftLeader_keys = l35_shiftLeader()
	shiftModifier_keys = l35_shiftModifier()
	afterNum_keys = l35_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*.::
	expdLeader_keys = l36_expdLeader()
	expdModifier_keys = l36_expdModifier()
	numLeader_keys = l36_numLeader()
	numModifier_keys = l36_numModifier()
	shiftLeader_keys = l36_shiftLeader()
	shiftModifier_keys = l36_shiftModifier()
	afterNum_keys = l36_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*m::
	expdLeader_keys = r31_expdLeader()
	expdModifier_keys = r31_expdModifier()
	numLeader_keys = r31_numLeader()
	numModifier_keys = r31_numModifier()
	shiftLeader_keys = r31_shiftLeader()
	shiftModifier_keys = r31_shiftModifier()
	afterNum_keys = r31_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*t::
	expdLeader_keys = r32_expdLeader()
	expdModifier_keys = r32_expdModifier()
	numLeader_keys = r32_numLeader()
	numModifier_keys = r32_numModifier()
	shiftLeader_keys = r32_shiftLeader()
	shiftModifier_keys = r32_shiftModifier()
	afterNum_keys = r32_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*s::
	expdLeader_keys = r33_expdLeader()
	expdModifier_keys = r33_expdModifier()
	numLeader_keys = r33_numLeader()
	numModifier_keys = r33_numModifier()
	shiftLeader_keys = r33_shiftLeader()
	shiftModifier_keys = r33_shiftModifier()
	afterNum_keys = r33_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*r::
	expdLeader_keys = r34_expdLeader()
	expdModifier_keys = r34_expdModifier()
	numLeader_keys = r34_numLeader()
	numModifier_keys = r34_numModifier()
	shiftLeader_keys = r34_shiftLeader()
	shiftModifier_keys = r34_shiftModifier()
	afterNum_keys = r34_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*n::
	expdLeader_keys = r35_expdLeader()
	expdModifier_keys = r35_expdModifier()
	numLeader_keys = r35_numLeader()
	numModifier_keys = r35_numModifier()
	shiftLeader_keys = r35_shiftLeader()
	shiftModifier_keys = r35_shiftModifier()
	afterNum_keys = r35_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*v::
	expdLeader_keys = r36_expdLeader()
	expdModifier_keys = r36_expdModifier()
	numLeader_keys = r36_numLeader()
	numModifier_keys = r36_numModifier()
	shiftLeader_keys = r36_shiftLeader()
	shiftModifier_keys = r36_shiftModifier()
	afterNum_keys = r36_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
	



; Bottom Row
;-------------------------------------------------

*Esc::
	expdLeader_keys = l41_expdLeader()
	expdModifier_keys = l41_expdModifier()
	numLeader_keys = l41_numLeader()
	numModifier_keys = l41_numModifier()
	shiftLeader_keys = l41_shiftLeader()
	shiftModifier_keys = l41_shiftModifier()
	afterNum_keys = l41_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*x:
	expdLeader_keys = l42_expdLeader()
	expdModifier_keys = l42_expdModifier()
	numLeader_keys = l42_numLeader()
	numModifier_keys = l42_numModifier()
	shiftLeader_keys = l42_shiftLeader()
	shiftModifier_keys = l42_shiftModifier()
	afterNum_keys = l42_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*/::
	expdLeader_keys = l43_expdLeader()
	expdModifier_keys = l43_expdModifier()
	numLeader_keys = l43_numLeader()
	numModifier_keys = l43_numModifier()
	shiftLeader_keys = l43_shiftLeader()
	shiftModifier_keys = l43_shiftModifier()
	afterNum_keys = l43_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*;::
	expdLeader_keys = l44_expdLeader()
	expdModifier_keys = l44_expdModifier()
	numLeader_keys = l44_numLeader()
	numModifier_keys = l44_numModifier()
	shiftLeader_keys = l44_shiftLeader()
	shiftModifier_keys = l44_shiftModifier()
	afterNum_keys = l44_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*,::
	expdLeader_keys = l45_expdLeader()
	expdModifier_keys = l45_expdModifier()
	numLeader_keys = l45_numLeader()
	numModifier_keys = l45_numModifier()
	shiftLeader_keys = l45_shiftLeader()
	shiftModifier_keys = l45_shiftModifier()
	afterNum_keys = l45_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*`::
	expdLeader_keys = l46_expdLeader()
	expdModifier_keys = l46_expdModifier()
	numLeader_keys = l46_numLeader()
	numModifier_keys = l46_numModifier()
	shiftLeader_keys = l46_shiftLeader()
	shiftModifier_keys = l46_shiftModifier()
	afterNum_keys = l46_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*w::
	expdLeader_keys = r41_expdLeader()
	expdModifier_keys = r41_expdModifier()
	numLeader_keys = r41_numLeader()
	numModifier_keys = r41_numModifier()
	shiftLeader_keys = r41_shiftLeader()
	shiftModifier_keys = r41_shiftModifier()
	afterNum_keys = r41_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*g::
	expdLeader_keys = r42_expdLeader()
	expdModifier_keys = r42_expdModifier()
	numLeader_keys = r42_numLeader()
	numModifier_keys = r42_numModifier()
	shiftLeader_keys = r42_shiftLeader()
	shiftModifier_keys = r42_shiftModifier()
	afterNum_keys = r42_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*f::
	expdLeader_keys = r43_expdLeader()
	expdModifier_keys = r43_expdModifier()
	numLeader_keys = r43_numLeader()
	numModifier_keys = r43_numModifier()
	shiftLeader_keys = r43_shiftLeader()
	shiftModifier_keys = r43_shiftModifier()
	afterNum_keys = r43_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*j::
	expdLeader_keys = r44_expdLeader()
	expdModifier_keys = r44_expdModifier()
	numLeader_keys = r44_numLeader()
	numModifier_keys = r44_numModifier()
	shiftLeader_keys = r44_shiftLeader()
	shiftModifier_keys = r44_shiftModifier()
	afterNum_keys = r44_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*z::
	expdLeader_keys = r45_expdLeader()
	expdModifier_keys = r45_expdModifier()
	numLeader_keys = r45_numLeader()
	numModifier_keys = r45_numModifier()
	shiftLeader_keys = r45_shiftLeader()
	shiftModifier_keys = r45_shiftModifier()
	afterNum_keys = r45_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
; Mirrored Vim key: not needed twice	
; *Esc::
;	expdLeader_keys = r46_expdLeader()
;	expdModifier_keys = r46_expdModifier()
;	numLeader_keys = r46_numLeader()
;	numModifier_keys = r46_numModifier()
;	shiftLeader_keys = r46_shiftLeader()
;	shiftModifier_keys = r46_shiftModifier()
;	afterNum_keys = r46_afterNum()
;	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
;	return




; Extra Row
;-------------------------------------------------

*LShift::
	expdLeader_keys = l52_expdLeader()
	expdModifier_keys = l52_expdModifier()
	numLeader_keys = l52_numLeader()
	numModifier_keys = l52_numModifier()
	shiftLeader_keys = l52_shiftLeader()
	shiftModifier_keys = l52_shiftModifier()
	afterNum_keys = l52_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*CapsLock::
	expdLeader_keys = l53_expdLeader()
	expdModifier_keys = l53_expdModifier()
	numLeader_keys = l53_numLeader()
	numModifier_keys = l53_numModifier()
	shiftLeader_keys = l53_shiftLeader()
	shiftModifier_keys = l53_shiftModifier()
	afterNum_keys = l53_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Left::
	expdLeader_keys = l54_expdLeader()
	expdModifier_keys = l54_expdModifier()
	numLeader_keys = l54_numLeader()
	numModifier_keys = l54_numModifier()
	shiftLeader_keys = l54_shiftLeader()
	shiftModifier_keys = l54_shiftModifier()
	afterNum_keys = l54_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Right::
	expdLeader_keys = l55_expdLeader()
	expdModifier_keys = l55_expdModifier()
	numLeader_keys = l55_numLeader()
	numModifier_keys = l55_numModifier()
	shiftLeader_keys = l55_shiftLeader()
	shiftModifier_keys = l55_shiftModifier()
	afterNum_keys = l55_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*Up::
	expdLeader_keys = r52_expdLeader()
	expdModifier_keys = r52_expdModifier()
	numLeader_keys = r52_numLeader()
	numModifier_keys = r52_numModifier()
	shiftLeader_keys = r52_shiftLeader()
	shiftModifier_keys = r52_shiftModifier()
	afterNum_keys = r52_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Down::
	expdLeader_keys = r53_expdLeader()
	expdModifier_keys = r53_expdModifier()
	numLeader_keys = r53_numLeader()
	numModifier_keys = r53_numModifier()
	shiftLeader_keys = r53_shiftLeader()
	shiftModifier_keys = r53_shiftModifier()
	afterNum_keys = r53_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*[::
	expdLeader_keys = r54_expdLeader()
	expdModifier_keys = r54_expdModifier()
	numLeader_keys = r54_numLeader()
	numModifier_keys = r54_numModifier()
	shiftLeader_keys = r54_shiftLeader()
	shiftModifier_keys = r54_shiftModifier()
	afterNum_keys = r54_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*]::
	expdLeader_keys = r55_expdLeader()
	expdModifier_keys = r55_expdModifier()
	numLeader_keys = r55_numLeader()
	numModifier_keys = r55_numModifier()
	shiftLeader_keys = r55_shiftLeader()
	shiftModifier_keys = r55_shiftModifier()
	afterNum_keys = r55_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return




; Thumbs
;-------------------------------------------------

*Space::
	expdLeader_keys = lt1_expdLeader()
	expdModifier_keys = lt1_expdModifier()
	numLeader_keys = lt1_numLeader()
	numModifier_keys = lt1_numModifier()
	shiftLeader_keys = lt1_shiftLeader()
	shiftModifier_keys = lt1_shiftModifier()
	afterNum_keys = lt1_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*1::
*1 Up::
	expdLeader_keys = lt2_expdLeader()
	expdModifier_keys = lt2_expdModifier()
	numLeader_keys = lt2_numLeader()
	numModifier_keys = lt2_numModifier()
	shiftLeader_keys = lt2_shiftLeader()
	shiftModifier_keys = lt2_shiftModifier()
	afterNum_keys = lt2_afterNum()
	dual.combine(expdModifier, expdLeader Down, settings = false, {expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*LCtrl::
	expdLeader_keys = lt3_expdLeader()
	expdModifier_keys = lt3_expdModifier()
	numLeader_keys = lt3_numLeader()
	numModifier_keys = lt3_numModifier()
	shiftLeader_keys = lt3_shiftLeader()
	shiftModifier_keys = lt3_shiftModifier()
	afterNum_keys = lt3_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*\::
	expdLeader_keys = lt4_expdLeader()
	expdModifier_keys = lt4_expdModifier()
	numLeader_keys = lt4_numLeader()
	numModifier_keys = lt4_numModifier()
	shiftLeader_keys = lt4_shiftLeader()
	shiftModifier_keys = lt4_shiftModifier()
	afterNum_keys = lt4_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Home::
	expdLeader_keys = lt5_expdLeader()
	expdModifier_keys = lt5_expdModifier()
	numLeader_keys = lt5_numLeader()
	numModifier_keys = lt5_numModifier()
	shiftLeader_keys = lt5_shiftLeader()
	shiftModifier_keys = lt5_shiftModifier()
	afterNum_keys = lt5_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*LAlt::
	expdLeader_keys = lt6_expdLeader()
	expdModifier_keys = lt6_expdModifier()
	numLeader_keys = lt6_numLeader()
	numModifier_keys = lt6_numModifier()
	shiftLeader_keys = lt6_shiftLeader()
	shiftModifier_keys = lt6_shiftModifier()
	afterNum_keys = lt6_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return


*3::
	lastKey := A_PriorHotkey
	if(lastKey != "*3")
	{
		lastRealKeyDown := Dual.cleanKey(lastKey)
	}
	expdLeader_keys = rt1_expdLeader()
	expdModifier_keys = rt1_expdModifier()
	numLeader_keys = rt1_numLeader()
	numModifier_keys = rt1_numModifier()
	shiftLeader_keys = rt1_shiftLeader()
	shiftModifier_keys = rt1_shiftModifier()
	afterNum_keys = rt1_afterNum()
	dual.combine(numModifier, numLeader Down, settings = false, {expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*3 Up::
	lastKey := A_PriorHotkey
	if(lastKey != "*3")
	{
		lastRealKeyDown := Dual.cleanKey(lastKey)
	}
	expdLeader_keys = rt1_expdLeader()
	expdModifier_keys = rt1_expdModifier()
	numLeader_keys = rt1_numLeader()
	numModifier_keys = rt1_numModifier()
	shiftLeader_keys = rt1_shiftLeader()
	shiftModifier_keys = rt1_shiftModifier()
	afterNum_keys = rt1_afterNum()
	dual.combine(numModifier, numLeader Down, settings = false, {expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	
	; Activate afterNum layer on key-up to be able to type all punctuation after numbers
	SendInput {%afterNum% Down}
	
	return
*2::
*2 Up::
	expdLeader_keys = rt2_expdLeader()
	expdModifier_keys = rt2_expdModifier()
	numLeader_keys = rt2_numLeader()
	numModifier_keys = rt2_numModifier()
	shiftLeader_keys = rt2_shiftLeader()
	shiftModifier_keys = rt2_shiftModifier()
	afterNum_keys = rt2_afterNum()
	dual.combine(shiftModifier, shiftLeader Down, settings = false, {expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*Enter::
	expdLeader_keys = rt3_expdLeader()
	expdModifier_keys = rt3_expdModifier()
	numLeader_keys = rt3_numLeader()
	numModifier_keys = rt3_numModifier()
	shiftLeader_keys = rt3_shiftLeader()
	shiftModifier_keys = rt3_shiftModifier()
	afterNum_keys = rt3_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*PgDn::
	expdLeader_keys = rt4_expdLeader()
	expdModifier_keys = rt4_expdModifier()
	numLeader_keys = rt4_numLeader()
	numModifier_keys = rt4_numModifier()
	shiftLeader_keys = rt4_shiftLeader()
	shiftModifier_keys = rt4_shiftModifier()
	afterNum_keys = rt4_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*PgUp::
	expdLeader_keys = rt5_expdLeader()
	expdModifier_keys = rt5_expdModifier()
	numLeader_keys = rt5_numLeader()
	numModifier_keys = rt5_numModifier()
	shiftLeader_keys = rt5_shiftLeader()
	shiftModifier_keys = rt5_shiftModifier()
	afterNum_keys = rt5_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return
*RWin::
	expdLeader_keys = rt6_expdLeader()
	expdModifier_keys = rt6_expdModifier()
	numLeader_keys = rt6_numLeader()
	numModifier_keys = rt6_numModifier()
	shiftLeader_keys = rt6_shiftLeader()
	shiftModifier_keys = rt6_shiftModifier()
	afterNum_keys = rt6_afterNum()
	dual.comboKey({expdLeader: expdLeader_keys, expdModifier: expdModifier_keys, numLeader: numLeader_keys, numModifier: numModifier_keys, shiftLeader: shiftLeader_keys, shiftModifier: shiftModifier_keys, afterNum: afterNum_keys})
	return




