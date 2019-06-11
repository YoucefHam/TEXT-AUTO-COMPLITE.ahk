
Gui, +AlwaysOnTop +LastFound
Gui, Add, Edit, x5 w150 vgg gAutoComplete,
Gui, Add, Edit, x5 vName gAutoComplete,
Gui, Add, Button, x5 w80, Ok
Gui, Show,, fuck you
gosub, AutoComplete_Begin

return
GuiClose:
ExitApp
return


;////////////////////// Auto Complete Text Window By YocuefHam +++++++++++++++++++++++++++
AutoComplete_Begin:
{



List := "and|break|do|else|elseif|end|false|for|function|goto|if|in|local|nil|not|or|repeat|return|then|true|until|while_ENV|_G|_VERSION|assert|collectgarbage|dofile|error|getfenv|getmetatable|ipairs|load|loadfile|loadstring|module|next|pairs|pcall|print|rawequal|rawget|rawlen|rawset|require|select|setfenv|setmetatable|tonumber|tostring|type|unpack|xpcall|string|table|math|bit32|coroutine|io|os|debug|package|__index|__newindex|__call|__add|__sub|__mul|__div|__mod|__pow|__unm|__concat|__len|__eq|__lt|__le|__gc|__modebyte|char|dump|find|format|gmatch|gsub|len|lower|match|rep|reverse|sub|upper|abs|acos|asin|atan|atan2|ceil|cos|cosh|deg|exp|floor|fmod|frexp|ldexp|log|log10|max|min|modf|pow|rad|random|randomseed|sin|sinh|sqrt|tan|tanh|arshift|band|bnot|bor|btest|bxor|extract|lrotate|lshift|replace|rrotate|rshift|shift|string.byte|string.char|string.dump|string.find|string.format|string.gmatch|string.gsub|string.len|string.lower|string.match|string.rep|string.reverse|string.sub|string.upper|table.concat|table.insert|table.maxn|table.pack|table.remove|table.sort|table.unpack|math.abs|math.acos|math.asin|math.atan|math.atan2|math.ceil|math.cos|math.cosh|math.deg|math.exp|math.floor|math.fmod|math.frexp|math.huge|math.ldexp|math.log|math.log10|math.max|math.min|math.modf|math.pi|math.pow|math.rad|math.random|math.randomseed|math.sin|math.sinh|math.sqrt|math.tan|math.tanh|bit32.arshift|bit32.band|bit32.bnot|bit32.bor|bit32.btest|bit32.bxor|bit32.extract|bit32.lrotate|bit32.lshift|bit32.replace|bit32.rrotate|bit32.rshift|close|flush|lines|read|seek|setvbuf|write|clock|date|difftime|execute|exit|getenv|remove|rename|setlocale|time|tmpname|coroutine.create|coroutine.resume|coroutine.running|coroutine.status|coroutine.wrap|coroutine.yield|io.close|io.flush|io.input|io.lines|io.open|io.output|io.popen|io.read|io.tmpfile|io.type|io.write|io.stderr|io.stdin|io.stdout|os.clock|os.date|os.difftime|os.execute|os.exit|os.getenv|os.remove|os.rename|os.setlocale|os.time|os.tmpname|debug.debug|debug.getfenv|debug.gethook|debug.getinfo|debug.getlocal|debug.getmetatable|debug.getregistry|debug.getupvalue|debug.getuservalue|debug.setfenv|debug.sethook|debug.setlocal|debug.setmetatable|debug.setupvalue|debug.setuservalue|debug.traceback|debug.upvalueid|debug.upvaluejoin|package.cpath|package.loaded|package.loaders|package.loadlib|package.path|package.preload|package.seeall"



SetKeyDelay, -1
IsAutoComplete = 0
Gui, AutoComplete: +LabelAC +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, AutoComplete:Color, 0x00ff00
WinSet, TransColor, 0x00ff00
Gui, AutoComplete:Add, ListBox, x0 y0 vACList gACListClick r6 +Sort +0x100, %list%

}
;////////////////////// Auto Complete Text Window By YocuefHam ///////////////////////////


