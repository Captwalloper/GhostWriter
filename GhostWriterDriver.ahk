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
RunInBackground("t", "Typing 1 character at a time is cooler.")
WaitForContinue()
Sleep, 3000

RunInForeground("t", "Using a simple command-line interface, I can output a line of text...")
WaitForContinue()
Sleep, 3000
RunInForeground("f", "SimpleFileExample.txt")
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

RunInBackground(mode, content) 
{
	global ghostWriterFilename

	line := % """" . A_AhkPath . """ " . ghostWriterFilename . " " . mode . " " . """" . content . """"
	run, %line%
}

RunInForeground(mode, content)
{
	global ghostWriterFilename

	OpenCommandPrompt()
	sleep, 1000
	line := % """" . A_AhkPath . """ " . ghostWriterFilename . " " . mode . " " . """" . content . """"
	RunOnCommandLine(line)
	Sleep, 500
}

RunConcurrently(Line1, Line2, Multiple)
{
	L1index := 0
	L2index := 0
	L1inc := 1
	L2inc := L1inc * Multiple
	
	while( LineEnded(Line1, L1index) <> true || LineEnded(Line2, L2index) <> true) {
		L1sub := SubStr(Line1, L1index, L1inc)
		L1index := L1index + L1inc
		L2sub := SubStr(Line2, L2index, L2inc)
		L2index := L2index + L2inc
		
		
	}
}

WriteLine1(line) 
{
	
}

LineEnded(line, index) 
{
	return index >= StrLen(line) 
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

Delete(numDeletes)
{
	Loop, %numDeletes%
		send, {Backspace}
		sleep, 100
}

WriteChar(char) 
{
	SendInput, %char%
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

