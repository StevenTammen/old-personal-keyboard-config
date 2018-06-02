SendMode Input
#NoEnv
#SingleInstance force



; Import Functions
;-------------------------------------------------

#Include <functions>



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07



; Initialize Objects And Status Variables
;-------------------------------------------------

; Enable passing through capitalization for subscripts as a block (rather than capitalizing the first letter of the subscript).
; Stored in Status.ini to allow for resetting with Esc.
global subscript_PassThroughCap := false
IniWrite, %subscript_PassThroughCap%, Status.ini, nestVars, subscript_PassThroughCap 

; Enable passing through capitalization for superscripts as a block (rather than capitalizing the first letter of the superscript).
; Stored in Status.ini to allow for resetting with Esc.
global superscript_PassThroughCap := false
IniWrite, %superscript_PassThroughCap%, Status.ini, nestVars, superscript_PassThroughCap 



; Initialize Layer Keys
;-------------------------------------------------

; High to Low Priority: expd keys need to come first so that we can use the shift/num leaders for expansions.
; Num keys come before shift keys so that you can use the number layer when shift is locked down (double tapped)

; To use these as keys in associative arrays, you have to enclose them in parentheses. 
; For example: ~{(expdLeader): expdLeader_keys}~

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

; Explicit down and up variables are defined for ease of use: using expression syntax and straight key definitions,
; you would need concatenation like ~keyVar . " Down"~ and ~keyVar . " Up"~, which is a bit verbose.
; I have found AHK's expression/%traditional syntax% quite bug-prone, so have opted to do it this way.

global expdLeaderDn := "VK88 Down"
global expdModifierDn := "VK89 Down"
global numLeaderDn := "VK8A Down"
global numModifierDn := "VK8B Down"
global shiftLeaderDn := "VK8C Down"
global shiftModifierDn := "VK8D Down"
global afterNumDn := "VK8E Down"
global rawLeaderDn := "VK8F Down"
global rawStateDn := "VK97 Down"
global regSpacingDn := "VK98 Down"
global capSpacingDn := "VK99 Down"
global nestedPunctuationDn := "VKD8 Down"

global expdLeaderUp := "VK88 Up"
global expdModifierUp := "VK89 Up"
global numLeaderUp := "VK8A Up"
global numModifierUp := "VK8B Up"
global shiftLeaderUp := "VK8C Up"
global shiftModifierUp := "VK8D Up"
global afterNumUp := "VK8E Up"
global rawLeaderUp := "VK8F Up"
global rawStateUp := "VK97 Up"
global regSpacingUp := "VK98 Up"
global capSpacingUp := "VK99 Up"
global nestedPunctuationUp := "VKD8 Up"



; ------------------- Nested Punctuation -------------------

#If (GetKeyState(nestedPunctuation))

:*?: .::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right}.{Space}{%capSpacingDn%}{%regSpacingUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right}.{Space}
		}
		else
		{
			SendInput {Right}.{Space}{%capSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right}.{Space}{%capSpacingDn%}{%regSpacingUp%}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right}.{Space}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Right}.{Space}{%capSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return

:*?: ,::

	IniRead, inQuote, Status.ini, nestVars, inQuote
	if(inQuote)
	{
		inQuote := false
		IniWrite, %inQuote%, Status.ini, nestVars, inQuote
	}

	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	nestLevel := nestLevel - 1
	IniWrite, %nestLevel%, Status.ini, nestVars, nestLevel

	DealWithSubscriptAndSuperscriptPassThrough()

	if(nestLevel > 0)
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right},{Space}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%capSpacingUp%}
		}
		else
		{
			SendInput {Right},{Space}{%regSpacingDn%}
		}
	}
	else
	{
		if(GetKeyState(regSpacing))
		{			
			SendInput {Right},{Space}{%nestedPunctuationUp%}
		}
		else if(GetKeyState(capSpacing))
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%capSpacingUp%}{%nestedPunctuationUp%}
		}
		else
		{
			SendInput {Right},{Space}{%regSpacingDn%}{%nestedPunctuationUp%}
		}
	}

	return
	
#If