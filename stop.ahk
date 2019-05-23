ExitAllAHK()
{
	DetectHiddenWindows, % ( ( DHW:=A_DetectHiddenWindows ) + 0 ) . "On"

	WinGet, L, List, ahk_class AutoHotkey

	Loop %L%
		If ( L%A_Index% <> WinExist( A_ScriptFullPath " ahk_class AutoHotkey" ) )
			PostMessage, 0x111, 65405, 0,, % "ahk_id " L%A_Index%

	DetectHiddenWindows, %DHW%
}

Run %ComSpec% /c "taskkill /IM keypirinha-x64.exe /F"
ExitAllAHK()