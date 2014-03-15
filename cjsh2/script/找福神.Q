[General]
SyntaxVersion=2
BeginHotkey=49
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=116
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=c74275b2-6996-416a-b0d0-080aa29c8aab
Description=找福神
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
PutAttachment "I:\Work\anjian\cjsh2\resource" ,"*.*"
PutAttachment ".\Plugin" ,"RegDll.dll"
Call Plugin.RegDll.Reg("I:\Work\anjian\cjsh2\resource\dm.dll")
Set dm = createobject("dm.dmsoft")
dm_ret = dm.SetPath("I:\Work\anjian\cjsh2\resource")
dm_ret = dm.setDict(0,"dm_soft.txt")
TracePrint dm.Ver()

//KeyPress "M", 1
//interval = 500
//Delay interval

//point = dm.Ocr(0, 0, 1440, 900, "fff7c0-000000", 1.0)
//MessageBox point

//dm.FindPic 0, 0, 1440, 900, "当前坐标.bmp", "000000", 0.9, 0, intX, intY
//MoveTo intX, intY

Function getCurrentPoint()
	dm.FindPic 0, 0, 1440, 900, "当前坐标.bmp", "000000", 0.9, 0, intX, intY
	MoveTo intX, intY
	pointValue = getPointValue()
	TracePrint "getCurrentPoint"&":"&pointValue
	getCurrentPoint = pointValue
End Function

Function getPointValue()
	point = dm.Ocr(0, 0, 1440, 900, "fff7c0-000000", 1.0)
	getPointValue = point
End Function

Function getPointOffset(srcPoint,targetPoint)
	src = Split(srcPoint,"y")
	target = Split(targetPoint, "y")
/*	
	If src(0) >= target(0) Then 
		x = src(0) - target(0)
	Else 
	 	x = target(0) - src(0)
	End If
	
	If src(1) >= target(1) Then 
		y = src(1) - target(1)
	Else 
	 	y = target(1) - src(1)
	End If
*/	
	x = target(0) - src(0)
	y = target(01) - src(1)
	getPointOffset = x&"y"&y
End Function

Function moveToTargetPoint()
	currentPointValue = getCurrentPoint()
	targetPoint = "181y192"
	pointOffset = getPointOffset(currentPointValue, targetPoint)
	TracePrint "pointOffset"&":"&pointOffset
	//MessageBox pointOffset
	point = Split(pointOffset,"y")
	MoveR point(0),point(1)
End Function

currentPointValue = getCurrentPoint()
//Delay 5000
//MoveR 10, 1
//currentPointValue = getCurrentPoint()