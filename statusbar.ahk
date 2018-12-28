; ---------------------- Key aliases --------------------------

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


; ---------------------- Global constants --------------------------

global insertColor := "00cc66"
global vimColor := "ff9933"
global visualColor := "800000"

global contentWidth := 1000 ;px
global horizontalPadding := 20 ;px
global barWidth := (contentWidth + horizontalPadding)
global controlWidth := contentWidth/4


; ---------------------- Base script --------------------------

Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Font, s26


; Add text labels to keep track of program state
Gui, Add, Text, vLayer cWhite w%controlWidth% h40 x%horizontalPadding% y0
Gui, Add, Text, vSpacing cWhite w%controlWidth% h40 y0
Gui, Add, Text, vNestLevel cWhite w%controlWidth% h40 y0
Gui, Add, Text, vClosingChars cWhite w%controlWidth% h40 y0


; Make the status bar stay on top of the Windows task bar
SetTimer, KeepOnTop, 4000 


; Make the first status update manually
color := GetColor()
layer := GetLayer()
spacing := GetSpacing()
nestLevel := GetNestLevel()
closingchars := GetClosingChars()

UpdateColor(color)
UpdateLayer(layer)
UpdateSpacing(spacing)
UpdateNestLevel(nestLevel)
UpdateClosingChars(closingChars)

global previousColor := color
global previousLayer := layer
global previousSpacing := spacing
global previousNestLevel := nestLevel
global previousClosingChars := closingChars


; Make subsequent status updates five times a second (every 200 ms)
SetTimer, UpdateStatusBar, 200


Gui, Show, x0 y0 w%barWidth% h40 NoActivate

return


; ---------------------- Labels on timers --------------------------

KeepOnTop:
	Gui, +AlwaysOnTop
	return


UpdateStatusBar:

	color := GetColor()
	layer := GetLayer()
	spacing := GetSpacing()
	nestLevel := GetNestLevel()
	closingchars := GetClosingChars()

	; Only update GUI components if they need to be updated
	if(color != previousColor)
	{
		UpdateColor(color)
	}
	if(layer != previousLayer)
	{
		UpdateLayer(layer)
	}
	if(spacing != previousSpacing)
	{
		UpdateSpacing(spacing)
	}
	if(nestLevel != previousNestLevel)
	{
		UpdateNestLevel(nestLevel)
	}
	if(closingChars != previousClosingChars)
	{
		UpdateClosingChars(closingChars)
	}
	
	previousColor := color
	previousLayer := layer
	previousSpacing := spacing
	previousNestLevel := nestLevel
	previousClosingChars := closingChars

	return
	
	
; ---------------------- Getters --------------------------

GetColor()
{
	IniRead, vimMode, Status.ini, statusVars, vimMode
	IniRead, visualMode, Status.ini, statusVars, visualMode
	color := insertColor
	
	if(visualMode != "")
	{
		color := visualColor
	}
	else if(vimMode)
	{
		color := vimColor
	}
	
	return color
}
	
GetLayer()
{
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
	
	return layer
}

GetSpacing()
{
	spacing := "NoSpacing"
	if(GetKeyState(rawLeader) or GetKeyState(rawState))
	{
		spacing := "Raw"
	}
	else if(GetKeyState(regSpacing))
	{
		spacing := "RegSpacing"
	}
	else if(GetKeyState(capSpacing))
	{
		spacing := "CapSpacing"
	}
	
	return spacing
}

GetNestLevel()
{
	IniRead, nestLevel, Status.ini, nestVars, nestLevel
	return nestLevel
}

GetClosingChars()
{
	IniRead, closingChars, Status.ini, nestVars, closingChars
	closingCharsInOrder := ""
	Loop, Parse, closingChars
	{
		closingCharsInOrder := closingCharsInOrder . " " . A_LoopField
	}
	
	return closingCharsInOrder
}



; ---------------------- Updaters --------------------------

UpdateColor(color)
{
	Gui, Color, %color%
}
                                                                         
UpdateLayer(layer)
{
	GuiControl,, Layer, %layer%
}

UpdateSpacing(spacing)
{
	GuiControl,, Spacing, %spacing%
}

UpdateNestLevel(nestLevel)
{
	GuiControl,, NestLevel, %nestLevel%
}

UpdateClosingChars(closingChars)
{
	GuiControl,, ClosingChars, %closingChars%
}