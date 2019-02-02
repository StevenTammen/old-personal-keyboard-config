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

#Include <functions>
#Include <hotstrings>



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



; Expansion Groupings
;-------------------------------------------------

#Include <expansions/text-briefs>
#Include <expansions/named-entities>
#Include <expansions/command-briefs>
#Include <expansions/code-briefs>
#Include <expansions/alternate-usage>
