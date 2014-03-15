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
dm_ret = dm.setDict(0,"主页面坐标点字库.txt")
TracePrint dm.Ver()

/*
hwnd = dm.GetMousePointWindow()
TracePrint hwnd
dm_ret = dm.BindWindow(hwnd, "normal", "normal", "normal",0)
dm.FindPic 0,0,1024,768, "地图树.bmp", "000000", 0.9, 0, intX, intY
dm.MoveTo intX, intY
dm_ret = dm.UnBindWindow()

interval = 400
hwnd = dm.GetMousePointWindow()
dm_ret = dm.BindWindow(hwnd, "normal", "normal", "normal",0)
dm.MoveTo 549, 281
LeftClick 1
Delay interval
KeyPress "M",1
Delay interval
dm.MoveTo 927, 107
Delay interval
dm.MoveTo 927-100, 107
Delay interval
While 1 = 1
	getPointValue
Wend
dm_ret = dm.UnBindWindow()
*/

interval = 500
//绑定鼠标所在的窗口
hwnd = dm.GetMousePointWindow()
dm_ret = dm.BindWindow(hwnd, "normal", "normal", "normal", 0)

//在主界面取小地图坐标点得到当前坐标
//D8FBFC-060403为数字4的颜色范围
//E8FDFD-0D0202为数字5的颜色范围
Function getCurrentPoint()
	currentPoint = dm.Ocr(0,0,1024,768,"E4FBFB-0F0404|D8FBFC-060403|E8FDFD-0D0202",1.0)
	TracePrint "getCurrentPoint"&":"&currentPoint
	getCurrentPoint = currentPoint
End Function

//直接去找目标点相对子窗口的坐标位置
Function moveToTargetPoint(offset)
	pointValue = split(offset,",")
	dm.MoveTo pointValue(0), pointValue(1)
	Delay interval
	LeftClick 1
End Function

//切换主页面和地图页面
Function switchPage()
	KeyPress "M", 1
	Delay interval
	switchMapPage = 1
End Function

//因为有时候主页面小地图坐标在人物移动时也不变化（可能是bug）
//所以需要将鼠标移动到小地图上然后移出来来触发坐标的变化
Function enablePointChange()
	dm.MoveTo 927, 107
	Delay interval
	dm.MoveTo 927-100, 107
	Delay interval
End Function

Function monitorMoving(targetPoint)
	Do While 1 = 1
		Delay interval
		currentPoint = getCurrentPoint()
		TracePrint "monitorMoving"&":"&currentPoint&"-"&targetPoint
		If currentPoint = targetPoint Then 
			Exit Do
		End If
	Loop
End Function

//在主页面得到当前坐标点
//currentPoint = getCurrentPoint()

Function moving(targetPoint,offset)
	//切换到地图页面
	dm_ret = switchPage()
	//鼠标移动到目标点位置（）
	dm_ret = moveToTargetPoint(offset)
	//切换到主页面
	dm_ret = switchPage()
	//触发小地图坐标的变化
	dm_ret = enablePointChange()
	//监控人物移动
	dm_ret = monitorMoving(targetPoint)
End Function

//来回跑的小地图目标坐标点
Dim targetPoint(2)
targetPoint(0) = "195,85"
targetPoint(1) = "143,105"

//在大地图上目标坐标点相对窗口的坐标
Dim offset(2)
offset(0) = "549,281"
offset(1) = "403,338"

flag = 0
Do While 1 = 1
	dm_ret = moving (targetPoint(flag),offset(flag))
	If flag = 0 Then 
		flag = 1
	Else
		flag = 0
	End If
//	If currentPoint = "195,85" Then 
//		Exit Do
//	End If
Loop
dm_ret = dm.UnBindWindow()
