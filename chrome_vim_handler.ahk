#NoEnv
SendMode Input
#SingleInstance force
SetWorkingDir %A_ScriptDir%

#Include <functions>
#Include <layers/vim>

while True
{
	WinWaitActive, ahk_exe chrome.exe
	IniRead, autoSpacedChrome, Status.ini, statusVars, autoSpacedChrome
	if(!autoSpacedChrome)
	{
		ExitVimMode()
	}
}