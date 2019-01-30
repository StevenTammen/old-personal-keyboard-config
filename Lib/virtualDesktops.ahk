; Set up library hooks
;-------------------------------------------------
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\VirtualDesktopAccessor.dll", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GetCurrentDesktopNumber", "Ptr")



; Track window state on all 18 virtual desktops for all 4
; window positions for all 2 isLayereds
;-------------------------------------------------
global Tasks_farLeft := ""
global Tasks_midLeft := ""
global Tasks_midRight := ""
global Tasks_farRight := ""

global Tasks_layer_farLeft := ""
global Tasks_layer_midLeft := ""
global Tasks_layer_midRight := ""
global Tasks_layer_farRight := ""


global Comm_farLeft := ""
global Comm_midLeft := ""
global Comm_midRight := ""
global Comm_farRight := ""

global Comm_layer_farLeft := ""
global Comm_layer_midLeft := ""
global Comm_layer_midRight := ""
global Comm_layer_farRight := ""


global Writing1_farLeft := ""
global Writing1_midLeft := ""
global Writing1_midRight := ""
global Writing1_farRight := ""

global Writing1_layer_farLeft := ""
global Writing1_layer_midLeft := ""
global Writing1_layer_midRight := ""
global Writing1_layer_farRight := ""


global Writing2_farLeft := ""
global Writing2_midLeft := ""
global Writing2_midRight := ""
global Writing2_farRight := ""

global Writing2_layer_farLeft := ""
global Writing2_layer_midLeft := ""
global Writing2_layer_midRight := ""
global Writing2_layer_farRight := ""


global Coding1_farLeft := ""
global Coding1_midLeft := ""
global Coding1_midRight := ""
global Coding1_farRight := ""

global Coding1_layer_farLeft := ""
global Coding1_layer_midLeft := ""
global Coding1_layer_midRight := ""
global Coding1_layer_farRight := ""


global Coding2_farLeft := ""
global Coding2_midLeft := ""
global Coding2_midRight := ""
global Coding2_farRight := ""

global Coding2_layer_farLeft := ""
global Coding2_layer_midLeft := ""
global Coding2_layer_midRight := ""
global Coding2_layer_farRight := ""


global BibleStudy1_farLeft := ""
global BibleStudy1_midLeft := ""
global BibleStudy1_midRight := ""
global BibleStudy1_farRight := ""

global BibleStudy1_layer_farLeft := ""
global BibleStudy1_layer_midLeft := ""
global BibleStudy1_layer_midRight := ""
global BibleStudy1_layer_farRight := ""


global BibleStudy2_farLeft := ""
global BibleStudy2_midLeft := ""
global BibleStudy2_midRight := ""
global BibleStudy2_farRight := ""

global BibleStudy2_layer_farLeft := ""
global BibleStudy2_layer_midLeft := ""
global BibleStudy2_layer_midRight := ""
global BibleStudy2_layer_farRight := ""


global Reading1_farLeft := ""
global Reading1_midLeft := ""
global Reading1_midRight := ""
global Reading1_farRight := ""

global Reading1_layer_farLeft := ""
global Reading1_layer_midLeft := ""
global Reading1_layer_midRight := ""
global Reading1_layer_farRight := ""


global Reading2_farLeft := ""
global Reading2_midLeft := ""
global Reading2_midRight := ""
global Reading2_farRight := ""

global Reading2_layer_farLeft := ""
global Reading2_layer_midLeft := ""
global Reading2_layer_midRight := ""
global Reading2_layer_farRight := ""


global Photo1_farLeft := ""
global Photo1_midLeft := ""
global Photo1_midRight := ""
global Photo1_farRight := ""

global Photo1_layer_farLeft := ""
global Photo1_layer_midLeft := ""
global Photo1_layer_midRight := ""
global Photo1_layer_farRight := ""


global Photo2_farLeft := ""
global Photo2_midLeft := ""
global Photo2_midRight := ""
global Photo2_farRight := ""

global Photo2_layer_farLeft := ""
global Photo2_layer_midLeft := ""
global Photo2_layer_midRight := ""
global Photo2_layer_farRight := ""


global Video1_farLeft := ""
global Video1_midLeft := ""
global Video1_midRight := ""
global Video1_farRight := ""

global Video1_layer_farLeft := ""
global Video1_layer_midLeft := ""
global Video1_layer_midRight := ""
global Video1_layer_farRight := ""


