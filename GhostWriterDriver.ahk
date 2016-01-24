; Config
simpleDemoFilename := "Demo.txt"
;demoFilename := % "C:\Users\comcc_000\Documents\GitHub\GhostWriter\" . simpleDemoFilename
ghostWriterFilename := "GhostWriter.ahk"
continue := false
commandPromptTitle := "C:\WINDOWS\system32\cmd.exe"

ClearSignal()

; Main 

OpenNotepad(simpleDemoFilename)
DeleteAll()
SendInput, Hello, I'm GhostWriter...
WaitForContinue()

PasteLine("`nCopy-pasting is great for scripting.")
Sleep, 4000
PasteLine("It's simple, fast, and efficient. However...")
Sleep, 4000
RunInBackground("t", "Typing 1 character at a time is cooler.", "")
WaitForContinue()
Sleep, 3000

RunInForeground("t", "Using a simple command-line interface, I can output a line of text...", "")
WaitForContinue()
Sleep, 3000
RunInForeground("f", "SimpleFileExample.txt", "")
WaitForContinue()
Sleep, 3000

OpenNotepad(simpleDemoFilename)
RunInBackground("-fast rc", "`nWatch me slowly write this top line.", "Until you notice how relatively fast this line is typed. Zoooooooooooooooooooooooooooooooooooooooooom")
WaitForContinue()
Sleep, 3000

RunInBackground("t", "`nSo why use GhostWriter? Because I make scripts look cool.", "")
WaitForContinue()
Sleep, 3000
RunInBackground("t", "`nGoodbye.", "")
WaitForContinue()
Sleep, 3000



ExitApp

; Keys
^down::
	continue := true
return

^t::
	WinGetTitle, Title, A
	MsgBox, The active window is "%Title%".
return

	
; Functions
OpenNotepad(filename) 
{
	title := "Demo - Notepad"
	;msgbox, Title: %title%
	IfWinExist, %title%
		WinActivate ; use the window found above
	else
		Run, %filename%
		
	sleep, 1000
}

DeleteAll()
{
	Send, ^a
	sleep, 250
	Send, {Backspace}
	sleep, 100
}

WaitForContinue()
{
	global continue
	
	while(continue <> true && ReceivedSignal() <> true) {
		sleep, 100
	}
	continue := false
}

RunInBackground(mode, content, target) 
{
	global ghostWriterFilename

	line := % """" . A_AhkPath . """ " . ghostWriterFilename . " " . mode . " " . """" . content . """" . " """ . target . """"
	run, %line%
}

RunInForeground(mode, content, target)
{
	global ghostWriterFilename

	OpenCommandPrompt()
	sleep, 1000
	line := % """" . A_AhkPath . """ " . ghostWriterFilename . " " . mode . " " . """" . content . """" . " """ . target . """"
	RunOnCommandLine(line)
	Sleep, 500
}

OpenCommandPrompt() {
	global commandPromptTitle

	IfWinExist, %commandPromptTitle%
		WinActivate ; use the window found above
	else
		run %comspec% 

	sleep, 1000
	RunOnCommandLine("")
}

RunOnCommandLine(line) {
	SendInput, %line%
	sleep, 250
	Send, {enter} 
	sleep, 100
}

PasteLine(line)
{
	SendInput, %line%
	sleep, 100
	SendInput, `n
	sleep, 100
}

ReceivedSignal()
{
	filename := "C:\Users\comcc_000\Documents\GitHub\GhostWriter\infoPass.ini"
	defaultValue := "waiting"
	continueValue := "done"
	signalReceived = defaultValue
	IniRead, signalReceived, %filename%, section1, key
	if (signalReceived = continueValue) {
		;MsgBox, Signal!
		ClearSignal()
		return true
	}
	return false
}

ClearSignal()
{
	signalValue := "waiting"
	filename := "C:\Users\comcc_000\Documents\GitHub\GhostWriter\infoPass.ini"
	IniWrite, %signalValue%, %filename%, section1, key
}

