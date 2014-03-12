[General]
SyntaxVersion=2
BeginHotkey=49
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=50
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d1cb84c3-89af-4b85-b1cc-34fe96302a3d
Description=成吉思汗2
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
/*
PutAttachment "I:\Work\anjian\cjsh2\resource" ,"*.*"
PutAttachment ".\Plugin" ,"RegDll.dll"
Call Plugin.RegDll.Reg("I:\Work\anjian\cjsh2\resource\dm.dll")
Set dm = createobject("dm.dmsoft")
dm_ret = dm.SetPath("I:\Work\anjian\cjsh2\resource")
TracePrint dm.Ver()


KeyPress "Esc", 1

interval = 500

Delay interval
dm.FindPic 0,0,1440,900,"显示设置.bmp","000000",0.9,0,intX,intY
dm.MoveTo intX, intY
LeftClick 1

Delay interval
dm.FindPic 0, 0, 1440, 900, "窗口模式(未选中).bmp", "000000", 0.9, 0, intA, intB

dm.FindPic 0, 0, 1440, 900, "窗口模式.bmp", "000000", 0.9, 0, intX, intY

If intA <> -1
	dm.MoveTo intX - 25, intY
	Delay interval
	LeftClick 1
End If

Delay interval
dm.MoveTo intX + 200, intY
LeftClick 1

Delay interval
dm.FindPic 0, 0, 1440, 900, "1024.bmp", "000000", 0.9, 0, intX, intY
dm.MoveTo intX, intY
LeftClick 1

Delay interval
dm.FindPic 0, 0, 1440, 900, "确定.bmp", "000000", 0.9, 0, intX, intY
dm.MoveTo intX, intY
LeftClick 1
*/


MessageBox Lib.cjsh2_common.add1(1, 2)

call Lib.cjsh2_common.add2(11,22)