global Video2_farLeft := ""
global Video2_midLeft := ""
global Video2_midRight := ""
global Video2_farRight := ""

global Video2_layer_farLeft := ""
global Video2_layer_midLeft := ""
global Video2_layer_midRight := ""
global Video2_layer_farRight := ""


global Spreadsheet1_farLeft := ""
global Spreadsheet1_midLeft := ""
global Spreadsheet1_midRight := ""
global Spreadsheet1_farRight := ""

global Spreadsheet1_layer_farLeft := ""
global Spreadsheet1_layer_midLeft := ""
global Spreadsheet1_layer_midRight := ""
global Spreadsheet1_layer_farRight := ""


global Spreadsheet2_farLeft := ""
global Spreadsheet2_midLeft := ""
global Spreadsheet2_midRight := ""
global Spreadsheet2_farRight := ""

global Spreadsheet2_layer_farLeft := ""
global Spreadsheet2_layer_midLeft := ""
global Spreadsheet2_layer_midRight := ""
global Spreadsheet2_layer_farRight := ""


global Other1_farLeft := ""
global Other1_midLeft := ""
global Other1_midRight := ""
global Other1_farRight := ""

global Other1_layer_farLeft := ""
global Other1_layer_midLeft := ""
global Other1_layer_midRight := ""
global Other1_layer_farRight := ""


global Other2_farLeft := ""
global Other2_midLeft := ""
global Other2_midRight := ""
global Other2_farRight := ""

global Other2_layer_farLeft := ""
global Other2_layer_midLeft := ""
global Other2_layer_midRight := ""
global Other2_layer_farRight := ""



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



; Function definitions
;-------------------------------------------------

GetCurrentDesktop()
{
	return DllCall(GetCurrentDesktopNumberProc, UInt)
}

AssociateActiveWindowWithPosition(isLayered, position)
{
	
	window_id := GetActiveWindowID()
	currentDesktop := GetCurrentDesktop()

	if(currentDesktop == TASKS)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Tasks_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Tasks_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Tasks_midRight := window_id
			}
			else ; position == "farRight"
			{
				Tasks_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Tasks_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Tasks_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Tasks_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Tasks_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == COMM)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Comm_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Comm_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Comm_midRight := window_id
			}
			else ; position == "farRight"
			{
				Comm_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Comm_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Comm_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Comm_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Comm_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == WRITING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Writing1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Writing1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Writing1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Writing1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Writing1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Writing1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Writing1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Writing1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == WRITING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Writing2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Writing2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Writing2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Writing2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Writing2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Writing2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Writing2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Writing2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == CODING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Coding1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Coding1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Coding1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Coding1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Coding1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Coding1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Coding1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Coding1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == CODING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Coding2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Coding2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Coding2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Coding2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Coding2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Coding2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Coding2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Coding2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == BIBLESTUDY1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				BibleStudy1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				BibleStudy1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				BibleStudy1_midRight := window_id
			}
			else ; position == "farRight"
			{
				BibleStudy1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				BibleStudy1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				BibleStudy1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				BibleStudy1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				BibleStudy1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == BIBLESTUDY2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				BibleStudy2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				BibleStudy2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				BibleStudy2_midRight := window_id
			}
			else ; position == "farRight"
			{
				BibleStudy2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				BibleStudy2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				BibleStudy2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				BibleStudy2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				BibleStudy2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == READING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Reading1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Reading1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Reading1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Reading1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Reading1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Reading1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Reading1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Reading1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == READING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Reading2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Reading2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Reading2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Reading2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Reading2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Reading2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Reading2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Reading2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == PHOTO1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Photo1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Photo1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Photo1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Photo1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Photo1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Photo1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Photo1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Photo1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == PHOTO2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Photo2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Photo2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Photo2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Photo2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Photo2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Photo2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Photo2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Photo2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == VIDEO1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Video1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Video1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Video1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Video1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Video1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Video1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Video1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Video1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == VIDEO2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Video2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Video2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Video2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Video2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Video2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Video2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Video2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Video2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == SPREADSHEET1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Spreadsheet1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Spreadsheet1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Spreadsheet1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Spreadsheet1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Spreadsheet1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Spreadsheet1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Spreadsheet1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Spreadsheet1_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == SPREADSHEET2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Spreadsheet2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Spreadsheet2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Spreadsheet2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Spreadsheet2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Spreadsheet2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Spreadsheet2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Spreadsheet2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Spreadsheet2_layer_farRight := window_id
			}
		}
	}
	
	else if(currentDesktop == OTHER1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Other1_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Other1_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Other1_midRight := window_id
			}
			else ; position == "farRight"
			{
				Other1_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Other1_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Other1_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Other1_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Other1_layer_farRight := window_id
			}
		}
	}
	
	else ; currentDesktop == OTHER2
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				Other2_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Other2_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Other2_midRight := window_id
			}
			else ; position == "farRight"
			{
				Other2_farRight := window_id
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				Other2_layer_farLeft := window_id
			}
			else if(position == "midLeft")
			{
				Other2_layer_midLeft := window_id
			}
			else if(position == "midRight")
			{
				Other2_layer_midRight := window_id
			}
			else ; position == "farRight"
			{
				Other2_layer_farRight := window_id
			}
		}
	}
	
	return
}


