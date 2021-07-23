WinGetActiveTitle, ExplorerTitle

IME_CHECK(WinTitle)
	{
	WinGet,hWnd,ID,%WinTitle%
	Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
	}

Send_ImeControl(DefaultIMEWnd, wParam, lParam)
	{
	DetectSave := A_DetectHiddenWindows 
	DetectHiddenWindows,ON 
	SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
	if (DetectSave <> A_DetectHiddenWindows)
	DetectHiddenWindows,%DetectSave%
	return ErrorLevel
	}

ImmGetDefaultIMEWnd(hWnd) 
	{
	return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
	}

Set_English_mode()
	{
		ime_status := % IME_CHECK("A")
		if (ime_status = "0") {
		} else {
		Send, {vk15}
		}
	Return
	}

::->>::→ ; ->> 입력시 →로 변환
::<<-::← ; <<- 입력시 ←로 변환
::<->::↔ ; <-> 입력시 ↔로 변환

; AutoHotKey를 이용해서 Capslock+WASD키를 방향키로 쓰기
; https://chooi9522.tistory.com/43

SetCapsLockState, AlwaysOff

; CapsLock & h:: Send, {Left}
; CapsLock & l:: Send, {Right}
; CapsLock & k:: Send, {Up}
; CapsLock & j:: Send, {Down}
; CapsLock & a:: Send, {Home}
; CapsLock & e:: Send, {End}

; Shift + CapsLock + key 조합
; https://autohotkey.com/board/topic/90024-capslock-shift-letter-key-combo-assignment/
CapsLock & h:: Send, % GetKeyState("Shift", "P") ? "+{Left}" : "{Left}"
CapsLock & l:: Send, % GetKeyState("Shift", "P") ? "+{Right}" : "{Right}"
CapsLock & k:: Send, % GetKeyState("Shift", "P") ? "+{Up}" : "{Up}"
CapsLock & j:: Send, % GetKeyState("Shift", "P") ? "+{Down}" : "{Down}"
CapsLock & a:: Send, % GetKeyState("Shift", "P") ? "+{Home}" : "{Home}"
CapsLock & e:: Send, % GetKeyState("Shift", "P") ? "+{End}" : "{End}"
CapsLock & d:: Send, {Delete}

+F1::
	ime_status := % IME_CHECK("A")
	if (ime_status = "0") {
	} else {
	Send, {vk15}
	}

	send, niconicon
	send, {Enter}
	sleep, 150
	send, Zhfhsk@2021
	sleep, 150
	send, {Enter}

	return

+F2::
	ime_status := % IME_CHECK("A")
	if (ime_status = "0") {
	} else {
	Send, {vk15}
	}

	send, rhgoelqjrld
	send, {Enter}
	sleep, 150
	send, ghkdrmaenRjql
	sleep, 150
	send, {Enter}

	return

+F3::
	ime_status := % IME_CHECK("A")
	if (ime_status = "0") {
	} else {
	Send, {vk15}
	}
	
	send, tnenahem
	send, {Enter}
	sleep, 150
	send, ghkdrmathddkwl
	sleep, 150
	send, {Enter}
	
	return

send_str_with_control_char(str, delimeter) {
	splited_str := StrSplit(str, delimeter)
	splited_str_len = % splited_str.Length()

	if (splited_str_len == 1) {
		sendraw % splited_str[1]
		sleep, 150
	} else {
		loop % splited_str_len {
			sendraw % splited_str[A_Index]
			sleep, 150
			; MsgBox, "\t", %A_Index%
			if (A_Index != splited_str_len) {
				send_control_char(delimeter)
				sleep, 150
			}
		}
	}
	return
}

send_control_char(str) {
	if (str == "\t") {
		send {Tab}
	} else if(str == "\n") {
		send {Enter}
	}
	return
}

Type_strings(str)
{
	; 키보드 입력이 한글일 경우 영어로 변환
	Set_English_mode()
	
	splited_str := StrSplit(str, "\n")
	splited_str_len := splited_str.Length()
	
	if (splited_str_len == 1) {
		send_str_with_control_char(splited_str1[1], "\t")
	} else {
		loop % splited_str_len {
			send_str_with_control_char(splited_str[A_Index], "\t")
			if (A_Index != splited_str_len) {
				send {Enter}
				sleep, 150
			}
		}
	}
	return
}

