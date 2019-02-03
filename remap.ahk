#NoEnv
SendMode Input
#SingleInstance force
SetWorkingDir %A_ScriptDir%



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07  



; Imports
;-------------------------------------------------

#Include <dual/dual>
#Include <functions>
#Include <virtualDesktops>

#Include <layers/vim>
#Include <layers/numModifier>
#Include <layers/numLeader>
#Include <layers/shiftModifier>
#Include <layers/shiftLeader>
#Include <layers/expd1Modifier>
#Include <layers/expd1Leader>
#Include <layers/expd2Modifier>
#Include <layers/expd2Leader>
#Include <layers/afterNum>

#Include <layers/modifiers/Alt>
#Include <layers/modifiers/AltShift>
#Include <layers/modifiers/AltShiftWin>
#Include <layers/modifiers/AltWin>
#Include <layers/modifiers/Ctrl>
#Include <layers/modifiers/CtrlAlt>
#Include <layers/modifiers/CtrlAltShift>
#Include <layers/modifiers/CtrlAltShiftWin>
#Include <layers/modifiers/CtrlAltWin>
#Include <layers/modifiers/CtrlShift>
#Include <layers/modifiers/CtrlShiftWin>
#Include <layers/modifiers/CtrlWin>
#Include <layers/modifiers/ShiftWin>
#Include <layers/modifiers/Win>



; Initialize Objects And Status Variables
;-------------------------------------------------

; Make dual object
dual := new Dual

; Use a variable to keep track of what sort of nesting behavior is enabled.
; Options: "paired", "unpaired"
nestingType := "unpaired"
IniWrite, %nestingType%, Status.ini, nestVars, nestingType

; Store the nest level in an .ini file so it is accessible in the expand script
nestLevel := 0
IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

; Store the list of closing characters that (may) need to be entered.
; This implementation uses a string-based stack to use IniRead/IniWrite
closingChars := ""
IniWrite, %closingChars%, Status.ini, nestVars, closingChars

; To allow for the deletion of paired characters as long as nothing else has been typed
lastOpenPairDown := A_TickCount
IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown

; Enable passing through capitalization for subscripts as a block (rather than capitalizing the first letter of the subscript).
; Stored in Status.ini to allow for resetting with Esc.
global subscript_PassThroughCap := false
IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap 

; Enable passing through capitalization for superscripts as a block (rather than capitalizing the first letter of the superscript).
; Stored in Status.ini to allow for resetting with Esc.
global superscript_PassThroughCap := false
IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap

; Keep track of capitalization caused by ?! on the afterNum layer to properly handle expansion capitalization after them
capBecauseOfAfterNumPunc := false
IniWrite, %capBecauseOfAfterNumPunc%, Status.ini, statusVars, capBecauseOfAfterNumPunc

; Track keypresses before layers are activated to use in place of A_PriorHotkey (which returns the layer key, not the actual prior key)
global lastRealKeyDown := ""

; Use a variable to override key behavior when in a sort of global command mode
; (cf. Vim)
global vimMode := false
IniWrite, %vimMode%, Status.ini, statusVars, vimMode

; Use a variable to keep track of the spacing state before entering Vim mode
; so that it can be properly restored.
global autoSpacingBeforeVim := true

; Track key downs to deal with GetKeyState() being unreliable when handling dual-role keys' down states
; for times close to initial actuation
global shiftDownNoUp := false
global numDownNoUp := false
global expdDownNoUp := false

global ctrlDownNoUp := false
global altDownNoUp := false
global winDownNoUp := false



; Create Key Aliases
;-------------------------------------------------

; Num keys come before shift keys so that you can use the number layer when shift is locked down (double tapped)
; Num keys and shift keys come before expd keys so that you can expand a wider subset of characters

; To use these as keys in associative arrays, you have to enclose them in parentheses. 
; For example: ~{(numLeader): numLeader_keys}~

global numLeader := "VK0E"
global numModifier := "VK0F"
global shiftLeader := "VK16"
global shiftModifier := "VK1A"
global expd1Leader := "VK3A"
global expd1Modifier := "VK3B"
global expd2Leader := "VK3C"
global expd2Modifier := "VK3D"
global afterNum := "VK3E"
global rawLeader := "VK3F"
global rawState := "VK40"
global regSpacing := "VK88"
global capSpacing := "VK89"
global nestedPunctuation := "VK8A"

global ctrlLeader := "VK8B"
global altLeader := "VK8C"
global winLeader := "VK8D"

; Explicit down and up variables are defined for ease of use: using expression syntax and straight key definitions,
; you would need concatenation like ~keyVar . " Down"~ and ~keyVar . " Up"~, which is a bit verbose.
; I have found AHK's expression/%traditional syntax% quite bug-prone, so have opted to do it this way.

global numLeaderDn := "VK0E Down"
global numModifierDn := "VK0F Down"
global shiftLeaderDn := "VK16 Down"
global shiftModifierDn := "VK1A Down"
global expd1LeaderDn := "VK3A Down"
global expd1ModifierDn := "VK3B Down"
global expd2LeaderDn := "VK3C Down"
global expd2ModifierDn := "VK3D Down"
global afterNumDn := "VK3E Down"
global rawLeaderDn := "VK3F Down"
global rawStateDn := "VK40 Down"
global regSpacingDn := "VK88 Down"
global capSpacingDn := "VK89 Down"
global nestedPunctuationDn := "VK8A Down"

global ctrlLeaderDn := "VK8B Down"
global altLeaderDn := "VK8C Down"
global winLeaderDn := "VK8D Down"


global numLeaderUp := "VK0E Up"
global numModifierUp := "VK0F Up"
global shiftLeaderUp := "VK16 Up"
global shiftModifierUp := "VK1A Up"
global expd1LeaderUp := "VK3A Up"
global expd1ModifierUp := "VK3B Up"
global expd2LeaderUp := "VK3C Up"
global expd2ModifierUp := "VK3D Up"
global afterNumUp := "VK3E Up"
global rawLeaderUp := "VK3F Up"
global rawStateUp := "VK40 Up"
global regSpacingUp := "VK88 Up"
global capSpacingUp := "VK89 Up"
global nestedPunctuationUp := "VK8A Up"

global ctrlLeaderUp := "VK8B Up"
global altLeaderUp := "VK8C Up"
global winLeaderUp := "VK8D Up"



; Number Row
;-------------------------------------------------

*=::
	numModifier_keys := l11_numModifier()
	shiftModifier_keys := l11_shiftModifier()
	expd1Modifier_keys := l11_expd1Modifier()
	expd2Modifier_keys := l11_expd2Modifier()
	numLeader_keys := l11_numLeader(numModifier_keys)
	shiftLeader_keys := l11_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l11_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l11_expd2Leader(expd2Modifier_keys)
	l11_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return
	
*LShift::
	if(GetKeyState(shiftLeader))
	{
		l12_shiftLeader()
	}
	else if(shiftDownNoUp)
	{
		l12_shiftModifier()
	}
	else if(GetKeyState(expd2Leader))
	{
		l12_expd2Leader()
	}
	else if(expd2DownNoUp)
	{
		l12_expd2Modifier()
	}
	else if(GetKeyState(expd1Leader))
	{
		l12_expd1Leader()
	}
	else if(expd1DownNoUp)
	{
		l12_expd1Modifier()
	}
	else
	{
		FocusWindow("unlayered", "farLeft")
	}
	return
	
