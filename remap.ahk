SendMode Input
#NoEnv
#SingleInstance force



; Import Functions
;-------------------------------------------------

#Include <dual/dual>
#Include <functions>



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07  



; Initialize Objects And Status Variables
;-------------------------------------------------

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



; Give Keys A Default Value
;-------------------------------------------------

#Include <dual/defaults>



; Remapping Setup
;-------------------------------------------------

#If true ; Wrap in #If to override defaults

#If
