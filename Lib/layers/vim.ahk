EnterVimMode()
{
	vimMode := true
	IniWrite, %vimMode%, Status.ini, statusVars, vimMode
	
	; Always reset autospacing when entering Vim mode, since you probably won't exit it
	; in exactly the same place you entered it, and you don't want extra spaces or
	; weird unpredictable behavior caused by autospacing from before you entered Vim
	; mode picking up when you exit it.
	SendInput {%regSpacingUp%}{%capSpacingUp%}
	
	if(!GetKeyState(rawState))
	{
		SendInput {%rawStateDn%}
	}
	
	if(VimWindowActive())
	{
		SendInput {Esc}
	}
	
	; If not in a text window, do not want to send a {Left} since it can mess things up.
	; This is why this an Elseif not just an Else.
	else if(NonVimTextWindowActive())
	{
		SendInput {Left}
	}
	
	return
}

ExitVimMode()
{
	if(visualMode != "")
	{
		ExitVisualMode()
	}

	vimMode := false
	IniWrite, %vimMode%, Status.ini, statusVars, vimMode
	
	; Always reset Vim action if an action prefix is active when exiting
	action := ""
	
	
	; Chrome is a special case. Most of the the time, we don't want autospaced behavior 
	; in Chrome (http://www.example.com needs raw : / . ), but sometimes we do, as when 
	; typing a quick email in Gmail. We can manually toggle autospacing on to enable Vim
	; behavior, and in this instance, we should keep the autospacing on. Otherwise,
	; we should have Chrome be raw, as when being switched to.
	
	; Keep autospacing when exiting Vim mode if Chrome is being used with Vim mode capabilities
	; and autospaced text
	if(ChromeActive() and autoSpacedChrome)
	{
		SendInput {%rawStateUp%}
	}
	
	; Otherwise disable autospacing if Chrome is not being autospaced, as when being 
	; switched to.
	
	
	else if(!(IDEWindowActive() or TerminalActive() or ChromeActive()))
	{
		SendInput {%rawStateUp%}
	}
	return
}


ExitVisualMode()
{
	if(VimWindowActive())
	{
		SendInput {Esc}
	}
	else if(NonVimTextWindowActive())
	{
		if(visualDirection == "before")
		{
			SendInput {Left}
		}
		else if(visualDirection == "after")
		{
			SendInput {Right}{Left}
		}
	}
	
	visualMode := ""
	IniWrite, %visualMode%, Status.ini, statusVars, visualMode
	return
}


PerformAction(vimKeys, nonVimKeysVisual_initial)
{
	if(action == "copy")
	{
		if(VimWindowActive())
		{
			SendInput y%vimKeys%
		}
		else {
			SendInput %nonVimKeysVisual_initial%^c{Left}
		}
	}
	else if(action == "cut")
	{
		if(VimWindowActive())
		{
			SendInput d%vimKeys%
		}
		else
		{
			SendInput %nonVimKeysVisual_initial%^x
		}
	}
	else if(action == "delete")
	{
		if(VimWindowActive())
		{
			SendInput "zd%vimKeys%
		}
		else
		{
			SendInput %nonVimKeysVisual_initial%{Backspace}
		}
	}
	else if(action == "cut and insert")
	{
		if(VimWindowActive())
		{
			SendInput c%vimKeys%
		}
		else
		{
			SendInput %nonVimKeysVisual_initial%^x
		}
		ExitVimMode()
	}
	else ; (action == "delete and insert")
	{
		if(VimWindowActive())
		{
			SendInput "zc%vimKeys%
		}
		else 
		{
			SendInput %nonVimKeysVisual_initial%{Backspace}
		}
		ExitVimMode()
	}
	
	action := ""
	return
}


PerformVisualMotion(direction, vimKeys, nonVimKeysVisual, nonVimKeysVisual_initial)
{
	if(visualMode == "visual")
	{
		if(initialVisualPress)
		{
			if(VimWindowActive())
			{
				SendInput %vimKeys%
			}
			else
			{
				SendInput %nonVimkeysVisual_initial%
			}
			
			visualDirection := direction
			initialVisualPress := false
		}
		else
		{
			if(VimWindowActive())
			{
				SendInput %vimKeys%
			}
			else
			{
				; Special cases for correctly handling moving by
				; word in opposite direction of visual selection.
				; Ctrl-Shift-Left/Right don't do the right thing
				; to match Vim by default.
				if(visualDirection == "before" and vimKeys == "w")
				{
					SendInput ^+{Right}+{Right}
				}
				else if(visualDirection == "before" and vimKeys == "e")
				{
					SendInput +{Right 2}^+{Right}+{Left}
				}
				else if(visualDirection == "after" and vimKeys == "b")
				{
					SendInput +{Left}^+{Left}+{Right}
				}
				else if(visualDirection == "after" and vimKeys == "ge")
				{
					SendInput +{Right}^+{Left}+{Left 2}+{Right}
				}
				else ; not a special case
				{
					SendInput %nonVimkeysVisual%
				}
			}
		}
	}

	else if(visualMode == "linewise visual")
	{
		if(initialVisualPress)
		{
			if(VimWindowActive())
			{
				SendInput %vimKeys%
			}
			else
			{
				; In linewise visual mode, we only care about two
				; keys: {Down} and {Up}, or j and k in Vim.
				if(vimKeys == "j")
				{
					SendInput +{Down}+{End}
					visualDirection := direction
					initialVisualPress := false
				}
				else if(vimKeys == "k")
				{
					SendInput {End}+{Home}+{Up}+{Home}
					visualDirection := direction
					initialVisualPress := false
				}
			}
		}
		else
		{
			if(VimWindowActive())
			{
				SendInput %vimKeys%
			}
			else
			{
				; We have cases here for going up and down, based
				; on if we are going in the direction of selection.
				
				; In the direction of visual selection.
				if(visualDirection == "after" and vimKeys == "j")
				{
					SendInput +{Down}+{End}
				}
				else if(visualDirection == "before" and vimKeys == "k")
				{
					SendInput +{Up}+{Home}
				}
				
				; Opposite the direction of visual selection.
				else if(visualDirection == "before" and vimKeys == "j")
				{
					SendInput +{Down}
				}
				else if(visualDirection == "after" and vimKeys == "k")
				{
					SendInput +{Up}+{End}
				}
			}
		}
	}
	
	; Blockwise visual mode is only in Vim programs.
	else ; visualMode == "blockwise visual"
	{
		if(VimWindowActive())
		{
			SendInput %vimKeys%
		}
	}
	
	return
}

BasicVimKey(vimKeys, nonVimKeys)
{
	if(VimWindowActive())
	{
		SendInput %vimKeys%
	}
	else
	{
		SendInput %nonVimKeys%
	}
	
	return
}


ActionVimKey(keyAction, vimKeys, nonVimKeys, needToExit)
{
	if(visualMode != "")
	{
		if(VimWindowActive())
		{
			SendInput %vimKeys%
		}
		else
		{
			SendInput %nonVimKeys%
		}
		
		visualMode := ""
		IniWrite, %visualMode%, Status.ini, statusVars, visualMode
		
		if(needToExit)
		{
			ExitVimMode()
		}
	}
	else
	{
		action := keyAction
	}
	
	return
}


MovementVimKey(direction, vimKeys, nonVimKeys, nonVimKeysVisual, nonVimKeysVisual_initial)
{
	if(action != "")
	{
		PerformAction(vimKeys, nonVimKeysVisual_initial)

	}
	else if(visualMode != "")
	{
		PerformVisualMotion(direction, vimKeys, nonVimKeysVisual, nonVimKeysVisual_initial)
	}
	else
	{
		if(VimWindowActive())
		{
			SendInput %vimKeys%
		}
		else
		{
			SendInput %nonVimkeys%
		}
	}
	
	return
}


SelectLineIfDoubleTap()
{
	lastKey := A_PriorHotkey
	if(lastKey == A_ThisHotkey)
	{
		visualMode := "linewise visual"
		IniWrite, %visualMode%, Status.ini, statusVars, visualMode
		initialVisualPress := true
		visualDirection := ""
		BasicVimKey("V", "{Home}+{End}")
		
		action := ""
	}
	return
}


; A variable to track the visual mode state
; Options: "", "visual", "linewise visual", "blockwise visual"
global visualMode := ""
IniWrite, %visualMode%, Status.ini, statusVars, visualMode

; A variable to track the first visual mode movement keypress
; Options: true, false
global initialVisualPress := false

; A variable to track the directionality of visual selection.
; It is dificult to switch the direction if you change your
; mind since there is no actual block cursor outside of real 
; Vim applications, but this variable allows word selection 
; to directly mirror vim behavior
; Options: "", "before", "after"
global visualDirection := ""

; A variable to keep track of actions that take a movement and then exit Vim mode
; Options: "", "copy", "cut", "delete", "cut and insert", "delete and insert"
global action := ""


; Number Row
;-------------------------------------------------

l11_vim() {
	return
}
l12_vim() {
	return
}
l13_vim() {
	return
}
l14_vim() {
	return
}
l15_vim() {
	return
}
l16_vim() {
	if(VimWindowActive())
	{
		SendInput {Esc}
	}
	else
	{
		if(visualDirection == "before")
		{
			SendInput {Left}
		}
		else if(visualDirection == "after")
		{
			SendInput {Right}{Left}
		}
	}
	visualMode := ""
	IniWrite, %visualMode%, Status.ini, statusVars, visualMode
	return
}


r11_vim() {
	if(VimWindowActive())
	{
		SendInput {Esc}
	}
	else
	{
		if(visualDirection == "before")
		{
			SendInput {Left}
		}
		else if(visualDirection == "after")
		{
			SendInput {Right}{Left}
		}
	}
	visualMode := ""
	IniWrite, %visualMode%, Status.ini, statusVars, visualMode
	return
}
r12_vim() {
	return
}
r13_vim() {
	return
}
r14_vim() {
	return
}
r15_vim() {
	return
}
r16_vim() {
	return
}



; Top Row
;-------------------------------------------------

l21_vim() {
	return
}
l22_vim() {
	if(VimWindowActive())
	{
		visualMode := "blockwise visual"
		IniWrite, %visualMode%, Status.ini, statusVars, visualMode
		SendInput ^v
	}
	return
}
l23_vim() {
	visualMode := "linewise visual"
	IniWrite, %visualMode%, Status.ini, statusVars, visualMode
	initialVisualPress := true
	visualDirection := ""
	BasicVimKey("V", "{Home}+{End}")
	return
}
l24_vim() {
	if(undoTransientState)
	{
		BasicVimKey("u", "^z")
		undoCombines := true
	}
	else
	{
		visualMode := "visual"
		IniWrite, %visualMode%, Status.ini, statusVars, visualMode
		initialVisualPress := true
		visualDirection := ""
		BasicVimKey("v", "")
	}
	return
}
l25_vim() {
	BasicVimKey("P", "^v")
	return
}
l26_vim() {
	BasicVimKey(",", "")
	return
}


r21_vim() {
	BasicVimKey(";", "")
	return
}
r22_vim() {
	MovementVimKey("before", "0", "{Home}", "+{Home}", "{Right}+{Home}")
	return
}
r23_vim() {
	MovementVimKey("before", "k", "{Up}", "+{Up}", "{Right}+{Up}")
	return
}
r24_vim() {
	MovementVimKey("after", "$", "{End}", "+{End}", "+{End}")
	return
}
r25_vim() {
	MovementVimKey("before", "{PgUp}", "{PgUp}", "+{PgUp}", "{Right}+{PgUp}")
	return
}
r26_vim() {
	return
}



; Home Row
;-------------------------------------------------

l31_vim() {
	return
}
l32_vim() {
	SelectLineIfDoubleTap()
	ActionVimKey("copy", "y", "^c{Left}", false)
	return
}
l33_vim() {
	SelectLineIfDoubleTap()
	ActionVimKey("cut", "d", "^x", false)
	return
}
l34_vim() {
	if(undoTransientState)
	{
		BasicVimKey("^r", "^y")
		undoCombines := true
	}
	else
	{
		SelectLineIfDoubleTap()
		ActionVimKey("delete", """zd", "{Backspace}", false)
	}
	return
}
l35_vim() {
	BasicVimKey("p", "^v")
	return
}
l36_vim() {
	BasicVimKey("X", "{Backspace}")
	return
}


r31_vim() {
	BasicVimKey("x", "{Del}")
	return
}
r32_vim() {
	MovementVimKey("before", "h", "{Left}", "+{Left}", "{Right}+{Left 2}")
	return
}
r33_vim() {
	MovementVimKey("after", "j", "{Down}", "+{Down}", "+{Down}")
	return
}
r34_vim() {
	MovementVimKey("after", "l", "{Right}", "+{Right}", "+{Right 2}")
	return
}
r35_vim() {
	MovementVimKey("after", "{PgDn}", "{PgDn}", "+{PgDn}", "+{PgDn}")
	return
}
r36_vim() {
	return
}



; Bottom Row
;-------------------------------------------------

l41_vim() {
	return
}
l42_vim() {
	ExitVimMode()
	BasicVimKey("Pa", "^v")
	return
}
l43_vim() {
	SelectLineIfDoubleTap()
	ActionVimKey("cut and insert", "c", "^x", true)
	return
}
l44_vim() {
	SelectLineIfDoubleTap()
	ActionVimKey("delete and insert", """zc", "{Backspace}", true)
	return
}
l45_vim() {
	ExitVimMode()
	BasicVimKey("pa", "^v")
	return
}
l46_vim() {
	BasicVimKey("N", "")
	return
}


r41_vim() {
	BasicVimKey("n", "")
	return
}
r42_vim() {
	MovementVimKey("before", "ge", "{Right}^{Left}{Left 2}", "+{Right}^+{Left}+{Left 2}", "{Right}^+{Left}+{Left 2}")
	return
}
r43_vim() {
	MovementVimKey("after", "e", "{Right 2}^{Right}{Left 2}", "+{Right 2}^+{Right}", "+{Right 2}^+{Right}")
	return
}
r44_vim() {
	MovementVimKey("before", "b", "^{Left}", "^+{Left}", "{Right}^+{Left}")
	return
}
r45_vim() {
	MovementVimKey("after", "w", "^{Right}", "^+{Right}", "^+{Right}")
	return
}
r46_vim() {
	return
}



; Extra Row
;-------------------------------------------------

l52_vim() {
	return
}
l53_vim() {
	return
}
l54_vim() {
	return
}
l55_vim() {
	return
}


r52_vim() {
	return
}
r53_vim() {
	return
}
r54_vim() {
	return
}
r55_vim() {
	return
}



; Thumbs
;-------------------------------------------------

lt1_vim() {
	ExitVimMode()
	BasicVimKey("a", "{Right}")
	return
}
lt2_vim() {
	ExitVimMode()
	BasicVimKey("i", "")
	return
}
lt3_vim() {
	BasicVimKey("s", "{Del}")
	visualMode := ""
	IniWrite, %visualMode%, Status.ini, statusVars, visualMode
	ExitVimMode()
	return
}
lt4_vim() {
	return
}
lt5_vim() {
	return
}
lt6_vim() {
	return
}


rt1_vim() {
	return
}
rt2_vim() {
	return
}
rt3_vim() {
	return
}
rt4_vim() {
	return
}
rt5_vim() {
	return
}
rt6_vim() {
	return
}