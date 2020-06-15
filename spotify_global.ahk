; SpotifyGlobalKeys.ahk:
; AutoHotkey script to control Spotify with global keyboard shortcuts
; Author: James Teh <jamie@jantrid.net>
; Copyright 2017-2018 James Teh
; License: GNU General Public License version 2.0

DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	; We need the app's third top level window, so get next twice.
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	spotifyHwnd := getSpotifyHwnd()
	; Chromium ignores keys when it isn't focused.
	; Focus the document window without bringing the app to the foreground.
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

; Win+alt+p: Play/Pause
^Numpad5::
{
	spotifyKey("{Space}")
	Return
}

; Win+alt+down: Next
^Numpad6::
{
	spotifyKey("^{Right}")
	Return
}

; Win+alt+up: Previous
^Numpad4::
{
	spotifyKey("^{Left}")
	Return
}

; shift+volumeUp: Volume up
^Numpad8::
{
	spotifyKey("^{Up}")
	Return
}

; shift+volumeDown: Volume down
^Numpad2::
{
	spotifyKey("^{Down}")
	Return
}

; Win+alt+o: Show Spotify
;^Numpad4::
;{
;	spotifyHwnd := getSpotifyHwnd()
;	WinGet, style, Style, ahk_id %spotifyHwnd%
;	if (style & 0x10000000) { ; WS_VISIBLE
;		WinHide, ahk_id %spotifyHwnd%
;	} Else {
;		WinShow, ahk_id %spotifyHwnd%
;		WinActivate, ahk_id %spotifyHwnd%
;	}
;	Return
;}