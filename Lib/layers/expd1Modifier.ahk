; Number Row
;-------------------------------------------------

l11_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l12_expd1Modifier() {
	EnterVimMode()
	FocusWindow("layered", "farLeft")
	return
}
l13_expd1Modifier() {
	EnterVimMode()
	FocusWindow("layered", "midLeft")
	return
}
l14_expd1Modifier() {
	EnterVimMode()
	FocusWindow("layered", "midRight")
	return
}
l15_expd1Modifier() {
	EnterVimMode()
	FocusWindow("layered", "farRight")
	return
}
l16_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r11_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r12_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r13_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r14_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r15_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}

CloseVirtualDesktopWindows()
{
	; Do for all 17 virtual desktops after the first
	Loop, 17
	{
		; Go to the virtual desktop
		DllCall(GoToDesktopNumberProc, UInt, 1)
		Sleep, 500
		
		; Close all the windows on the virtual desktop
		WinGet, id, list, , , Program Manager
		
		Loop, %id%
		{
			StringTrimRight, wid, id%A_Index%, 0
			WinGetTitle, title, ahk_id %wid%
			StringTrimRight, title, title, 0

			; don't add windows not in current virtual desktop
			isOnDesktop := DllCall(IsWindowOnCurrentVirtualDesktopProc, UInt, wid, UInt)
			if (!isOnDesktop)
				continue
				
			; FIXME: windows with empty titles?
			if title =
				continue

			WinClose, ahk_id %wid%
		}
	
		; Close the virtual desktop
		SendInput ^#{F4}
	}
}

r16_expd1Modifier() {
	CloseVirtualDesktopWindows()
	; Exit everything keyboard related but KP and iswitchw
	ExitAllAHK()
	Run C:\Users\steve\Desktop\Projects\personal-keyboard-config\iswitchw.ahk
	ExitApp
}



; Top Row
;-------------------------------------------------

l21_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l22_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l23_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l24_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l25_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l26_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r21_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r22_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r23_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r24_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r25_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r26_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Home Row
;-------------------------------------------------

l31_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l32_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l33_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l34_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l35_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l36_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r31_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r32_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r33_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r34_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r35_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r36_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Bottom Row
;-------------------------------------------------

l41_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l42_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l43_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l44_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l45_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l46_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r41_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r42_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r43_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r44_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r45_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r46_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Extra Row
;-------------------------------------------------

l52_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l53_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l54_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
l55_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


r52_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r53_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r54_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
r55_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}



; Thumbs
;-------------------------------------------------

lt1_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt2_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt3_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt4_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt5_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
lt6_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}


rt1_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt2_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt3_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt4_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt5_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
rt6_expd1Modifier() {
	expd1Modifier_keys := [""]
	return expd1Modifier_keys
}
