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
global expdLeader := "VK3A"
global expdModifier := "VK3B"
global afterNum := "VK3C"
global rawLeader := "VK3D"
global rawState := "VK88"
global regSpacing := "VK89"
global capSpacing := "VK8A"
global nestedPunctuation := "VK8B"

global ctrlLeader := "VK8C"
global altLeader := "VK8D"
global winLeader := "VK8E"

; Explicit down and up variables are defined for ease of use: using expression syntax and straight key definitions,
; you would need concatenation like ~keyVar . " Down"~ and ~keyVar . " Up"~, which is a bit verbose.
; I have found AHK's expression/%traditional syntax% quite bug-prone, so have opted to do it this way.

global numLeaderDn := "VK0E Down"
global numModifierDn := "VK0F Down"
global shiftLeaderDn := "VK16 Down"
global shiftModifierDn := "VK1A Down"
global expdLeaderDn := "VK3A Down"
global expdModifierDn := "VK3B Down"
global afterNumDn := "VK3C Down"
global rawLeaderDn := "VK3D Down"
global rawStateDn := "VK88 Down"
global regSpacingDn := "VK89 Down"
global capSpacingDn := "VK8A Down"
global nestedPunctuationDn := "VK8B Down"

global ctrlLeaderDn := "VK8C Down"
global altLeaderDn := "VK8D Down"
global winLeaderDn := "VK8E Down"


global numLeaderUp := "VK0E Up"
global numModifierUp := "VK0F Up"
global shiftLeaderUp := "VK16 Up"
global shiftModifierUp := "VK1A Up"
global expdLeaderUp := "VK3A Up"
global expdModifierUp := "VK3B Up"
global afterNumUp := "VK3C Up"
global rawLeaderUp := "VK3D Up"
global rawStateUp := "VK88 Up"
global regSpacingUp := "VK89 Up"
global capSpacingUp := "VK8A Up"
global nestedPunctuationUp := "VK8B Up"

global ctrlLeaderUp := "VK8C Up"
global altLeaderUp := "VK8D Up"
global winLeaderUp := "VK8E Up"



; Expansion Groupings
;-------------------------------------------------

#Include <expansions/text-briefs>
#Include <expansions/named-entities>
#Include <expansions/command-briefs>
#Include <expansions/code-briefs>
#Include <expansions/alternate-usage>