GetWindowAtPosition(isLayered, position)
{
	currentDesktop := GetCurrentDesktop()
	window_id := ""

	if(currentDesktop == TASKS)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Tasks_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Tasks_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Tasks_midRight
			}
			else ; position == "farRight"
			{
				window_id := Tasks_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Tasks_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Tasks_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Tasks_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Tasks_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == COMM)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Comm_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Comm_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Comm_midRight
			}
			else ; position == "farRight"
			{
				window_id := Comm_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Comm_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Comm_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Comm_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Comm_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == WRITING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Writing1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Writing1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Writing1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Writing1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Writing1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Writing1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Writing1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Writing1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == WRITING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Writing2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Writing2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Writing2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Writing2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Writing2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Writing2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Writing2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Writing2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == CODING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Coding1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Coding1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Coding1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Coding1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Coding1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Coding1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Coding1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Coding1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == CODING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Coding2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Coding2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Coding2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Coding2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Coding2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Coding2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Coding2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Coding2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == BIBLESTUDY1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := BibleStudy1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := BibleStudy1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := BibleStudy1_midRight
			}
			else ; position == "farRight"
			{
				window_id := BibleStudy1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := BibleStudy1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := BibleStudy1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := BibleStudy1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := BibleStudy1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == BIBLESTUDY2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := BibleStudy2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := BibleStudy2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := BibleStudy2_midRight
			}
			else ; position == "farRight"
			{
				window_id := BibleStudy2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := BibleStudy2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := BibleStudy2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := BibleStudy2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := BibleStudy2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == READING1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Reading1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Reading1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Reading1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Reading1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Reading1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Reading1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Reading1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Reading1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == READING2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Reading2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Reading2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Reading2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Reading2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Reading2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Reading2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Reading2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Reading2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == PHOTO1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Photo1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Photo1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Photo1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Photo1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Photo1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Photo1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Photo1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Photo1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == PHOTO2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Photo2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Photo2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Photo2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Photo2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Photo2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Photo2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Photo2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Photo2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == VIDEO1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Video1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Video1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Video1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Video1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Video1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Video1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Video1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Video1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == VIDEO2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Video2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Video2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Video2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Video2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Video2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Video2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Video2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Video2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == SPREADSHEET1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Spreadsheet1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Spreadsheet1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Spreadsheet1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Spreadsheet1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Spreadsheet1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Spreadsheet1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Spreadsheet1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Spreadsheet1_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == SPREADSHEET2)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Spreadsheet2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Spreadsheet2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Spreadsheet2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Spreadsheet2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Spreadsheet2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Spreadsheet2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Spreadsheet2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Spreadsheet2_layer_farRight
			}
		}
	}
	
	else if(currentDesktop == OTHER1)
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Other1_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Other1_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Other1_midRight
			}
			else ; position == "farRight"
			{
				window_id := Other1_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Other1_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Other1_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Other1_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Other1_layer_farRight
			}
		}
	}
	
	else ; currentDesktop == OTHER2
	{
		if(!isLayered)
		{
			if(position == "farLeft")
			{
				window_id := Other2_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Other2_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Other2_midRight
			}
			else ; position == "farRight"
			{
				window_id := Other2_farRight
			}
		}
		else ; dealing with isLayereded win
		{
			if(position == "farLeft")
			{
				window_id := Other2_layer_farLeft
			}
			else if(position == "midLeft")
			{
				window_id := Other2_layer_midLeft
			}
			else if(position == "midRight")
			{
				window_id := Other2_layer_midRight
			}
			else ; position == "farRight"
			{
				window_id := Other2_layer_farRight
			}
		}
	}
	
	return window_id
}


