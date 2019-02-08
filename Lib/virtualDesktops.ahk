; Set up library hooks
;-------------------------------------------------
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\Lib\VirtualDesktopAccessor.dll", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")


; Define numerical values for each desktop
;-------------------------------------------------

global TASKS := 0
global COMM := 1
global WRITING1 := 2
global WRITING2 := 3
global CODING1 := 4
global CODING2 := 5
global BIBLESTUDY1 := 6
global BIBLESTUDY2 := 7
global READING1 := 8
global READING2 := 9
global PHOTO1 := 10
global PHOTO2 := 11
global VIDEO1 := 12
global VIDEO2 := 13
global SPREADSHEET1 := 14
global SPREADSHEET2 := 15
global OTHER1 := 16
global OTHER2 := 17


; Define associatative arrays for location on all 18 virtual desktops for all 2 layers
; for all 4 window positions
;-------------------------------------------------



global desktops := [TASKS, COMM, WRITING1, WRITING2, CODING1, CODING2, BIBLESTUDY1, BIBLESTUDY2, READING1, READING2, PHOTO1, PHOTO2, VIDEO1, VIDEO2, SPREADSHEET1, SPREADSHEET2, OTHER1, OTHER2]

global layers := ["unlayered", "layered"]

global positions := ["farLeft", "midLeft", "midRight", "farRight"]
		
global locationDict := {}
for i, desktop in desktops
{
	locationDict[desktop] := {}
	
	for j, layer in layers
	{
		locationDict[desktop][layer] := {}
		
		for k, position in positions
		{
			locationDict[desktop][layer][position] := ""
		}
	}
}


; Define an associatative array for storing location information for
; all windows being tracked by the script.
;-------------------------------------------------

global windowDict := {}



; Function definitions
;-------------------------------------------------

GetCurrentDesktop()
{
	return DllCall(GetCurrentDesktopNumberProc, UInt)
}


GetActiveWindowID()
{
	WinGet, activeWindow_id, ID, A
	return activeWindow_id
}


AssociateActiveWindowWithLocation(layer, position)
{
	window_id := GetActiveWindowID()
	currentDesktop := GetCurrentDesktop()
	locationDict[currentDesktop][layer][position] := window_id
	windowDict[window_id] := {"desktop": currentDesktop, "layer": layer, "position": position}
	return
}


GetWindowAtLocation(layer, position)
{
	currentDesktop := GetCurrentDesktop()
	window_id := locationDict[currentDesktop][layer][position]
	return window_id
}


FocusWindow(layer, position)
{
	window_id := GetWindowAtLocation(layer, Position)

	; Only change focus if there is actually a window that can be focused
	if(window_id != "")
	{
		; Switch into Vim mode when switching windows
		EnterVimMode()
		
		WinActivate, ahk_id %window_id%
	}
	
	return
}


ClearWindowsOnDesktop()
{
	currentDesktop := GetCurrentDesktop()
	for i, layer in layers
	{
		for j, position in positions
		{
			locationDict[currentDesktop][layer][position] := ""
		}
	}
}


ClearAllWindows()
{
	for i, desktop in desktops
	{
		for j, layer in layers
		{
			for k, position in positions
			{
				locationDict[desktop][layer][position] := ""
			}
		}
	}
}


RemoveActiveWinFromDicts()
{
	window_id := GetActiveWindowID()
	window_info := windowDict[window_id]
	desktop := window_info["desktop"]
	layer := window_info["layer"]
	position := window_info["position"]
	
	locationDict[desktop][layer][position] := ""
	windowDict.Delete(window_id)
	return
}


PrintDebugArrays()
{
	str := ""
	for j, layer in layers
	{
		for k, position in positions
		{
			window_id := GetWindowAtLocation(layer, position)
			if(window_id == "")
			{
				window_id := "_"
			}
			str := str . layer . " - " . position . ": " . window_id . "`n"
		}
	}
	
	MsgBox % str
}