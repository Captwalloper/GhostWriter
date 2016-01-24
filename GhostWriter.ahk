; Config
numParams := %0%
;testFilename := "C:\Users\comcc_000\Desktop\Games\AutoHotkey\Test.txt"
charDelay := 100
count := %0%
mode := "error"
content := "error"
target := "error"
tenthPercentChanceForMistake := 20 ;0.5%

	; Params
if (count = 0) {
	MsgBox, No params!
	ExitApp
}

index := 1
while ( CharAt(%index%, 1) = "-" ) {
	if (%index% = "-fast") {
		charDelay := 1
	}
	index := index + 1
}

mode := %index%
index := index + 1
content := %index%
index := index + 1
if (mode = "ff" || mode = "tf" || mode = "rc") {
	target := %index%
	index := index + 1
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
	Append(target, content)
}
else if (mode = "rc") {
	RunConcurrently(content, target, 4)
}
else {
	MsgBox, Mode (1st param) must be: t, f, tf, ff, or rc!
}
SendSignal()

ExitApp


; Keys

	
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
	;SendSignal()
}

WriteChar(char) 
{
	global charDelay

	SendInput, %char%
	sleep, %charDelay%
}

WriteCharMistake(char) 
{
	mistake := TenthChancePercent()
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

Append(filename, content)
{
	Run, %filename%
	Sleep, 500
	BeginNewlineAtEOF()
	WriteLine(content)
}

CharAt(string, pos) 
{
	return SubStr(string, pos, 1)
}

LoadText(filename) 
{
	newline := "`n" ;"`r`n"
	text := ""
	Loop, read, %filename%
	{
		LineNumber = %A_Index%
		;MsgBox, LineNumber: %LineNumber%
		Loop, parse, A_LoopReadLine, TXT
		{
			;MsgBox, Text: %A_LoopReadLine%
			text := % text . newline . A_LoopReadLine
			;MsgBox, Text: %text%
		}
	}
	return text
}

Flash()
{
	WriteChar(".")
	sleep, 500
	Delete(1)
	sleep, 500
}

TenthChancePercent()
{
	global percentChanceForMistake
	
	rand := -1
	Random, rand, 0, 1000
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
	;Send, {Enter}
	;Sleep, 50
}

SendSignal()
{
	signalValue := "done"
	filename := "C:\Users\comcc_000\Documents\GitHub\GhostWriter\infoPass.ini"
	IniWrite, %signalValue%, %filename%, section1, key
}

RunConcurrently(Line1, Line2, Multiple)
{
	L1index := 1
	L2index := 1
	L1inc := 1
	L2inc := L1inc * Multiple
	
	while( LineEnded(Line1, L1index, L1inc) <> true || LineEnded(Line2, L2index, L2inc) <> true) {
		L1sub := SubStr(Line1, L1index, L1inc)
		L1index := L1index + L1inc
		L2sub := SubStr(Line2, L2index, L2inc)
		L2index := L2index + L2inc
		
		WriteLine(L1sub)
		If (L1index = L1inc + 1) {
			Send, {Enter}
			sleep, 100
			;Send, {Enter}
			;sleep, 100
		} else if ( LineEnded(Line1, L1index, L1inc) <> true || LineEnded(Line2, L2index, L2inc) <> true ) {
			GoFromL1EndToL2End()
		} 
		WriteLine(L2sub)
		if ( LineEnded(Line1, L1index, L1inc) <> true || LineEnded(Line2, L2index, L2inc) <> true ) {
			GoFromL2EndToL1End()
		}
	}
	
	GoFromL1EndToL2End() ;move cursor to EOF
}

GoFromL1EndToL2End()
{
	Send, {Down}
	;sleep, 1
	;Send, {Down}
	;sleep, 1
	Send, {End}
	;sleep, 1
}

GoFromL2EndToL1End()
{
	Send, {Up}
	;sleep, 1
	;Send, {Up}
	;sleep, 1
	Send, {End}
	;sleep, 1
}

LineEnded(line, index, inc) 
{
	lineEnded := index >= StrLen(line) + inc
	if (lineEnded) {
		;msgbox, LineEnded!
	}
	return lineEnded
}