ClearWindowAtPosition(isLayered, position)
{
	AssociateWindowWithPosition("", isLayered, position)
}


ClearWindowsOnDesktop()
{
	currentDesktop := GetCurrentDesktop()
	
	if(currentDesktop == TASKS)
	{		
		Tasks_farLeft := ""
		Tasks_midLeft := ""
		Tasks_midRight := ""
		Tasks_farRight := ""
		
		Tasks_layer_farLeft := ""
		Tasks_layer_midLeft := ""
		Tasks_layer_midRight := ""
		Tasks_layer_farRight := ""
	}
	
	else if(currentDesktop == COMM)
	{
		Comm_farLeft := ""
		Comm_midLeft := ""
		Comm_midRight := ""
		Comm_farRight := ""
		
		Comm_layer_farLeft := ""
		Comm_layer_midLeft := ""
		Comm_layer_midRight := ""
		Comm_layer_farRight := ""
	}
	
	else if(currentDesktop == WRITING1)
	{
		Writing1_farLeft := ""
		Writing1_midLeft := ""
		Writing1_midRight := ""
		Writing1_farRight := ""
		
		Writing1_layer_farLeft := ""
		Writing1_layer_midLeft := ""
		Writing1_layer_midRight := ""
		Writing1_layer_farRight := ""
	}
	
	else if(currentDesktop == WRITING2)
	{
		Writing2_farLeft := ""
		Writing2_midLeft := ""
		Writing2_midRight := ""
		Writing2_farRight := ""
		
		Writing2_layer_farLeft := ""
		Writing2_layer_midLeft := ""
		Writing2_layer_midRight := ""
		Writing2_layer_farRight := ""
	}
	
	else if(currentDesktop == CODING1)
	{
		Coding1_farLeft := ""
		Coding1_midLeft := ""
		Coding1_midRight := ""
		Coding1_farRight := ""
		
		Coding1_layer_farLeft := ""
		Coding1_layer_midLeft := ""
		Coding1_layer_midRight := ""
		Coding1_layer_farRight := ""
	}
	
	else if(currentDesktop == CODING2)
	{
		Coding2_farLeft := ""
		Coding2_midLeft := ""
		Coding2_midRight := ""
		Coding2_farRight := ""
		
		Coding2_layer_farLeft := ""
		Coding2_layer_midLeft := ""
		Coding2_layer_midRight := ""
		Coding2_layer_farRight := ""
	}
	
	else if(currentDesktop == BIBLESTUDY1)
	{
		BibleStudy1_farLeft := ""
		BibleStudy1_midLeft := ""
		BibleStudy1_midRight := ""
		BibleStudy1_farRight := ""
		
		BibleStudy1_layer_farLeft := ""
		BibleStudy1_layer_midLeft := ""
		BibleStudy1_layer_midRight := ""
		BibleStudy1_layer_farRight := ""
	}
	
	else if(currentDesktop == BIBLESTUDY2)
	{
		BibleStudy2_farLeft := ""
		BibleStudy2_midLeft := ""
		BibleStudy2_midRight := ""
		BibleStudy2_farRight := ""
		
		BibleStudy2_layer_farLeft := ""
		BibleStudy2_layer_midLeft := ""
		BibleStudy2_layer_midRight := ""
		BibleStudy2_layer_farRight := ""
	}
	
	else if(currentDesktop == READING1)
	{
		Reading1_farLeft := ""
		Reading1_midLeft := ""
		Reading1_midRight := ""
		Reading1_farRight := ""
		
		Reading1_layer_farLeft := ""
		Reading1_layer_midLeft := ""
		Reading1_layer_midRight := ""
		Reading1_layer_farRight := ""
	}
	
	else if(currentDesktop == READING2)
	{
		Reading2_farLeft := ""
		Reading2_midLeft := ""
		Reading2_midRight := ""
		Reading2_farRight := ""
		
		Reading2_layer_farLeft := ""
		Reading2_layer_midLeft := ""
		Reading2_layer_midRight := ""
		Reading2_layer_farRight := ""
	}
	
	else if(currentDesktop == PHOTO1)
	{
		Photo1_farLeft := ""
		Photo1_midLeft := ""
		Photo1_midRight := ""
		Photo1_farRight := ""
		
		Photo1_layer_farLeft := ""
		Photo1_layer_midLeft := ""
		Photo1_layer_midRight := ""
		Photo1_layer_farRight := ""
	}
	
	else if(currentDesktop == PHOTO2)
	{
		Photo2_farLeft := ""
		Photo2_midLeft := ""
		Photo2_midRight := ""
		Photo2_farRight := ""
		
		Photo2_layer_farLeft := ""
		Photo2_layer_midLeft := ""
		Photo2_layer_midRight := ""
		Photo2_layer_farRight := ""
	}
	
	else if(currentDesktop == VIDEO1)
	{
		Video1_farLeft := ""
		Video1_midLeft := ""
		Video1_midRight := ""
		Video1_farRight := ""
		
		Video1_layer_farLeft := ""
		Video1_layer_midLeft := ""
		Video1_layer_midRight := ""
		Video1_layer_farRight := ""
	}
	
	else if(currentDesktop == VIDEO2)
	{
		Video2_farLeft := ""
		Video2_midLeft := ""
		Video2_midRight := ""
		Video2_farRight := ""
		
		Video2_layer_farLeft := ""
		Video2_layer_midLeft := ""
		Video2_layer_midRight := ""
		Video2_layer_farRight := ""
	}
	
	else if(currentDesktop == SPREADSHEET1)
	{
		Spreadsheet1_farLeft := ""
		Spreadsheet1_midLeft := ""
		Spreadsheet1_midRight := ""
		Spreadsheet1_farRight := ""
		
		Spreadsheet1_layer_farLeft := ""
		Spreadsheet1_layer_midLeft := ""
		Spreadsheet1_layer_midRight := ""
		Spreadsheet1_layer_farRight := ""
	}
	
	else if(currentDesktop == SPREADSHEET2)
	{
		Spreadsheet2_farLeft := ""
		Spreadsheet2_midLeft := ""
		Spreadsheet2_midRight := ""
		Spreadsheet2_farRight := ""
		
		Spreadsheet2_layer_farLeft := ""
		Spreadsheet2_layer_midLeft := ""
		Spreadsheet2_layer_midRight := ""
		Spreadsheet2_layer_farRight := ""
	}
	
	else if(currentDesktop == OTHER1)
	{
		Other1_farLeft := ""
		Other1_midLeft := ""
		Other1_midRight := ""
		Other1_farRight := ""
		
		Other1_layer_farLeft := ""
		Other1_layer_midLeft := ""
		Other1_layer_midRight := ""
		Other1_layer_farRight := ""
	}
	
	else ; currentDesktop == OTHER2
	{
		Other2_farLeft := ""
		Other2_midLeft := ""
		Other2_midRight := ""
		Other2_farRight := ""
		
		Other2_layer_farLeft := ""
		Other2_layer_midLeft := ""
		Other2_layer_midRight := ""
		Other2_layer_farRight := ""
	}
	
	return
}