;////////////////////// Auto Complete Text Window By YocuefHam +++++++++++++++++++++++++++
{
#if IsAutoComplete and WinActive(ActiveControlWindow)

*$WheelDown::
*$Down::
ACListCount = 0
Loop, Parse, % ACNewList, |
	if !(A_LoopField = "")
		ACListCount++
if (AutoCompleteSelected >= 1) and (AutoCompleteSelected < ACListCount)
{
	AutoCompleteSelected++
	if (AutoCompleteSelected <= ACListCount) and !(AutoCompleteSelected = 0)
		GuiControl, AutoComplete:Choose, ACList, % AutoCompleteSelected
}
return

*$WheelUp::
*$Up::
ACListCount = 0
Loop, Parse, % ACNewList, |
	if !(A_LoopField = "")
		ACListCount++
if (AutoCompleteSelected > 1)
{
	AutoCompleteSelected--
	if (AutoCompleteSelected <= ACListCount) and !(AutoCompleteSelected = 0)
		GuiControl, AutoComplete:Choose, ACList, % AutoCompleteSelected
}
return

*$Space::
*$NumpadEnter::
*$Enter::
*$Tab::
IsAutoComplete = 0
AutoCompleteListClicked = 1
GuiControlGet, ACListSelected, AutoComplete:, ACList
Gui, AutoComplete:Hide
ControlSetText, % ActiveControl,  % ACListSelected, % ActiveControlWindow
ControlSend, % ActiveControl, % "{Right " StrLen(ACListSelected) "}", % ActiveControlWindow
if ACTOP
	WinSet, AlwaysOnTop, On, % ActiveControlWindow
return

*~LButton::
MouseGetPos,,, WIN
WinGetTitle, Wint, ahk_id %WIN%
if Wint = AutoCompleteWindow
	return
else if Wint = % ActiveControlWindow
	gosub, LButtonCont
Gui, AutoComplete:Hide
IsAutoComplete = 0
LButtonCont:
if ACTOP
	WinSet, AlwaysOnTop, On, % ActiveControlWindow
return

#if
}
;////////////////////// Auto Complete Text Window By YocuefHam ///////////////////////////

;////////////////////// Auto Complete Text Window By YocuefHam +++++++++++++++++++++++++++
AutoComplete:
Gui, +LastFound
Gui, submit, nohide
if AutoCompleteListClicked
{
	AutoCompleteListClicked := 0
	if ACTOP
		WinSet, AlwaysOnTop, On, % ActiveControlWindow
	return
}
LastGuiControl := A_GuiControl
loop, parse, % list, |
	IfInString, A_LoopField, % %LastGuiControl%
		NewAutoCompleteList .= A_LoopField . "|"
if NewAutoCompleteList =
{
	Gui, AutoComplete:Hide
	IsAutoComplete = 0
	if ACTOP
		WinSet, AlwaysOnTop, On, % ActiveControlWindow
	return
}
GuiControl, AutoComplete:, ACList, |
GuiControl, AutoComplete:, ACList, |%NewAutoCompleteList%
ACNewList := NewAutoCompleteList
ControlGetFocus, ActiveControl
WinGetTitle, ActiveControlWindow, A
ControlGetPos, cx, cy, cw, ch, % ActiveControl
WinGetPos, wx, wy
GuiControlGet, Pos, AutoComplete:Pos, ACList
WinGet, ExStyle, ExStyle
if (ExStyle & 0x8)
	ACTOP = 1
else
	ACTOP = 0
if ACTOP
	WinSet, AlwaysOnTop, Off, % ActiveControlWindow
Gui, AutoComplete:show, % "x" wx + cx " y" wy + cy + ch " w" cw " h" PosH " NoActivate", AutoCompleteWindow
WinSet, Trans, 210, AutoCompleteWindow
GuiControl, AutoComplete:Move, ACList, % "x0 y0 w" cw
GuiControl, AutoComplete:Choose, ACList, 1
IsAutoComplete = 1
AutoCompleteSelected = 1
NewAutoCompleteList :=
return
ACListClick:
IsAutoComplete = 0
AutoCompleteListClicked = 1
GuiControlGet, ACListSelected, AutoComplete:, ACList
Gui, AutoComplete:Hide
ControlSetText, % ActiveControl,  % ACListSelected, % ActiveControlWindow
ControlSend, % ActiveControl, % "{Right " StrLen(ACListSelected) "}", % ActiveControlWindow
if ACTOP
	WinSet, AlwaysOnTop, On, % ActiveControlWindow
return
ACEscape:
GuiEscape:
Gui, AutoComplete:Hide
IsAutoComplete = 0
if ACTOP
	WinSet, AlwaysOnTop, On, % ActiveControlWindow
return
;////////////////////// Auto Complete Text Window By YocuefHam ///////////////////////////