*RShift::
	if(GetKeyState(shiftLeader))
	{
		l13_shiftLeader()
	}
	else if(shiftDownNoUp)
	{
		l13_shiftModifier()
	}
	else if(GetKeyState(expd2Leader))
	{
		l13_expd2Leader()
	}
	else if(expd2DownNoUp)
	{
		l13_expd2Modifier()
	}
	else if(GetKeyState(expd1Leader))
	{
		l13_expd1Leader()
	}
	else if(expd1DownNoUp)
	{
		l13_expd1Modifier()
	}
	else
	{
		FocusWindow("unlayered", "midLeft")
	}
	return
	
*Del::
	if(GetKeyState(shiftLeader))
	{
		l14_shiftLeader()
	}
	else if(shiftDownNoUp)
	{
		l14_shiftModifier()
	}
	else if(GetKeyState(expd2Leader))
	{
		l14_expd2Leader()
	}
	else if(expd2DownNoUp)
	{
		l14_expd2Modifier()
	}
	else if(GetKeyState(expd1Leader))
	{
		l14_expd1Leader()
	}
	else if(expd1DownNoUp)
	{
		l14_expd1Modifier()
	}
	else
	{
		FocusWindow("unlayered", "midRight")
	}
	return
	
*4::
	if(GetKeyState(shiftLeader))
	{
		l15_shiftLeader()
	}
	else if(shiftDownNoUp)
	{
		l15_shiftModifier()
	}
	else if(GetKeyState(expd2Leader))
	{
		l15_expd2Leader()
	}
	else if(expd2DownNoUp)
	{
		l15_expd2Modifier()
	}
	else if(GetKeyState(expd1Leader))
	{
		l15_expd1Leader()
	}
	else if(expd1DownNoUp)
	{
		l15_expd1Modifier()
	}
	else
	{
		FocusWindow("unlayered", "farRight")
	}
	return
	
; Custom behavior, want it consistent across layers
*Esc::
	if(vimMode)
	{
		l16_vim()
		return
	}
	if(Modifiers("l16", "{Esc}", "{Esc}"))
	{
		return
	}
	
	; Handle Shift+Esc separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{Esc}{%shiftLeaderUp%}
	}
	else if(shiftDownNoUp)
	{
		SendInput +{Esc}
	}
	; if no modifiers, proceed with default behavior, which is to
	; disable autospacing and enter Vim mod
	else
	{
		vimMode := true
		IniWrite, %vimMode%, Status.ini, statusVars, vimMode
		
		autoSpacingBeforeVim := !(GetKeyState(rawState))
		if(autoSpacingBeforeVim)
		{
			SendInput {%rawStateDn%}
		}
		
		if(VimWindowActive())
		{
			SendInput {Esc}
		}
		else
		{
			SendInput {Left}
		}
	}
	
	return

; Mirrored Esc key: not needed twice
;*Esc::
;	numModifier_keys := r11_numModifier()
;	shiftModifier_keys := r11_shiftModifier()
;	expd1Modifier_keys := r11_expd1Modifier()
;	expd2Modifier_keys := r11_expd2Modifier()
;	numLeader_keys := r11_numLeader(numModifier_keys)
;	shiftLeader_keys := r11_shiftLeader(shiftModifier_keys)
;	expd1Leader_keys := r11_expd1Leader(expd1Modifier_keys)
;	expd2Leader_keys := r11_expd2Leader(expd2Modifier_keys)
;	r11_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
;	return
*7::
	numModifier_keys := r12_numModifier()
	shiftModifier_keys := r12_shiftModifier()
	expd1Modifier_keys := r12_expd1Modifier()
	expd2Modifier_keys := r12_expd2Modifier()
	numLeader_keys := r12_numLeader(numModifier_keys)
	shiftLeader_keys := r12_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r12_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r12_expd2Leader(expd2Modifier_keys)
	r12_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return
*8::
	numModifier_keys := r13_numModifier()
	shiftModifier_keys := r13_shiftModifier()
	expd1Modifier_keys := r13_expd1Modifier()
	expd2Modifier_keys := r13_expd2Modifier()
	numLeader_keys := r13_numLeader(numModifier_keys)
	shiftLeader_keys := r13_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r13_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r13_expd2Leader(expd2Modifier_keys)
	r13_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return
*9::
	numModifier_keys := r14_numModifier()
	shiftModifier_keys := r14_shiftModifier()
	expd1Modifier_keys := r14_expd1Modifier()
	expd2Modifier_keys := r14_expd2Modifier()
	numLeader_keys := r14_numLeader(numModifier_keys)
	shiftLeader_keys := r14_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r14_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r14_expd2Leader(expd2Modifier_keys)
	r14_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return
*Right::
	numModifier_keys := r15_numModifier()
	shiftModifier_keys := r15_shiftModifier()
	expd1Modifier_keys := r15_expd1Modifier()
	expd2Modifier_keys := r15_expd2Modifier()
	numLeader_keys := r15_numLeader(numModifier_keys)
	shiftLeader_keys := r15_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r15_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r15_expd2Leader(expd2Modifier_keys)
	r15_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return
