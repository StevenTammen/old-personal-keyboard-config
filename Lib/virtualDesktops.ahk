; Set up library hooks
;-------------------------------------------------
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\Lib\VirtualDesktopAccessor.dll", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")
global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")
global IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnCurrentVirtualDesktop", "Ptr")

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


CreateTasks()
{
	Run chrome.exe
	Sleep, 2000
	Place_FarLeft("unlayered")
	SendInput {Raw}https://www.meistertask.com/app/project/dfvI3LQ8/daily-tasks
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	
	Run %ComSpec% /c C:\Users\steve\AppData\Local\emacs\bin\emacsclientw.exe -c -n -a ""
	Sleep, 6000
	Run C:\Users\steve\Desktop\Projects\steventammen.com\org\drafts\braindump.org
	Sleep, 8000
	Place_MidLeft("unlayered")

	
	Run chrome.exe
	Sleep, 3000
	Place_FarRight("unlayered")
	SendInput {Raw}https://calendar.google.com/calendar/r
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	
	Run chrome.exe
	Sleep, 3000
	Place_MidRight("unlayered")
	SendInput {Raw}https://www.meistertask.com/app/project/9mWV72TC/life
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	SendInput ^t
	Sleep, 200
	SendInput {Raw}https://www.meistertask.com/app/dashboard
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	SendInput ^t
	Sleep, 200
	SendInput {Raw}https://www.meistertask.com/app/dashboard
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
}


CreateCommunication()
{
	Run C:\Program Files (x86)\Microsoft\Skype for Desktop\Skype.exe
	Sleep 20000
	Place_FarLeft("layered")

	phoneApp := A_ScriptDir . "\YourPhone.lnk"
	Run %phoneApp%
	Sleep, 2000
	Place_FarRight("unlayered")

	Run %ComSpec% /c C:\Users\steve\AppData\Local\Discord\Update.exe --processStart Discord.exe
	Sleep, 20000
	Place_FarLeft("unlayered")

	Run chrome.exe
	Sleep, 5000
	Place_Mid("unlayered")
	SendInput {Raw}https://mail.google.com/mail/u/0/#inbox
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	SendInput ^t
	Sleep, 200
	SendInput {Raw}https://outlook.office.com/mail/inbox
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
}


CreateWriting1()
{
	Run C:\Users\steve\Desktop\WSL Terminal.lnk
	Sleep, 8000
	Place_FarLeft("layered")
	
	Run %ComSpec% /c C:\Users\steve\AppData\Local\emacs\bin\emacsclientw.exe -c -n -a ""
	Sleep, 17000
	Place_MidRight("unlayered")
	
	Run %ComSpec% /c C:\Users\steve\AppData\Local\emacs\bin\emacsclientw.exe -c -n -a ""
	Sleep, 5000
	Place_MidLeft("unlayered")
	
	Run explorer.exe
	Sleep, 3000
	Place_Mid("layered")
	
	Run chrome.exe
	Sleep, 3000
	Place_FarRight("layered")
	SendInput {Raw}http://localhost:1313/drafts/
	Sleep, 1000
	SendInput {Enter}
	Sleep, 200
	Run chrome.exe
	Sleep, 3000
	Place_FarRight("unlayered")
	
	Run chrome.exe
	Sleep, 3000
	Place_FarLeft("unlayered")
}