Show_Munu_box()
{
	Menu, MyMainMenu, Add, &Open Folder, MenuHandler
	Menu, MySubMenu1, Add, &1. Desktop Folder, SubMenu1Label
	Menu, MySubMenu1, Add, &2. Downloads Folder, SubMenu1Label
	Menu, MyMainMenu, Add, &Open Folder, :MySubMenu1

	Menu, MyMainMenu, Add, &Run Program, MenuHandler
	Menu, MySubMenu2, Add, &1. Calculator, SubMenu2Label
	Menu, MySubMenu2, Add, &2. Chrome, SubMenu2Label
	Menu, MyMainMenu, Add, &Run Program, :MySubMenu2

	Menu, MyMainMenu, Add, &Command, MenuHandler
	Menu, MySubMenu3, Add, &1. login(WEB), SubMenu3Label
	Menu, MySubMenu3, Add, &2. Debug#1, SubMenu3Label
	Menu, MySubMenu3, Add, &3. Debug#2, SubMenu3Label
	Menu, MySubMenu3, Add, &4. login(shell), SubMenu3Label
	Menu, MyMainMenu, Add, &Command, :MySubMenu3

	Menu, MyMainMenu, Add ; adds a separator line

	Menu, MyMainMenu, Add, &Turn Monitor Off, MainMenuLabel
	Menu, MyMainMenu, Add, &Mute/Unmute Volume, MainMenuLabel
	Menu, MyMainMenu, Show

	; 지속적으로 Separation line이 생기는 현상 제거
	; Shift 나 Alt 를 누르면 Separation line 이 계속 추가 됨
	; https://autohotkey.com/board/topic/78753-separation-line-repeats-after-gosub-menu-creation/
	Menu, MyMainMenu, DeleteAll ; 
	
	MenuHandler:
	return
	
	SubMenu1Label:
	If (A_ThisMenuItemPos = 1) {
		Run, %A_desktop%
	} else if (A_ThisMenuItemPos = 2) {
		Run, %USERPROFILE%\Downloads
	}
	return

	SubMenu2Label:
	If (A_ThisMenuItemPos = 1) {
		Run, Calc.exe
	} else if (A_ThisMenuItemPos = 2) {
		Run, Chrome.exe
	}
	return
	
	SubMenu3Label:
	If (A_ThisMenuItemPos = 1) {
		Type_strings("niconicon\tZhfhsk!2021\n")
	} else if (A_ThisMenuItemPos = 2) {
		Type_strings("rhgoelqjrld\nghkdrmaenRjql\n")
	} else if (A_ThisMenuItemPos = 3) {
		Type_strings("tnenahem\nghkdrmathddkwl\n")
	} else if (A_ThisMenuItemPos = 4) {
		Type_strings("niconicon\nZhfhsk!2021\n")
	}
	return

	MainMenuLabel:
	If (A_ThisMenuItemPos = 3) {
		SendMessage, 0x112, 0xF170, 2,, Program Manager
	} else if (A_ThisMenuItemPos = 4) {
		Send, {Volume_Mute}
	}
	return
}

+F4::
	WinGetActiveTitle, current_window
	Gui, Add, Text, x0 y10, Type_TEST#1 [Press "1" key]
	Gui, Add, Button, x200 y7 w70 h20 gMyLabel1, Button#1
	Gui, Add, Text, x0 y35, Type_TEST#2 [Press "2" key]
	Gui, Add, Button, x200 y32 w70 h20 gMyLabel1, Button#2
	Gui, Add, Text, x0 y60, Type_TEST#3 [Press "3" key]
	Gui, Add, Button, x200 y57 w70 h20 gMyLabel1, Button#2
	; Gui, Add, Button, x5 y5 w210 h30 gButtonLabel, Button
	
	Gui, Show, x0 y0 w300 h400, TEST
	WinGetActiveTitle, gui_window

	WinActivate, % current_window
	Loop, 3
	{
		Hotkey, %A_index%, MyLabel1
		Hotkey, %A_index%, On
	}
	; Hotkey, 1, MyLabel1
	; Hotkey, 1, On
	return
	
	MyLabel1:
	; MsgBox You pressed %A_ThisHotkey%(MyLabel1).
	WinClose % gui_window
	; Hotkey, 1, Toggle
		Loop, 3
	{
		Hotkey, %A_index%, Toggle
	}
	return

+RButton Up::
	Show_Munu_box()
	return

+F5::
	Show_Munu_box()
	return

+F6::
	FileRead, read_var, command.list
	; MsgBox, %read_var%
	lOOP, Parse, read_var, `n
		MsgBox, %A_LoopField%
Return

; 날짜 관련 Hotkey
^;::
	FormatTime, currentDate,, yyyyMMdd
	send, % currentDate

	return

^+;::
	FormatTime, currentDate,, yyyy-MM-dd(ddd)
	send, % currentDate

	return