*`::
	numModifier_keys := r16_numModifier()
	shiftModifier_keys := r16_shiftModifier()
	expd1Modifier_keys := r16_expd1Modifier()
	expd2Modifier_keys := r16_expd2Modifier()
	numLeader_keys := r16_numLeader(numModifier_keys)
	shiftLeader_keys := r16_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r16_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r16_expd2Leader(expd2Modifier_keys)
	r16_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	return




; Top Row
;-------------------------------------------------

; Custom behavior, want it consistent across layers
*\::
	if(Modifiers("l21", "\", "\"))
	{
		return
	}
	
	; Handle Shift+\ separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +\{%shiftLeaderUp%}
		return
	}
	else if(shiftDownNoUp)
	{
		SendInput +\
		return
	}
	else
	{
		; Clear autospacing/autocapitalization when backslash escaping stuff
		SendInput {%regSpacingUp%}
		SendInput {%capSpacingUp%}
		dual.comboKey(["\", rawLeaderDn], {(rawState): "\", (rawLeader): ["\", rawLeaderUp]})
		return
	}
*b::
	if(vimMode)
	{
		l22_vim()
		return
	}
	if(Modifiers("l22", "b", "{"))
	{
		return
	}
	numModifier_keys := l22_numModifier()
	shiftModifier_keys := l22_shiftModifier()
	expd1Modifier_keys := l22_expd1Modifier()
	expd2Modifier_keys := l22_expd2Modifier()
	numLeader_keys := l22_numLeader(numModifier_keys)
	shiftLeader_keys := l22_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l22_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l22_expd2Leader(expd2Modifier_keys)
	l22_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["b", rawLeaderUp], (rawLeader): ["b", rawLeaderUp], (regSpacing): ["b", regSpacingUp], (capSpacing): ["B", capSpacingUp]})
	return
*y::
	if(vimMode)
	{
		l23_vim()
		return
	}
	if(Modifiers("l23", "y", "["))
	{
		return
	}
	numModifier_keys := l23_numModifier()
	shiftModifier_keys := l23_shiftModifier()
	expd1Modifier_keys := l23_expd1Modifier()
	expd2Modifier_keys := l23_expd2Modifier()
	numLeader_keys := l23_numLeader(numModifier_keys)
	shiftLeader_keys := l23_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l23_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l23_expd2Leader(expd2Modifier_keys)
	l23_afterNum()
	
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["y", rawLeaderUp], (rawLeader): ["y", rawLeaderUp], (regSpacing): ["y", regSpacingUp], (capSpacing): ["Y", capSpacingUp]})
	return
*o::
	if(vimMode)
	{
		l24_vim()
		return
	}
	if(Modifiers("l24", "o", "]"))
	{
		return
	}
	numModifier_keys := l24_numModifier()
	shiftModifier_keys := l24_shiftModifier()
	expd1Modifier_keys := l24_expd1Modifier()
	expd2Modifier_keys := l24_expd2Modifier()
	numLeader_keys := l24_numLeader(numModifier_keys)
	shiftLeader_keys := l24_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l24_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l24_expd2Leader(expd2Modifier_keys)
	l24_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["o", rawLeaderUp], (regSpacing): ["o", regSpacingUp], (capSpacing): ["O", capSpacingUp]})
	return
*u::
	if(vimMode)
	{
		l25_vim()
		return
	}
	if(Modifiers("l25", "u", "}"))
	{
		return
	}
	numModifier_keys := l25_numModifier()
	shiftModifier_keys := l25_shiftModifier()
	expd1Modifier_keys := l25_expd1Modifier()
	expd2Modifier_keys := l25_expd2Modifier()
	numLeader_keys := l25_numLeader(numModifier_keys)
	shiftLeader_keys := l25_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l25_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l25_expd2Leader(expd2Modifier_keys)
	l25_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["u", rawLeaderUp], (regSpacing): ["u", regSpacingUp], (capSpacing): ["U", capSpacingUp]})
	return
*'::
	if(vimMode)
	{
		l26_vim()
		return
	}
	if(Modifiers("l26", "'", "'"))
	{
		return
	}
	numModifier_keys := l26_numModifier()
	shiftModifier_keys := l26_shiftModifier()
	expd1Modifier_keys := l26_expd1Modifier()
	expd2Modifier_keys := l26_expd2Modifier()
	numLeader_keys := l26_numLeader(numModifier_keys)
	shiftLeader_keys := l26_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l26_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l26_expd2Leader(expd2Modifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (afterNum): afterNum_keys})
	return


*k::
	if(vimMode)
	{
		r21_vim()
		return
	}
	if(Modifiers("r21", "k", "%"))
	{
		return
	}
	numModifier_keys := r21_numModifier()
	shiftModifier_keys := r21_shiftModifier()
	expd1Modifier_keys := r21_expd1Modifier()
	expd2Modifier_keys := r21_expd2Modifier()
	numLeader_keys := r21_numLeader(numModifier_keys)
	shiftLeader_keys := r21_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r21_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r21_expd2Leader(expd2Modifier_keys)
	r21_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["k", rawLeaderUp], (regSpacing): ["k", regSpacingUp], (capSpacing): ["K", capSpacingUp]})
	return
*d::
	if(vimMode)
	{
		r22_vim()
		return
	}
	if(Modifiers("r22", "d", "/"))
	{
		return
	}
	numModifier_keys := r22_numModifier()
	shiftModifier_keys := r22_shiftModifier()
	expd1Modifier_keys := r22_expd1Modifier()
	expd2Modifier_keys := r22_expd2Modifier()
	numLeader_keys := r22_numLeader(numModifier_keys)
	shiftLeader_keys := r22_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r22_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r22_expd2Leader(expd2Modifier_keys)
	r22_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["d", rawLeaderUp], (regSpacing): ["d", regSpacingUp], (capSpacing): ["D", capSpacingUp]})
	return
*c::
	if(vimMode)
	{
		r23_vim()
		return
	}
	if(Modifiers("r23", "c", "-"))
	{
		return
	}
	numModifier_keys := r23_numModifier()
	shiftModifier_keys := r23_shiftModifier()
	expd1Modifier_keys := r23_expd1Modifier()
	expd2Modifier_keys := r23_expd2Modifier()
	numLeader_keys := r23_numLeader(numModifier_keys)
	shiftLeader_keys := r23_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r23_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r23_expd2Leader(expd2Modifier_keys)
	r23_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["c", rawLeaderUp], (regSpacing): ["c", regSpacingUp], (capSpacing): ["C", capSpacingUp]})
	return
*l::
	if(vimMode)
	{
		r24_vim()
		return
	}
	if(Modifiers("r24", "l", "*"))
	{
		return
	}
	numModifier_keys := r24_numModifier()
	shiftModifier_keys := r24_shiftModifier()
	expd1Modifier_keys := r24_expd1Modifier()
	expd2Modifier_keys := r24_expd2Modifier()
	numLeader_keys := r24_numLeader(numModifier_keys)
	shiftLeader_keys := r24_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r24_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r24_expd2Leader(expd2Modifier_keys)
	r24_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["l", rawLeaderUp], (regSpacing): ["l", regSpacingUp], (capSpacing): ["L", capSpacingUp]})
	return
*p::
	if(vimMode)
	{
		r25_vim()
		return
	}
	if(Modifiers("r25", "p", "+"))
	{
		return
	}
	numModifier_keys := r25_numModifier()
	shiftModifier_keys := r25_shiftModifier()
	expd1Modifier_keys := r25_expd1Modifier()
	expd2Modifier_keys := r25_expd2Modifier()
	numLeader_keys := r25_numLeader(numModifier_keys)
	shiftLeader_keys := r25_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r25_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r25_expd2Leader(expd2Modifier_keys)
	r25_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["p", rawLeaderUp], (regSpacing): ["p", regSpacingUp], (capSpacing): ["P", capSpacingUp]})
	return
*q::
	if(Modifiers("r26", "q", "^"))
	{
		return
	}
	numModifier_keys := r26_numModifier()
	shiftModifier_keys := r26_shiftModifier()
	expd1Modifier_keys := r26_expd1Modifier()
	expd2Modifier_keys := r26_expd2Modifier()
	numLeader_keys := r26_numLeader(numModifier_keys)
	shiftLeader_keys := r26_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r26_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r26_expd2Leader(expd2Modifier_keys)
	r26_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["q", rawLeaderUp], (regSpacing): ["q", regSpacingUp], (capSpacing): ["Q", capSpacingUp]})
	return




; Home Row
;-------------------------------------------------

; Custom behavior, want it consistent across layers
*Tab::
	if(Modifiers("l31", "{Tab}", "{Tab}"))
	{
		return
	}
	
	; Handle Shift+Tab separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{Tab}{%shiftLeaderUp%}
		return
	}
	else if(shiftDownNoUp)
	{
		SendInput +{Tab}
		return
	}
	else
	{
		dual.comboKey("Tab")
		return
	}
*h::
	if(vimMode)
	{
		l32_vim()
		return
	}
	if(Modifiers("l32", "h", "2"))
	{
		return
	}
	numModifier_keys := l32_numModifier()
	shiftModifier_keys := l32_shiftModifier()
	expd1Modifier_keys := l32_expd1Modifier()
	expd2Modifier_keys := l32_expd2Modifier()
	numLeader_keys := l32_numLeader(numModifier_keys)
	shiftLeader_keys := l32_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l32_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l32_expd2Leader(expd2Modifier_keys)
	l32_afterNum()
	
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["h", rawLeaderUp], (regSpacing): ["h", regSpacingUp], (capSpacing): ["H", capSpacingUp]})
	return
*i::
	if(vimMode)
	{
		l33_vim()
		return
	}
	if(Modifiers("l33", "i", "3"))
	{
		return
	}
	numModifier_keys := l33_numModifier()
	shiftModifier_keys := l33_shiftModifier()
	expd1Modifier_keys := l33_expd1Modifier()
	expd2Modifier_keys := l33_expd2Modifier()
	numLeader_keys := l33_numLeader(numModifier_keys)
	shiftLeader_keys := l33_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l33_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l33_expd2Leader(expd2Modifier_keys)
	l33_afterNum()
	
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["i", rawLeaderUp], (regSpacing): ["i", regSpacingUp], (capSpacing): ["I", capSpacingUp]})
	return
*e::
	if(vimMode)
	{
		l34_vim()
		return
	}
	if(Modifiers("l34", "e", "5"))
	{
		return
	}
	numModifier_keys := l34_numModifier()
	shiftModifier_keys := l34_shiftModifier()
	expd1Modifier_keys := l34_expd1Modifier()
	expd2Modifier_keys := l34_expd2Modifier()
	numLeader_keys := l34_numLeader(numModifier_keys)
	shiftLeader_keys := l34_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l34_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l34_expd2Leader(expd2Modifier_keys)
	l34_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["e", rawLeaderUp], (regSpacing): ["e", regSpacingUp], (capSpacing): ["E", capSpacingUp]})
	return
*a::
	if(vimMode)
	{
		l35_vim()
		return
	}
	if(Modifiers("l35", "a", "7"))
	{
		return
	}
	numModifier_keys := l35_numModifier()
	shiftModifier_keys := l35_shiftModifier()
	expd1Modifier_keys := l35_expd1Modifier()
	expd2Modifier_keys := l35_expd2Modifier()
	numLeader_keys := l35_numLeader(numModifier_keys)
	shiftLeader_keys := l35_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l35_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l35_expd2Leader(expd2Modifier_keys)
	l35_afterNum()
	
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["a", rawLeaderUp], (regSpacing): ["a", regSpacingUp], (capSpacing): ["A", capSpacingUp]})
	return
*.::
	if(vimMode)
	{
		l36_vim()
		return
	}
	if(Modifiers("l36", ".", "."))
	{
		return
	}
	if(GetKeyState(rawState) or TerminalActive())
	{
		defaultKeys := ["."]
		regSpacingKeys := ["."]
		capSpacingKeys := ["."]
	}
	else if(GetKeyState(rawLeader))
	{
		defaultKeys := ["Backspace", ".", rawLeaderUp]
		regSpacingKeys := ["Backspace", ".", rawLeaderUp]
		capSpacingKeys := ["Backspace", ".", rawLeaderUp]
	}
	else
	{
		defaultKeys := [".", "Space", capSpacingDn]
		regSpacingKeys := ["Backspace", ".", "Space", capSpacingDn, regSpacingUp]
		capSpacingKeys := ["Backspace", ".", "Space"]
	}

	numModifier_keys := l36_numModifier()
	shiftModifier_keys := l36_shiftModifier()
	expd1Modifier_keys := l36_expd1Modifier()
	expd2Modifier_keys := l36_expd2Modifier()
	numLeader_keys := l36_numLeader(numModifier_keys)
	shiftLeader_keys := l36_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l36_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l36_expd2Leader(expd2Modifier_keys)
	l36_afterNum()
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return


*m::
	if(vimMode)
	{
		r31_vim()
		return
	}
	if(Modifiers("r31", "m", "8"))
	{
		return
	}
	numModifier_keys := r31_numModifier()
	shiftModifier_keys := r31_shiftModifier()
	expd1Modifier_keys := r31_expd1Modifier()
	expd2Modifier_keys := r31_expd2Modifier()
	numLeader_keys := r31_numLeader(numModifier_keys)
	shiftLeader_keys := r31_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r31_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r31_expd2Leader(expd2Modifier_keys)
	r31_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["m", rawLeaderUp], (regSpacing): ["m", regSpacingUp], (capSpacing): ["M", capSpacingUp]})
	return
*t::
	if(vimMode)
	{
		r32_vim()
		return
	}
	if(Modifiers("r32", "t", "0"))
	{
		return
	}
	numModifier_keys := r32_numModifier()
	shiftModifier_keys := r32_shiftModifier()
	expd1Modifier_keys := r32_expd1Modifier()
	expd2Modifier_keys := r32_expd2Modifier()
	numLeader_keys := r32_numLeader(numModifier_keys)
	shiftLeader_keys := r32_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r32_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r32_expd2Leader(expd2Modifier_keys)
	r32_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["t", rawLeaderUp], (regSpacing): ["t", regSpacingUp], (capSpacing): ["T", capSpacingUp]})
	return
*s::
	if(vimMode)
	{
		r33_vim()
		return
	}
	if(Modifiers("r33", "s", "6"))
	{
		return
	}
	numModifier_keys := r33_numModifier()
	shiftModifier_keys := r33_shiftModifier()
	expd1Modifier_keys := r33_expd1Modifier()
	expd2Modifier_keys := r33_expd2Modifier()
	numLeader_keys := r33_numLeader(numModifier_keys)
	shiftLeader_keys := r33_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r33_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r33_expd2Leader(expd2Modifier_keys)
	r33_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["s", rawLeaderUp], (regSpacing): ["s", regSpacingUp], (capSpacing): ["S", capSpacingUp]})
	return
*r::
	if(vimMode)
	{
		r34_vim()
		return
	}
	if(Modifiers("r34", "r", "4"))
	{
		return
	}
	numModifier_keys := r34_numModifier()
	shiftModifier_keys := r34_shiftModifier()
	expd1Modifier_keys := r34_expd1Modifier()
	expd2Modifier_keys := r34_expd2Modifier()
	numLeader_keys := r34_numLeader(numModifier_keys)
	shiftLeader_keys := r34_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r34_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r34_expd2Leader(expd2Modifier_keys)
	r34_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["r", rawLeaderUp], (regSpacing): ["r", regSpacingUp], (capSpacing): ["R", capSpacingUp]})
	return
*n::
	if(vimMode)
	{
		r35_vim()
		return
	}
	if(Modifiers("r35", "n", "1"))
	{
		return
	}
	numModifier_keys := r35_numModifier()
	shiftModifier_keys := r35_shiftModifier()
	expd1Modifier_keys := r35_expd1Modifier()
	expd2Modifier_keys := r35_expd2Modifier()
	numLeader_keys := r35_numLeader(numModifier_keys)
	shiftLeader_keys := r35_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r35_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r35_expd2Leader(expd2Modifier_keys)
	r35_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["n", rawLeaderUp], (regSpacing): ["n", regSpacingUp], (capSpacing): ["N", capSpacingUp]})
	return
*v::
	if(Modifiers("r36", "v", "|"))
	{
		return
	}
	numModifier_keys := r36_numModifier()
	shiftModifier_keys := r36_shiftModifier()
	expd1Modifier_keys := r36_expd1Modifier()
	expd2Modifier_keys := r36_expd2Modifier()
	numLeader_keys := r36_numLeader(numModifier_keys)
	shiftLeader_keys := r36_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r36_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r36_expd2Leader(expd2Modifier_keys)
	r36_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["v", rawLeaderUp], (regSpacing): ["v", regSpacingUp], (capSpacing): ["V", capSpacingUp]})
	return
	



; Bottom Row
;-------------------------------------------------

; Custom behavior, want it consistent across layers
*Enter::
	if(Modifiers("l41", "{Enter}", "{Enter}"))
	{
		return
	}
	
	; Handle Shift+Enter separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{Enter}{%shiftLeaderUp%}
		return
	}
	else if(shiftDownNoUp)
	{
		SendInput +{Enter}
		return
	}
	else
	{
		; By default, Enter gets rid of trailing spaces from autospacing, and capitalizes the next letter.
		; Repeated Enter presses get around the default capSpacing behavior by using A_PriorHotkey.
		; Backslash escaping is supported if one wishes to send an Enter without autospacing behavior
		; of any form.
		lastKey := A_PriorHotkey
		if(lastKey = "*Enter")
		{
			capSpacingKeys := "Enter"
			regSpacingKeys := "Enter"
		}
		else
		{
			regSpacingKeys := ["Backspace", "Enter", capSpacingDn, regSpacingUp]
			capSpacingKeys := ["Backspace", "Enter"]
		}
		
		; Don't capitalize the next letter in terminals
		if(TerminalActive())
		{
			defaultKeys := "Enter"
		}
		else
		{
			defaultKeys := ["Enter", capSpacingDn]
		}
		
		dual.comboKey(defaultKeys, {(rawLeader): ["Backspace", "Enter"], (rawState): "Enter", (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
		return
	}

*x::
	if(vimMode)
	{
		l42_vim()
		return
	}
	if(Modifiers("l42", "x", "$"))
	{
		return
	}
	numModifier_keys := l42_numModifier()
	shiftModifier_keys := l42_shiftModifier()
	expd1Modifier_keys := l42_expd1Modifier()
	expd2Modifier_keys := l42_expd2Modifier()
	numLeader_keys := l42_numLeader(numModifier_keys)
	shiftLeader_keys := l42_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l42_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l42_expd2Leader(expd2Modifier_keys)
	l42_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["x", rawLeaderUp], (regSpacing): ["x", regSpacingUp], (capSpacing): ["X", capSpacingUp]})
	return
*/::
	if(vimMode)
	{
		l43_vim()
		return
	}
	if(Modifiers("l43", """", """"))
	{
		return
	}
	if(GetKeyState(rawState))
	{
		defaultKeys := [""""]
		regSpacingKeys := [""""]
		capSpacingKeys := [""""]
	}
	else if(GetKeyState(rawLeader))
	{
		defaultKeys := ["Backspace", """", rawLeaderUp]
		regSpacingKeys := ["Backspace", """", rawLeaderUp]
		capSpacingKeys := ["Backspace", """", rawLeaderUp]
	}
	else
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel + 1
		
		actuallyNeedToWrite := !(GetKeyState(shiftLeader) or shiftDownNoUp or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or numDownNoUp)))
			
		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			lastOpenPairDown := A_TickCount
			IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
			
			IniRead, closingChars, Status.ini, nestVars, closingChars
			closingChars := AddClosingCharToStack("""", closingChars)
			IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		}
		
		IniRead, nestingType, Status.ini, nestVars, nestingType
	
		if(nestingType = "paired")
		{
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
		
		else  ; nestingType = "unpaired"
		{
			if(GetKeyState(nestedPunctuation))
			{
				defaultKeys := ["Space", """", regSpacingDn]
				regSpacingKeys := [""""]
				capSpacingKeys := [""""]
			}
			else
			{
				defaultKeys := ["Space", """", regSpacingDn, nestedPunctuationDn]
				regSpacingKeys := ["""", nestedPunctuationDn]
				capSpacingKeys := ["""", nestedPunctuationDn]
			}
		}
	}
	
	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l43_shiftModifier()
	expd1Modifier_keys := l43_expd1Modifier()
	expd2Modifier_keys := l43_expd2Modifier()
	numLeader_keys := l43_numLeader(numModifier_keys)
	shiftLeader_keys := l43_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l43_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l43_expd2Leader(expd2Modifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	; For correct capitalization of expansions following afterNum ?
	if(GetKeyState(afterNum) and !(GetKeyState(numLeader)))
	{
		capBecauseOfAfterNumPunc := true
		IniWrite, %capBecauseOfAfterNumPunc%, Status.ini, statusVars, capBecauseOfAfterNumPunc
	}
	else
	{
		capBecauseOfAfterNumPunc := false
		IniWrite, %capBecauseOfAfterNumPunc%, Status.ini, statusVars, capBecauseOfAfterNumPunc
	}
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*;::
	if(vimMode)
	{
		l44_vim()
		return
	}
	if(Modifiers("l44", ")", ")"))
	{
		return
	}
	if(GetKeyState(rawState))
	{
		if(IDEWindowActive() and !vimMode)
		{
			defaultKeys := ["Right"]
			regSpacingKeys := ["Right"]
			capSpacingKeys := ["Right"]
		}
		else
		{
			defaultKeys := [")"]
			regSpacingKeys := [")"]
			capSpacingKeys := [")"]
		}
	}
	else if(GetKeyState(rawLeader))
	{
		defaultKeys := ["Backspace", ")", rawLeaderUp]
		regSpacingKeys := ["Backspace", ")", rawLeaderUp]
		capSpacingKeys := ["Backspace", ")", rawLeaderUp]
	}
	else if(GetKeyState(nestedPunctuation))
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel - 1
		
		actuallyNeedToWrite := !(GetKeyState(shiftLeader) or shiftDownNoUp or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or numDownNoUp)))
		
		IniRead, closingChars, Status.ini, nestVars, closingChars
		closingChar := GetClosingCharFromStack(closingChars)
		
		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			
			; Only remove closing char from the stack if we actually need to
			; write. Otherwise, just use the read value to get the closing
			; character
			closingChars := RemoveClosingCharFromStack(closingChars)
			IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		}
		
		defaultKeys := ExitNestedPair("default", nestLevel, closingChar)
		regSpacingKeys := ExitNestedPair("regSpacing", nestLevel, closingChar)
		capSpacingKeys := ExitNestedPair("capSpacing", nestLevel, closingChar)
	}
	else
	{
		defaultKeys := [")"]
		regSpacingKeys := [")"]
		capSpacingKeys := [")"]
	}

	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l44_shiftModifier()
	expd1Modifier_keys := l44_expd1Modifier()
	expd2Modifier_keys := l44_expd2Modifier()
	numLeader_keys := l44_numLeader(numModifier_keys)
	shiftLeader_keys := l44_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l44_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l44_expd2Leader(expd2Modifier_keys)
	afterNum_keys := AddKeyUp(shiftModifier_keys.Clone(), afterNumUp)
	
	; For correct capitalization of expansions following afterNum !
	if(GetKeyState(afterNum) and !(GetKeyState(numLeader)))
	{
		capBecauseOfAfterNumPunc := true
		IniWrite, %capBecauseOfAfterNumPunc%, Status.ini, statusVars, capBecauseOfAfterNumPunc
	}
	else
	{
		capBecauseOfAfterNumPunc := false
		IniWrite, %capBecauseOfAfterNumPunc%, Status.ini, statusVars, capBecauseOfAfterNumPunc
	}
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*,::
	if(vimMode)
	{
		l45_vim()
		return
	}
	if(Modifiers("l45", ",", ","))
	{
		return
	}
	if(GetKeyState(rawState))
	{
		defaultKeys := [","]
		regSpacingKeys := [","]
		capSpacingKeys := [","]
	}
	else if(GetKeyState(rawLeader))
	{
		defaultKeys := ["Backspace", ",", rawLeaderUp]
		regSpacingKeys := ["Backspace", ",", rawLeaderUp]
		capSpacingKeys := ["Backspace", ",", rawLeaderUp]
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
	expd1Modifier_keys := l45_expd1Modifier()
	expd2Modifier_keys := l45_expd2Modifier()
	numLeader_keys := l45_numLeader(numModifier_keys)
	; No modifier keys defined above = no arguments
	shiftLeader_keys := l45_shiftLeader()
	expd1Leader_keys := l45_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l45_expd2Leader(expd2Modifier_keys)
	; Want em dash behavior. Redefine separately to avoid sending an extra shiftLeaderUp
	afterNum_keys := l45_afterNum()
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (afterNum): afterNum_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
*-::
	if(vimMode)
	{
		l46_vim()
		return
	}
	if(Modifiers("l46", "(", "("))
	{
		return
	}
	if(GetKeyState(rawState))
	{
		defaultKeys := ["("]
		regSpacingKeys := ["("]
		capSpacingKeys := ["("]
	}
	else if(GetKeyState(rawLeader))
	{
		defaultKeys := ["Backspace", "(", rawLeaderUp]
		regSpacingKeys := ["Backspace", "(", rawLeaderUp]
		capSpacingKeys := ["Backspace", "(", rawLeaderUp]
	}
	else
	{
		IniRead, nestLevel, Status.ini, nestVars, nestLevel
		nestLevel := nestLevel + 1
		
		actuallyNeedToWrite := !(GetKeyState(shiftLeader) or shiftDownNoUp or (GetKeyState(afterNum) and !(GetKeyState(numLeader) or numDownNoUp)))
			
		if(actuallyNeedToWrite)
		{
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			lastOpenPairDown := A_TickCount
			IniWrite, %lastOpenPairDown%, Status.ini, nestVars, lastOpenPairDown
			
			IniRead, closingChars, Status.ini, nestVars, closingChars
			closingChars := AddClosingCharToStack(")", closingChars)
			IniWrite, %closingChars%, Status.ini, nestVars, closingChars
		}
		
		IniRead, nestingType, Status.ini, nestVars, nestingType
		
		if(nestingType = "paired")
		{	
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
		
		else  ; nestingType = "unpaired"
		{	
			if(GetKeyState(nestedPunctuation))
			{
				defaultKeys := ["Space", "(", regSpacingDn]
				regSpacingKeys := ["("]
				capSpacingKeys := ["("]
			}
			else
			{
				defaultKeys := ["Space", "(", regSpacingDn, nestedPunctuationDn]
				regSpacingKeys := ["(", nestedPunctuationDn]
				capSpacingKeys := ["(", nestedPunctuationDn]
			}
		}
	}

	numModifier_keys := numModifierKeys_PuncCombinator(defaultKeys, regSpacingKeys, capSpacingKeys)
	shiftModifier_keys := l46_shiftModifier()
	expd1Modifier_keys := l46_expd1Modifier()
	expd2Modifier_keys := l46_expd2Modifier()
	numLeader_keys := l46_numLeader(numModifier_keys)
	shiftLeader_keys := l46_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := l46_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := l46_expd2Leader(expd2Modifier_keys)
	
	dual.comboKey(defaultKeys, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return


*w::
	if(vimMode)
	{
		r41_vim()
		return
	}
	if(Modifiers("r41", "w", "9"))
	{
		return
	}
	numModifier_keys := r41_numModifier()
	shiftModifier_keys := r41_shiftModifier()
	expd1Modifier_keys := r41_expd1Modifier()
	expd2Modifier_keys := r41_expd2Modifier()
	numLeader_keys := r41_numLeader(numModifier_keys)
	shiftLeader_keys := r41_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r41_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r41_expd2Leader(expd2Modifier_keys)
	r41_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["w", rawLeaderUp], (regSpacing): ["w", regSpacingUp], (capSpacing): ["W", capSpacingUp]})
	return
*g::
	if(vimMode)
	{
		r42_vim()
		return
	}
	if(Modifiers("r42", "g", "="))
	{
		return
	}
	numModifier_keys := r42_numModifier()
	shiftModifier_keys := r42_shiftModifier()
	expd1Modifier_keys := r42_expd1Modifier()
	expd2Modifier_keys := r42_expd2Modifier()
	numLeader_keys := r42_numLeader(numModifier_keys)
	shiftLeader_keys := r42_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r42_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r42_expd2Leader(expd2Modifier_keys)
	r42_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["g", rawLeaderUp], (regSpacing): ["g", regSpacingUp], (capSpacing): ["G", capSpacingUp]})
	return
*f::
	if(vimMode)
	{
		r43_vim()
		return
	}
	if(Modifiers("r43", "f", "<"))
	{
		return
	}
	numModifier_keys := r43_numModifier()
	shiftModifier_keys := r43_shiftModifier()
	expd1Modifier_keys := r43_expd1Modifier()
	expd2Modifier_keys := r43_expd2Modifier()
	numLeader_keys := r43_numLeader(numModifier_keys)
	shiftLeader_keys := r43_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r43_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r43_expd2Leader(expd2Modifier_keys)
	r43_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["f", rawLeaderUp], (regSpacing): ["f", regSpacingUp], (capSpacing): ["F", capSpacingUp]})
	return
*j::
	if(vimMode)
	{
		r44_vim()
		return
	}
	if(Modifiers("r44", "j", ">"))
	{
		return
	}
	numModifier_keys := r44_numModifier()
	shiftModifier_keys := r44_shiftModifier()
	expd1Modifier_keys := r44_expd1Modifier()
	expd2Modifier_keys := r44_expd2Modifier()
	numLeader_keys := r44_numLeader(numModifier_keys)
	shiftLeader_keys := r44_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r44_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r44_expd2Leader(expd2Modifier_keys)
	r44_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["j", rawLeaderUp], (regSpacing): ["j", regSpacingUp], (capSpacing): ["J", capSpacingUp]})
	return
*z::
	if(vimMode)
	{
		r45_vim()
		return
	}
	if(Modifiers("r45", "z", "&"))
	{
		return
	}
	numModifier_keys := r45_numModifier()
	shiftModifier_keys := r45_shiftModifier()
	expd1Modifier_keys := r45_expd1Modifier()
	expd2Modifier_keys := r45_expd2Modifier()
	numLeader_keys := r45_numLeader(numModifier_keys)
	shiftLeader_keys := r45_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := r45_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := r45_expd2Leader(expd2Modifier_keys)
	r45_afterNum()
	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (rawLeader): ["z", rawLeaderUp], (regSpacing): ["z", regSpacingUp], (capSpacing): ["Z", capSpacingUp]})
	return
; Mirrored Enter key: not needed twice	
;*Enter::
;	numModifier_keys := r46_numModifier()
;	shiftModifier_keys := r46_shiftModifier()
;	expd1Modifier_keys := r46_expd1Modifier()
;	expd2Modifier_keys := r46_expd2Modifier()
;	numLeader_keys := r46_numLeader(numModifier_keys)
;	shiftLeader_keys := r46_shiftLeader(shiftModifier_keys)
;	expd1Leader_keys := r46_expd1Leader(expd1Modifier_keys)
;	expd2Leader_keys := r46_expd2Leader(expd2Modifier_keys)
;	r46_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
;	return




; Extra Row
;-------------------------------------------------

; Custom behavior, want it consistent across layers
*[::
	dual.comboKey()
	return
; Custom behavior, want it consistent across layers
*RWin::
	dual.combine([], winLeaderDn, settings = false, {(winLeader): winLeaderUp})
	winDownNoUp := true
	return
*RWin Up::
	dual.combine([], winLeaderDn, settings = false, {(winLeader): winLeaderUp})
	winDownNoUp := false
	return
; Custom behavior, want it consistent across layers
*LAlt::
	dual.combine([], altLeaderDn, settings = false, {(altLeader): altLeaderUp})
	altDownNoUp := true
	return
*LAlt Up::
	dual.combine([], altLeaderDn, settings = false, {(altLeader): altLeaderUp})
	altDownNoUp := false
	return
; Custom behavior, want it consistent across layers
*LCtrl::
	dual.combine([], ctrlLeaderDn, settings = false, {(ctrlLeader): ctrlLeaderUp})
	ctrlDownNoUp := true
	return
*LCtrl Up::
	dual.combine([], ctrlLeaderDn, settings = false, {(ctrlLeader): ctrlLeaderUp})
	ctrlDownNoUp := false
	return

; Mirrored Ctrl key: not needed twice	
;*LCtrl::
;	numModifier_keys := r52_numModifier()
;	shiftModifier_keys := r52_shiftModifier()
;	expd1Modifier_keys := r52_expd1Modifier()
;	expd2Modifier_keys := r52_expd2Modifier()
;	numLeader_keys := r52_numLeader(numModifier_keys)
;	shiftLeader_keys := r52_shiftLeader(shiftModifier_keys)
;	expd1Leader_keys := r52_expd1Leader(expd1Modifier_keys)
;	expd2Leader_keys := r52_expd2Leader(expd2Modifier_keys)
;	r52_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
;	return
; Mirrored Alt key: not needed twice
;*LAlt::
;	numModifier_keys := r53_numModifier()
;	shiftModifier_keys := r53_shiftModifier()
;	expd1Modifier_keys := r53_expd1Modifier()
;	expd2Modifier_keys := r53_expd2Modifier()
;	numLeader_keys := r53_numLeader(numModifier_keys)
;	shiftLeader_keys := r53_shiftLeader(shiftModifier_keys)
;	expd1Leader_keys := r53_expd1Leader(expd1Modifier_keys)
;	expd2Leader_keys := r53_expd2Leader(expd2Modifier_keys)
;	r53_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
;	return
; Mirrored Win key: not needed twice
;*RWin::
;	numModifier_keys := r54_numModifier()
;	shiftModifier_keys := r54_shiftModifier()
;	expd1Modifier_keys := r54_expd1Modifier()
;	expd2Modifier_keys := r54_expd2Modifier()
;	numLeader_keys := r54_numLeader(numModifier_keys)
;	shiftLeader_keys := r54_shiftLeader(shiftModifier_keys)
;	expd1Leader_keys := r54_expd1Leader(expd1Modifier_keys)
;	expd2Leader_keys := r54_expd2Leader(expd2Modifier_keys)
;	r54_afterNum()
;	dual.comboKey({(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
;	return
; Custom behavior, want it consistent across layers
*]::
	nestLevel := 0
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	subscript_PassThroughCap := false
	IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap

	superscript_PassThroughCap := false
	IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap

	dual.reset()
	return




; Thumbs
;-------------------------------------------------

lastSpaceDown := 0
vimModifier := false
justExitedVimMode := false

; We want the number layer to function normally on the shift layers so that we can mix numbers/symbols with words with all caps.
; This is why these combinators have been removed.
*Space::
	
	currSpaceDown := A_TickCount

	if(vimMode)
	{
		lt1_vim()
		return
	}
	if(Modifiers("lt1", "{Space}", "{Space}"))
	{
		return
	}
	
	lastKey := A_PriorHotkey
	
	; Tap and hold for temporary Vim access. This is extremely efficient:
	; double tapping space is faster than pressing the Vim key then holding
	; down space.
	if(lastKey == "*Space Up" and ((currSpaceDown - lastSpaceDown) < 300))
	{
		lastSpaceDown := A_TickCount
	
		if(justExitedVimMode)
		{
			justExitedVimMode := false
		}
		else
		{
			vimModifier := true
			vimMode := true
			IniWrite, %vimMode%, Status.ini, statusVars, vimMode
			
			autoSpacingBeforeVim := !(GetKeyState(rawState))
			if(autoSpacingBeforeVim)
			{
				SendInput {%rawStateDn%}
			}
			
			SendInput {Backspace}{Left}{Esc}
			
			KeyWait Space
			
			return
		}
	}
	else
	{
		lastSpaceDown := A_TickCount
		justExitedVimMode := false
	}
	
	
	; Spacing is disabled by default after autospaced punctuation to help prevent typos,
	; and to allow for proper spacing in nested punctuation expansions. However, we want
	; to enable spaces after Enters.
	if(lastKey = "*Enter")
	{
		capSpacingKeys := "Space"
		regSpacingKeys := ""
	}
	else
	{
		capSpacingKeys := ""
		regSpacingKeys := ""
	}
	
	numModifier_keys := lt1_numModifier()
	shiftModifier_keys := lt1_shiftModifier()
	expd1Modifier_keys := lt1_expd1Modifier()
	expd2Modifier_keys := lt1_expd2Modifier()
	numLeader_keys := lt1_numLeader(numModifier_keys)
	shiftLeader_keys := lt1_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := lt1_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := lt1_expd2Leader(expd2Modifier_keys)
	lt1_afterNum()
	dual.comboKey(["Space", regSpacingDn], {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys, (regSpacing): regSpacingKeys, (capSpacing): capSpacingKeys})
	return
	
*Space Up::
	if(vimModifier) {
		vimModifier := false
		ExitVimMode()
		BasicVimKey("a", "{Right}")
		justExitedVimMode := true
		return
	}
	
	return
	
; We want the number layer to function normally on the shift layers so that we can mix numbers/symbols with words with all caps.
; This is why these combinators have been removed.
*3::
	if(vimMode)
	{
		lt2_vim()
		return
	}
	lastKey := A_PriorHotkey
	if(lastKey != "*3" and lastKey != "*3 Up")
	{
		lastRealKeyDown := Dual.cleanKey(lastKey)
	}
	numModifier_keys := numModifierUp
	expd1Modifier_keys := lt2_expd1Modifier()
	expd2Modifier_keys := lt2_expd2Modifier()
	numLeader_keys := numModifierDn
	expd1Leader_keys := lt2_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := lt2_expd2Leader(expd2Modifier_keys)
	lt2_afterNum()
	dual.combine(numModifier, numLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	numDownNoUp := true
	
	return
*3 Up::
	if(vimMode)
	{
		lt2_vim()
		return
	}
	numModifier_keys := numModifierUp
	expd1Modifier_keys := lt2_expd1Modifier()
	expd2Modifier_keys := lt2_expd2Modifier()
	numLeader_keys := numModifierDn
	expd1Leader_keys := lt2_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := lt2_expd2Leader(expd2Modifier_keys)
	lt2_afterNum()
	dual.combine(numModifier, numLeaderDn, settings = false, {(numLeader): numLeader_keys, (numModifier): numModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	; Activate afterNum layer on key-up to be able to type all punctuation after numbers
	SendInput {%afterNumDn%}
	
	numDownNoUp := false
	
	return
	
	
*0::
	shiftModifier_keys := lt3_shiftModifier()
	expd2Modifier_keys := lt3_expd2Modifier()
	shiftLeader_keys := lt3_shiftLeader(shiftModifier_keys)
	expd2Leader_keys := lt3_expd2Leader(expd2Modifier_keys)
	lt3_afterNum()
	dual.combine(expd1Modifier, expd1LeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	expd1DownNoUp := true
	
	return
*0 Up::
	shiftModifier_keys := lt3_shiftModifier()
	expd2Modifier_keys := lt3_expd2Modifier()
	shiftLeader_keys := lt3_shiftLeader(shiftModifier_keys)
	expd2Leader_keys := lt3_expd2Leader(expd2Modifier_keys)
	lt3_afterNum()
	dual.combine(expd1Modifier, expd1LeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	expd1DownNoUp := false
	
	return


	
	
	
	

; Custom behavior, want it consistent across layers
*Backspace::
	if(Modifiers("rt1", "{Backspace}", "{Backspace}"))
	{
		return
	}
	
	; Handle Shift+Backspace separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{Backspace}{%shiftLeaderUp%}
		return
	}
	else if(shiftDownNoUp)
	{
		SendInput +{Backspace}
		return
	}
	else
	{
		IniRead, lastOpenPairDown, Status.ini, nestVars, lastOpenPairDown
		timeOfLastHotkey := A_TickCount - A_TimeSincePriorHotkey
		
		if((timeOfLastHotKey - lastOpenPairDown) < 50)
		{
			IniRead, nestLevel, Status.ini, nestVars, nestLevel
			nestLevel := nestLevel - 1
			IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel
			
			if(nestLevel > 0)
			{
				SendInput {Backspace}{Delete}
			}
			else
			{
				SendInput {Backspace}{Delete}{%nestedPunctuationUp%}
			}
		
			return
		}

		dual.comboKey({(regSpacing): ["Backspace", "Backspace", regSpacingUp], (capSpacing): ["Backspace", "Backspace", capSpacingUp]})
		return
	}

colonKeys := false
*2::

	lastKey := A_PriorHotkey
	if(numDownNoUp)
	{
		colonKeys := true
		numModifier_keys := rt2_numModifier()
		dual.comboKey({(numModifier): numModifier_keys})
		return
	}
	else if((lastKey = "*3") or (lastKey = "*3 Up")) {
		colonKeys := true
		numModifier_keys := rt2_numModifier()
		numLeader_keys := rt2_numLeader(numModifier_keys)
		dual.comboKey({(numLeader): numLeader_keys})
		return
	}
	else {
		colonKeys := false
	}
	
	shiftModifier_keys := shiftModifierUp
	expd1Modifier_keys := rt2_expd1Modifier()
	expd2Modifier_keys := rt2_expd2Modifier()
	shiftLeader_keys := shiftModifierDn
	expd1Leader_keys := rt2_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := rt2_expd2Leader(expd2Modifier_keys)
	rt2_afterNum()
	dual.combine(shiftModifier, shiftLeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	shiftDownNoUp := true
	
	return

*2 Up::

	if(colonKeys)
	{
		return
	}

	shiftModifier_keys := shiftModifierUp
	expd1Modifier_keys := rt2_expd1Modifier()
	expd2Modifier_keys := rt2_expd2Modifier()
	shiftLeader_keys := shiftModifierDn
	expd1Leader_keys := rt2_expd1Leader(expd1Modifier_keys)
	expd2Leader_keys := rt2_expd2Leader(expd2Modifier_keys)
	rt2_afterNum()
	dual.combine(shiftModifier, shiftLeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys, (expd2Leader): expd2Leader_keys, (expd2Modifier): expd2Modifier_keys})
	
	shiftDownNoUp := false
	
	return

semicolonKeys := ""
*1::

	lastKey := A_PriorHotkey
	if(numDownNoUp)
	{
		semicolonKeys := true
		numModifier_keys := rt3_numModifier()
		dual.comboKey({(numModifier): numModifier_keys})
		return
	}
	else if((lastKey = "*3") or (lastKey = "*3 Up")) {
		semicolonKeys := true
		numModifier_keys := rt3_numModifier()
		numLeader_keys := rt3_numLeader(numModifier_keys)
		dual.comboKey({(numLeader): numLeader_keys})
		return
	}
	else {
		semicolonKeys := false
	}

	shiftModifier_keys := rt3_shiftModifier()
	expd1Modifier_keys := rt3_expd1Modifier()
	shiftLeader_keys := rt3_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := rt3_expd1Leader(expd1Modifier_keys)
	rt3_afterNum()
	dual.combine(expd2Modifier, expd2LeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys})
	
	expd2DownNoUp := true
	
	return
*1 Up::

	if(semicolonKeys)
	{
		return
	}

	shiftModifier_keys := rt3_shiftModifier()
	expd1Modifier_keys := rt3_expd1Modifier()
	shiftLeader_keys := rt3_shiftLeader(shiftModifier_keys)
	expd1Leader_keys := rt3_expd1Leader(expd1Modifier_keys)
	rt3_afterNum()
	dual.combine(expd2Modifier, expd2LeaderDn, settings = false, {(shiftLeader): shiftLeader_keys, (shiftModifier): shiftModifier_keys, (expd1Leader): expd1Leader_keys, (expd1Modifier): expd1Modifier_keys})
	
	expd2DownNoUp := false
	
	return



; Mouse
;-------------------------------------------------

LButtonDownTime := 0
LButtonUpTime := 0

LButtonDownX := 0
LButtonDownY := 0
LButtonUpX := 0
LButtonUpY := 0

*LButton::

	LButtonDownTime := A_TickCount
	MouseGetPos, LButtonDownX, LButtonDownY

	if(Modifiers("lmb", "{LButton Down}", "{LButton Down}"))
	{
		return
	}
	
	; Handle Shift+LButton separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{LButton Down}{%shiftLeaderUp%}
	}
	else if(shiftDownNoUp)
	{
		SendInput +{LButton Down}
	}
	else
	{
		SendInput {LButton Down}
	}
	return
*LButton Up::

	LButtonUpTime := A_TickCount
	MouseGetPos, LButtonUpX, LButtonUpY
	
	; Activate visual mode upon mouse selection of text
	if( ((LButtonUpTime - LButtonDownTime) > 200) and !(NeedToDragNonText()) )
	{
		; Activate Vim mode if it is not already activated
		if(!vimMode)
		{
			vimMode := true
			IniWrite, %vimMode%, Status.ini, statusVars, vimMode
			
			autoSpacingBeforeVim := !(GetKeyState(rawState))
			if(autoSpacingBeforeVim)
			{
				SendInput {%rawStateDn%}
			}
		}
		
		; Activate visual mode (basic visual mode, not linewise or 
		; blockwise)
		visualMode := "visual"
		IniWrite, %visualMode%, Status.ini, statusVars, visualMode
		
		; We will already have something selected, so don't want the initial
		; behavior if we decide to select more with the keyboard
		initialVisualPress := false
		
		; Get visual direction based off of differential in
		; mouse position
		visualDirection := ""
		
		difX := LButtonUpX - LButtonDownX
		difY := LButtonUpY - LButtonDownY
		
		; If probably on same line = difference in Y height is less than 12 pixels.
		; (A somewhat arbitrary value: lines with big fonts and more spacing will 
		; work with this quite comfortably, while smaller fonts with tight spacing
		; may be somewhat of a toss-up. Trying to select straight through the middle
		; of lines helps).
		if(Abs(difY) < 12)
		{
			; A positive difference means the up value is more to the right than 
			; the down value, since (0, 0) is the top left corner.
			if(difX >= 0)
			{
				visualDirection := "after"
			}
			else
			{
				visualDirection := "before"
			}
		}
		
		; If we have selected up or down a line = difference in Y height is greater than 
		; or equal to 12 pixels
		else
		{
			; A positive difference means the up value is more downwards than
			; the down value, since (0, 0) is the top left corner.
			if(difY >= 0)
			{
				visualDirection := "after"
			}
			else
			{
				visualDirection := "before"
			}
		}
		
		BasicVimKey("v", "")
	}
	
	SendInput {%regSpacingUp%}{%capSpacingUp%}{LButton Up}
	return
	
	
*RButton::

	if(Modifiers("rmb", "{RButton Down}", "{RButton Down}"))
	{
		return
	}
	
	; Handle Shift+RButton separate from Dual
	if(GetKeyState(shiftLeader))
	{
		SendInput +{RButton Down}{%shiftLeaderUp%}
	}
	else if(shiftDownNoUp)
	{
		SendInput +{RButton Down}
	}
	else
	{
		SendInput {RButton Down}
	}
	return
*RButton Up::
	SendInput {%regSpacingUp%}{%capSpacingUp%}{RButton Up}
	return