Win__Fling(WinID, Position)
{
   ; Figure out which window to move based on the "WinID" function parameter:
   ;   1) The letter "A" means to use the Active window
   ;   2) The letter "M" means to use the window under the Mouse
   ; Otherwise, the parameter value is assumed to be the AHK window ID of the window to use.

   if (WinID = "A")
   {
      ; If the user supplied an "A" as the window ID, we use the Active window
      WinID := WinExist("A")
   }
   else if (WinID = "M")
   {
      ; If the user supplied an "M" as the window ID, we use the window currently under the Mouse
      MouseGetPos, MouseX, MouseY, WinID      ; MouseX & MouseY are retrieved but, for now, not used
   }

   ; Check to make sure we are working with a valid window
   IfWinNotExist, ahk_id %WinID%
   {
      ; Make a short noise so the user knows to stop expecting something fun to happen.
      SoundPlay, *64
      
      ; Debug Support
      ;MsgBox, 16, Window Fling: Error, Specified window does not exist.`nWindow ID = %WinID%

      return 0
   }

   ; Here's where we find out just how many monitors we're dealing with
   SysGet, MonitorCount, MonitorCount

   if (MonitorCount > 3)
   {
      ; Require less than 3 monitors for this script. More is an error.
      return 0
   }

   ; Retrieve the target window's original minimized / maximized state
   WinGet, WinOriginalMinMaxState, MinMax, ahk_id %WinID%

   ; We don't do anything with minimized windows
   if (WinOriginalMinMaxState = -1)
   {
      ; Debatable as to whether or not this should be flagged as an error
      return 0
   }
   
   ; For each active monitor, we get Top, Bottom, Left, Right of the monitor's
   ;  'Work Area' (i.e., excluding taskbar, etc.). From these values we compute Width and Height.
   ;  Results get put into variables named like "Monitor1Top" and "Monitor2Width", etc.,
   ;  with the monitor number embedded in the middle of the variable name.

   Loop, %MonitorCount%
   {
      SysGet, Monitor%A_Index%, MonitorWorkArea, %A_Index%
      Monitor%A_Index%Width  := Monitor%A_Index%Right  - Monitor%A_Index%Left
      Monitor%A_Index%Height := Monitor%A_Index%Bottom - Monitor%A_Index%Top
   }
   
	; One monitor. Assuming it is 1920x1080. Will add 4k behavior later.
	if(MonitorCount == 1)
	{
		if(Position == "farLeft" or Position == "midLeft")
		{
			MoveWindow(WinID, "Left")
		}
		else if(Position == "mid")
		{
			MoveWindow(WinID)
		}
		else ; Position == "midRight" or Position == "farRight"
		{
			MoveWindow(WinID, "Right")
		}
	}
	
	else
	{
		; Retrieve the target window's original dimensions
		WinGetPos, WinX, WinY, WinW, WinH, ahk_id %WinID%

		; Find the point at the centre of the target window then use it
		; to determine the monitor to which the target window belongs
		; (windows don't have to be entirely contained inside any one monitor's area).

		WinCentreX := WinX + WinW / 2
		WinCentreY := WinY + WinH / 2

		CurrMonitor = 0
		Loop, %MonitorCount%
		{
			if (    (WinCentreX >= Monitor%A_Index%Left) and (WinCentreX < Monitor%A_Index%Right )
			and (WinCentreY >= Monitor%A_Index%Top ) and (WinCentreY < Monitor%A_Index%Bottom))
			{
				CurrMonitor = %A_Index%
				break
			}
		}
		
		; Two monitors
		if(MonitorCount == 2)
		{
			if(Monitor1Left < Monitor2Left)
			{
				LeftMonitor := 1
				RightMonitor := 2
			}
			else ;(Monitor2Left < Monitor1Left)
			{
				LeftMonitor := 2
				RightMonitor := 1
			}
			
			if(CurrMonitor == LeftMonitor)
			{
				if(Position == "farLeft" or Position == "midLeft")
				{
					MoveWindow(WinID)
				}
				; There is no middle position with only 2 monitors. Rather than throwing
				; an error, just stick the window on the monitor it starts on
				else if(Position == "mid")
				{
					MoveWindow(WinID)
				}
				else ; Position == "midRight" or Position == "farRight"
				{
					MoveWindow(WinID, "FullWidth", RightMonitor, Monitor%RightMonitor%Left, Monitor%RightMonitor%Top, Monitor%RightMonitor%Width, Monitor%RightMonitor%Height)
				}
			}
			else ; CurrMonitor == RightMonitor
			{
				if(Position == "farLeft" or Position == "midLeft")
				{
					MoveWindow(WinID, "FullWidth", LeftMonitor, Monitor%LeftMonitor%Left, Monitor%LeftMonitor%Top, Monitor%LeftMonitor%Width, Monitor%LeftMonitor%Height)
				}
				; There is no middle position with only 2 monitors. Rather than throwing
				; an error, just stick the window on the monitor it starts on
				else if(Position == "mid")
				{
					MoveWindow(WinID)
				}
				else ; Position == "midRight" or Position == "farRight"
				{
					MoveWindow(WinID)
				}
			}
		}
	   
		; Three monitors
		else
		{

			if(Monitor1Left < Monitor2Left and Monitor1Left < Monitor3Left)
			{
				LeftMonitor := 1
				if(Monitor2Left < Monitor3Left)
				{
					CenterMonitor := 2
					RightMonitor := 3
				}
				else ; Monitor3Left < Monitor2Left
				{
					CenterMonitor := 3
					RightMonitor := 2
				}
			}
			else if(Monitor2Left < Monitor1Left and Monitor2Left < Monitor3Left)
			{
				LeftMonitor := 2
				if(Monitor1Left < Monitor3Left)
				{
					CenterMonitor := 1
					RightMonitor := 3
				}
				else ; Monitor3Left < Monitor1Left
				{
					CenterMonitor := 3
					RightMonitor := 1
				}
			}
			else ;(Monitor3Left < Monitor1Left and Monitor3Left < Monitor2Left)
			{
				LeftMonitor := 3
				if(Monitor1Left < Monitor2Left)
				{
					CenterMonitor := 1
					RightMonitor := 2
				}
				else ; Monitor2Left < Monitor1Left
				{
					CenterMonitor := 2
					RightMonitor := 1
				}
			}
		
		
			if(CurrMonitor == LeftMonitor)
			{
				if(Position == "farLeft")
				{
					MoveWindow(WinID)
				}
				else if(Position == "midLeft")
				{
					MoveWindow(WinID, "Left", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else if(Position == "mid")
				{
					MoveWindow(WinID, "FullWidth", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else if(Position == "midRight")
				{
					MoveWindow(WinID, "Right", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else ;(Position == "farRight")
				{
					MoveWindow(WinID, "FullWidth", RightMonitor, Monitor%RightMonitor%Left, Monitor%RightMonitor%Top, Monitor%RightMonitor%Width, Monitor%RightMonitor%Height)
				}
			}
			else if(CurrMonitor == CenterMonitor)
			{
				if(Position == "farLeft")
				{
					MoveWindow(WinID, "FullWidth", LeftMonitor, Monitor%LeftMonitor%Left, Monitor%LeftMonitor%Top, Monitor%LeftMonitor%Width, Monitor%LeftMonitor%Height)
				}
				else if(Position == "midLeft")
				{
					MoveWindow(WinID, "Left")
				}
				else if(Position == "mid")
				{
					MoveWindow(WinID)
				}
				else if(Position == "midRight")
				{
					MoveWindow(WinID, "Right")
				}
				else ;(Position == "farRight")
				{
					MoveWindow(WinID, "FullWidth", RightMonitor, Monitor%RightMonitor%Left, Monitor%RightMonitor%Top, Monitor%RightMonitor%Width, Monitor%RightMonitor%Height)
				}
			}
			else ; (CurrMonitor == RightMonitor)
			{
				if(Position == "farLeft")
				{
					MoveWindow(WinID, "FullWidth", LeftMonitor, Monitor%LeftMonitor%Left, Monitor%LeftMonitor%Top, Monitor%LeftMonitor%Width, Monitor%LeftMonitor%Height)
				}
				else if(Position == "midLeft")
				{
					MoveWindow(WinID, "Left", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else if(Position == "mid")
				{
					MoveWindow(WinID, "FullWidth", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else if(Position == "midRight")
				{
					MoveWindow(WinID, "Right", CenterMonitor, Monitor%CenterMonitor%Left, Monitor%CenterMonitor%Top, Monitor%CenterMonitor%Width, Monitor%CenterMonitor%Height)
				}
				else ;(Position == "farRight")
				{
					MoveWindow(WinID)
				}
			}
		}
	}

   return 1
}


MoveWindow(WinID, ScreenSide = "FullWidth", NextMonitor = 0, WinFlingX = 0, WinFlingY = 0, WinFlingW = 0, WinFlingH = 0)
{
	if(NextMonitor != 0)
	{
		WinMove, ahk_id %WinID%,, WinFlingX, WinFlingY, WinFlingW, WinFlingH
		Sleep, 500
	}

	WinMaximize, ahk_id %WinID%

	if(ScreenSide == "Left")
	{
		Sleep, 500
		SendInput #{Left}
	}
	else if(ScreenSide == "Right")
	{
		Sleep, 500
		SendInput #{Right}
	}
	
	Sleep, 500
}


Place_FarLeft(layerState)
{
	Win__Fling("A", "farLeft")
	AssociateActiveWindowWithLocation(layerState, "farLeft")
}


Place_MidLeft(layerState)
{
	Win__Fling("A", "midLeft")
	AssociateActiveWindowWithLocation(layerState, "midLeft")
}


Place_Mid(layerState)
{
	Win__Fling("A", "mid")
	AssociateActiveWindowWithLocation(layerState, "midLeft")
	AssociateActiveWindowWithLocation(layerState, "midRight")
}


Place_MidRight(layerState)
{
	Win__Fling("A", "midRight")
	AssociateActiveWindowWithLocation(layerState, "midRight")
}


Place_FarRight(layerState)
{
	Win__Fling("A", "farRight")
	AssociateActiveWindowWithLocation(layerState, "farRight")
}


GetCurrentDesktop()
{
	return DllCall(GetCurrentDesktopNumberProc, UInt)
}


PrintCurrentDesktop()
{
	
	currentDesktop := GetCurrentDesktop()

	if(currentDesktop == TASKS)
	{
		MsgBox % "Tasks"
	}
	else if(currentDesktop == COMM)
	{
		MsgBox % "Communication"
	}
	else if(currentDesktop == WRITING1)
	{
		MsgBox % "Writing 1"
	}
	else if(currentDesktop == WRITING2)
	{
		MsgBox % "Writing 2"
	}
	else if(currentDesktop == CODING1)
	{
		MsgBox % "Coding 1"
	}
	else if(currentDesktop == CODING2)
	{
		MsgBox % "Coding 2"
	}
	else if(currentDesktop == BIBLESTUDY1)
	{
		MsgBox % "Bible Study 1"
	}
	else if(currentDesktop == BIBLESTUDY2)
	{
		MsgBox % "Bible Study 2"
	}
	else if(currentDesktop == READING1)
	{
		MsgBox % "Reading 1"
	}
	else if(currentDesktop == READING2)
	{
		MsgBox % "Reading 2"
	}
	else if(currentDesktop == PHOTO1)
	{
		MsgBox % "Photo 1"
	}
	else if(currentDesktop == PHOTO2)
	{
		MsgBox % "Photo 2"
	}
	else if(currentDesktop == VIDEO1)
	{
		MsgBox % "Video 1"
	}
	else if(currentDesktop == VIDEO2)
	{
		MsgBox % "Video 2"
	}
	else if(currentDesktop == SPREADSHEET1)
	{
		MsgBox % "Spreadsheet 1"
	}
	else if(currentDesktop == SPREADSHEET2)
	{
		MsgBox % "Spreadsheet 2"
	}
	else if(currentDesktop == OTHER1)
	{
		MsgBox % "Other 1"
	}
	else ;(currentDesktop == OTHER2)
	{
		MsgBox % "Other 2"
	}
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