ClearAllWindows()
{
	Tasks_farLeft := ""
	Tasks_midLeft := ""
	Tasks_midRight := ""
	Tasks_farRight := ""
	
	Tasks_layer_farLeft := ""
	Tasks_layer_midLeft := ""
	Tasks_layer_midRight := ""
	Tasks_layer_farRight := ""


	Comm_farLeft := ""
	Comm_midLeft := ""
	Comm_midRight := ""
	Comm_farRight := ""
	
	Comm_layer_farLeft := ""
	Comm_layer_midLeft := ""
	Comm_layer_midRight := ""
	Comm_layer_farRight := ""


	Writing1_farLeft := ""
	Writing1_midLeft := ""
	Writing1_midRight := ""
	Writing1_farRight := ""
	
	Writing1_layer_farLeft := ""
	Writing1_layer_midLeft := ""
	Writing1_layer_midRight := ""
	Writing1_layer_farRight := ""


	Writing2_farLeft := ""
	Writing2_midLeft := ""
	Writing2_midRight := ""
	Writing2_farRight := ""
	
	Writing2_layer_farLeft := ""
	Writing2_layer_midLeft := ""
	Writing2_layer_midRight := ""
	Writing2_layer_farRight := ""


	Coding1_farLeft := ""
	Coding1_midLeft := ""
	Coding1_midRight := ""
	Coding1_farRight := ""
	
	Coding1_layer_farLeft := ""
	Coding1_layer_midLeft := ""
	Coding1_layer_midRight := ""
	Coding1_layer_farRight := ""


	Coding2_farLeft := ""
	Coding2_midLeft := ""
	Coding2_midRight := ""
	Coding2_farRight := ""
	
	Coding2_layer_farLeft := ""
	Coding2_layer_midLeft := ""
	Coding2_layer_midRight := ""
	Coding2_layer_farRight := ""


	BibleStudy1_farLeft := ""
	BibleStudy1_midLeft := ""
	BibleStudy1_midRight := ""
	BibleStudy1_farRight := ""
	
	BibleStudy1_layer_farLeft := ""
	BibleStudy1_layer_midLeft := ""
	BibleStudy1_layer_midRight := ""
	BibleStudy1_layer_farRight := ""


	BibleStudy2_farLeft := ""
	BibleStudy2_midLeft := ""
	BibleStudy2_midRight := ""
	BibleStudy2_farRight := ""
	
	BibleStudy2_layer_farLeft := ""
	BibleStudy2_layer_midLeft := ""
	BibleStudy2_layer_midRight := ""
	BibleStudy2_layer_farRight := ""


	Reading1_farLeft := ""
	Reading1_midLeft := ""
	Reading1_midRight := ""
	Reading1_farRight := ""
	
	Reading1_layer_farLeft := ""
	Reading1_layer_midLeft := ""
	Reading1_layer_midRight := ""
	Reading1_layer_farRight := ""


	Reading2_farLeft := ""
	Reading2_midLeft := ""
	Reading2_midRight := ""
	Reading2_farRight := ""
	
	Reading2_layer_farLeft := ""
	Reading2_layer_midLeft := ""
	Reading2_layer_midRight := ""
	Reading2_layer_farRight := ""


	Photo1_farLeft := ""
	Photo1_midLeft := ""
	Photo1_midRight := ""
	Photo1_farRight := ""
	
	Photo1_layer_farLeft := ""
	Photo1_layer_midLeft := ""
	Photo1_layer_midRight := ""
	Photo1_layer_farRight := ""


	Photo2_farLeft := ""
	Photo2_midLeft := ""
	Photo2_midRight := ""
	Photo2_farRight := ""
	
	Photo2_layer_farLeft := ""
	Photo2_layer_midLeft := ""
	Photo2_layer_midRight := ""
	Photo2_layer_farRight := ""


	Video1_farLeft := ""
	Video1_midLeft := ""
	Video1_midRight := ""
	Video1_farRight := ""
	
	Video1_layer_farLeft := ""
	Video1_layer_midLeft := ""
	Video1_layer_midRight := ""
	Video1_layer_farRight := ""


	Video2_farLeft := ""
	Video2_midLeft := ""
	Video2_midRight := ""
	Video2_farRight := ""
	
	Video2_layer_farLeft := ""
	Video2_layer_midLeft := ""
	Video2_layer_midRight := ""
	Video2_layer_farRight := ""


	Spreadsheet1_farLeft := ""
	Spreadsheet1_midLeft := ""
	Spreadsheet1_midRight := ""
	Spreadsheet1_farRight := ""
	
	Spreadsheet1_layer_farLeft := ""
	Spreadsheet1_layer_midLeft := ""
	Spreadsheet1_layer_midRight := ""
	Spreadsheet1_layer_farRight := ""


	Spreadsheet2_farLeft := ""
	Spreadsheet2_midLeft := ""
	Spreadsheet2_midRight := ""
	Spreadsheet2_farRight := ""
	
	Spreadsheet2_layer_farLeft := ""
	Spreadsheet2_layer_midLeft := ""
	Spreadsheet2_layer_midRight := ""
	Spreadsheet2_layer_farRight := ""


	Other1_farLeft := ""
	Other1_midLeft := ""
	Other1_midRight := ""
	Other1_farRight := ""
	
	Other1_layer_farLeft := ""
	Other1_layer_midLeft := ""
	Other1_layer_midRight := ""
	Other1_layer_farRight := ""


	Other2_farLeft := ""
	Other2_midLeft := ""
	Other2_midRight := ""
	Other2_farRight := ""
	
	Other2_layer_farLeft := ""
	Other2_layer_midLeft := ""
	Other2_layer_midRight := ""
	Other2_layer_farRight := ""

	return
}


GetActiveWindowID()
{
	WinGet, activeWindow_id, ID, A
	return activeWindow_id
}


FocusWindow(isLayered, position)
{
	window_id := GetWindowAtPosition(isLayered, Position)

	if(window_id != "")
	{
		WinActivate, ahk_id %window_id%
	}
	
	return
}


Test()
{
	
}