; Config
numParams := %0%
testFilename := "C:\Users\comcc_000\Desktop\Games\AutoHotkey\Test.txt"
charDelay := 100
count := %0%
mode := "error"
content := "error"
target := "error"
percentChanceForMistake := 2

	; Params
if (count = 0) {
	MsgBox, No params!
	ExitApp
}

mode = %1%
content = %2%
if (mode = "ff" || mode = "tf") {
	target = %3%
}

; Main 
if (mode = "t") {
	WriteLine(content)
} 
else if (mode = "f") {
	text := LoadText(content)
	WriteLine(text)
}
else if (mode = "tf") {
	Run, %testFilename%
	Sleep, 500
	BeginNewlineAtEOF()
	WriteLine(content)
}
else if (mode = "ff") {

}
else {
	MsgBox, Mode (1st param) must be: t, f, tf, or ff!
}

ExitApp


; Keys
^l::
	WriteLine("hallelujah ajf;lksajfkl;sdajf;lksjaf;lksjaf;jad")
return

	
; Functions
WriteLine(line) 
{
	i := 1
	length := StrLen(line) 
	char := a ;type char to string(closest thing to char)
	while (i <= length) {
		char := CharAt(line, i)
		;MsgBox, Char: %char%
		WriteCharMistake(char)
		i := i + 1
	}
}

WriteChar(char) 
{
	global charDelay

	SendInput, %char%
	sleep, %charDelay%
}

WriteCharMistake(char) 
{
	mistake := ChancePercent()
	if (mistake) {
		Mistake()
	}
	WriteChar(char)
}

Mistake()
{
	mistake := "SHFTW"
	WriteLine(mistake)
	length := StrLen(mistake)
	Delete(length)
}

Delete(numDeletes)
{
	Loop, %numDeletes%
		send, {Backspace}
		sleep, 100
}

CharAt(string, pos) 
{
	return SubStr(string, pos, 1)
}

LoadText(filename) 
{
	text := ""
	Loop, read, %filename%
	{
		LineNumber = %A_Index%
		;MsgBox, LineNumber: %LineNumber%
		Loop, parse, A_LoopReadLine, TXT
		{
			;MsgBox, Text: %A_LoopReadLine%
			text := % text . "`r`n" . A_LoopReadLine
			;MsgBox, Text: %text%
		}
	}
	return text
}

ChancePercent()
{
	global percentChanceForMistake
	
	rand := -1
	Random, rand, 0, 100
	if (rand < percentChanceForMistake) {
		return true
	}
	return false
}

BeginNewlineAtEOF() 
{
	Send, ^+{End}
	Sleep, 50
	Send, {Right}
	Sleep, 50
	Send, {Enter}
	Sleep, 50
}
