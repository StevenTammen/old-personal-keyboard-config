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


global insertColor := "336600"
global vimColor := "800000"
global barWidth := A_ScreenWidth/1.4


Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, %insertColor%
Gui, Font, s16
Gui, Add, Text, vStatusBar cWhite w%barWidth% h40

SetTimer, UpdateOSD, 200
Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.

Gui, Show, x0 y0 w%barWidth% h40 NoActivate
return
	

UpdateOSD:

	IniRead, vimMode, Status.ini, statusVars, vimMode
	color := insertColor
	if(vimMode)
	{
		color := vimColor
	}

	layer := "Base"
	if(GetKeyState(numLeader) or GetKeyState(numModifier))
	{
		layer := "Num"
	}
	else if(GetKeyState(shiftLeader) or GetKeyState(shiftModifier))
	{
		layer := "Shift"
	}
	else if(GetKeyState(expdLeader) or GetKeyState(expdModifier))
	{
		layer := "Expd"
	}
	else if(GetKeyState(afterNum))
	{
		layer := "AfterNum"
	}

	spacing := "NoSpacing"
	if(!(GetKeyState(rawLeader) or GetKeyState(rawState)))
	{
		if(GetKeyState(regSpacing))
		{
			spacing := "RegSpacing"
		}
		else if(GetKeyState(capSpacing))
		{
			spacing := "CapSpacing"
		}
	}
	
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingCharsInOrder := ""
	Loop, Parse, closingChars
	{
		closingCharsInOrder := closingCharsInOrder . " " . A_LoopField
	}
	
	text := layer . "         " . spacing . "         " . nestLevel . "         " . closingCharsInOrder
	
	Gui, Color, %color%
	GuiControl,, StatusBar, %text%
	Gui, +AlwaysOnTop
	return