SendMode Input
#NoEnv
#SingleInstance force



; Change Masking Key
;-------------------------------------------------

; Prevents masked Hotkeys from sending LCtrls that can interfere with the script.
; See https://autohotkey.com/docs/commands/_MenuMaskKey.htm
#MenuMaskKey VK07



; Imports
;-------------------------------------------------

#Include <functions>
#Include <hotstrings>



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



; Create Key Aliases
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
global nestedPunctuation := "VKE8"

global ctrlLeader := "VKD8"
global altLeader := "VKD9"
global winLeader := "VKDA"

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
global nestedPunctuationDn := "VKE8 Down"

global ctrlLeaderDn := "VKD8 Down"
global altLeaderDn := "VKD9 Down"
global winLeaderDn := "VKDA Down"


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
global nestedPunctuationUp := "VKE8 Up"

global ctrlLeaderUp := "VKD8 Up"
global altLeaderUp := "VKD9 Up"
global winLeaderUp := "VKDA Up"



; Expansion Groupings
;-------------------------------------------------

#Include <expansions/text-briefs>
#Include <expansions/named-entities>
#Include <expansions/nested-punctuation>
#Include <expansions/alternate-usage>
