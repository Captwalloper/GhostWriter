; Config
numParams := %0%
testFilename := "C:\Users\comcc_000\Desktop\Games\AutoHotkey\Test.txt"
charDelay := 100

; Main 
CheckParams(numParams)
text = %1%
;msgbox, % "Text: " text

text := LoadText(text)
WriteLine(text)

ExitApp

; Keys

^c::
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
		WriteChar(char)
		i := i + 1
	}
}

WriteChar(char) 
{
	global charDelay

	SendInput, %char%
	sleep, %charDelay%
}

CharAt(string, pos) 
{
	return SubStr(string, pos, 1)
}

CheckParams(numParams) 
{
	if (numParams = 0) {
		MsgBox, No params!
		ExitApp
	}
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
