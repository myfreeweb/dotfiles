; Turn off the monitor: http://greasypc.blogspot.ru/2008/03/autohotkey-script-to-put-monitor-on.html
; 0x112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
#m::
    SendMessage, 0x112, 0xF170, 2,, Program Manager
    return

; Shifts as parens: https://autohotkey.com/board/topic/98742-remapping-shift-key/
; thanks @sigfig for the | idea :D
#IfWinNotActive ahk_exe VirtualBox.exe


~LShift::
	KeyWait LShift
	if (A_TimeSinceThisHotkey < 220) {
		if (A_PriorKey = "LShift") {
			Send (
		} else if (A_PriorKey = "RShift") {
			Send |
		}
	}
	return

~RShift::
	KeyWait RShift
	if (A_TimeSinceThisHotkey < 220) {
		if (A_PriorKey = "RShift") {
			Send )
		} else if (A_PriorKey = "LShift") {
			Send |
		}
	}
	return

#IfWinNotActive

; Caps Lock as Control/Escape: https://gist.github.com/sedm0784/4443120

g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false

*CapsLock::
    if (g_ControlRepeatDetected) {
        return
    }

    Send {Ctrl down}
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true

    return

*CapsLock Up::
    SetCapsLockState, AlwaysOff
    Send {Ctrl up}
    g_ControlRepeatDetected := false
    if (g_AbortSendEsc) {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250) {
        SendInput {Esc}
    }
    return

~*^a::
    g_AbortSendEsc := true
    return
~*^b::
    g_AbortSendEsc := true
    return
~*^c::
    g_AbortSendEsc := true
    return
~*^d::
    g_AbortSendEsc := true
    return
~*^e::
    g_AbortSendEsc := true
    return
~*^f::
    g_AbortSendEsc := true
    return
~*^g::
    g_AbortSendEsc := true
    return
~*^h::
    g_AbortSendEsc := true
    return
~*^i::
    g_AbortSendEsc := true
    return
~*^j::
    g_AbortSendEsc := true
    return
~*^k::
    g_AbortSendEsc := true
    return
~*^l::
    g_AbortSendEsc := true
    return
~*^m::
    g_AbortSendEsc := true
    return
~*^n::
    g_AbortSendEsc := true
    return
~*^o::
    g_AbortSendEsc := true
    return
~*^p::
    g_AbortSendEsc := true
    return
~*^q::
    g_AbortSendEsc := true
    return
~*^r::
    g_AbortSendEsc := true
    return
~*^s::
    g_AbortSendEsc := true
    return
~*^t::
    g_AbortSendEsc := true
    return
~*^u::
    g_AbortSendEsc := true
    return
~*^v::
    g_AbortSendEsc := true
    return
~*^w::
    g_AbortSendEsc := true
    return
~*^x::
    g_AbortSendEsc := true
    return
~*^y::
    g_AbortSendEsc := true
    return
~*^z::
    g_AbortSendEsc := true
    return
~*^1::
    g_AbortSendEsc := true
    return
~*^2::
    g_AbortSendEsc := true
    return
~*^3::
    g_AbortSendEsc := true
    return
~*^4::
    g_AbortSendEsc := true
    return
~*^5::
    g_AbortSendEsc := true
    return
~*^6::
    g_AbortSendEsc := true
    return
~*^7::
    g_AbortSendEsc := true
    return
~*^8::
    g_AbortSendEsc := true
    return
~*^9::
    g_AbortSendEsc := true
    return
~*^0::
    g_AbortSendEsc := true
    return
~*^Space::
    g_AbortSendEsc := true
    return
~*^Backspace::
    g_AbortSendEsc := true
    return
~*^Delete::
    g_AbortSendEsc := true
    return
~*^Insert::
    g_AbortSendEsc := true
    return
~*^Home::
    g_AbortSendEsc := true
    return
~*^End::
    g_AbortSendEsc := true
    return
~*^PgUp::
    g_AbortSendEsc := true
    return
~*^PgDn::
    g_AbortSendEsc := true
    return
~*^Tab::
    g_AbortSendEsc := true
    return
~*^Return::
    g_AbortSendEsc := true
    return
~*^,::
    g_AbortSendEsc := true
    return
~*^.::
    g_AbortSendEsc := true
    return
~*^/::
    g_AbortSendEsc := true
    return
~*^;::
    g_AbortSendEsc := true
    return
~*^'::
    g_AbortSendEsc := true
    return
~*^[::
    g_AbortSendEsc := true
    return
~*^]::
    g_AbortSendEsc := true
    return
~*^\::
    g_AbortSendEsc := true
    return
~*^-::
    g_AbortSendEsc := true
    return
~*^=::
    g_AbortSendEsc := true
    return
~*^`::
    g_AbortSendEsc := true
    return
~*^F1::
    g_AbortSendEsc := true
    return
~*^F2::
    g_AbortSendEsc := true
    return
~*^F3::
    g_AbortSendEsc := true
    return
~*^F4::
    g_AbortSendEsc := true
    return
~*^F5::
    g_AbortSendEsc := true
    return
~*^F6::
    g_AbortSendEsc := true
    return
~*^F7::
    g_AbortSendEsc := true
    return
~*^F8::
    g_AbortSendEsc := true
    return
~*^F9::
    g_AbortSendEsc := true
    return
~*^F10::
    g_AbortSendEsc := true
    return
~*^F11::
    g_AbortSendEsc := true
    return
~*^F12::
    g_AbortSendEsc := true
    return
