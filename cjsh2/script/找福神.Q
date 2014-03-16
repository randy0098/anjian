[General]
SyntaxVersion=2
BeginHotkey=81
BeginHotkeyMod=2
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=87
StopHotkeyMod=2
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
	TracePrint "移动到地图目标点:"&pointValue(0)&","&pointValue(1)
	Delay interval
	dm.LeftClick 
	TracePrint "点击移动"
	Delay interval
End Function

//切换主页面和地图页面
Function switchPage()
	dm.KeyPress 77
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

Function searchNPC
	
End Function

Function monitorMoving(targetPoint)
	Do While 1 = 1
		//每隔一段时间就扫描是否发现NPC
		Delay 200
		dm_ret = dm.FindPic(0, 0, 1024, 768, "福神.bmp", "000000", 0.9, 0, intX, intY)
		//如果发现NPC就跑过去交任务
		If intX <> - 1  Then 
			TracePrint "发现NPC"
			//Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768, "这是第" & totalTimes & "次交任务", "0000FF")
			//为了避免跑动过程中坐标位置发生变化，这里用回城并取消使角色停止移动
			//按下6号键回城
			dm.KeyPress 54
			TracePrint "按下回城"
			Delay 500
			//按ECS取消回城			
			dm.KeyPress 27
			TracePrint "取消回城"
			Delay 300
			//鼠标移动到NPC
			dm.moveTo intX + 10, intY + 40
			TracePrint "鼠标移动到NPC"
			Delay interval
			//点击NPC
			dm.LeftClick 
			TracePrint "已点击NPC"
			
			Do While 1 = 1
				Delay 300
				dm_ret = dm.FindPic(0, 0, 1024, 768, "我找到你了.bmp", "000000", 0.9, 0, intX, intY)
				TracePrint "查找任务窗口"
				If x <> - 1  Then 
					TracePrint "出现任务窗口"
					dm.moveTo x + 5, y + 10
					Delay interval
					dm.LeftClick
					totalTimes = totalTimes + 1
					TracePrint "交任务："&totalTimes
					//Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768, "这是第" & totalTimes & "次交任务", "0000FF")
					Call Plugin.Msg.Tips("这是第" & totalTimes & "次交任务") 
					Exit Do
				End If
				TracePrint "无任务窗口"
			Loop
			//交完任务就往回跑
			Exit Do
		//如果没有发现NPC就继续往终点跑
		Else 
			currentPoint = getCurrentPoint()
			TracePrint "monitorMoving" & ":" & currentPoint & "-" & targetPoint
			//当到达终点时就往回跑
			If currentPoint = targetPoint Then 
				Exit Do
			End If
		End If
	Loop
End Function


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


//绑定鼠标所在的窗口
hwnd = dm.GetMousePointWindow()
//将窗口移动到桌面左上角
dm_ret = dm.MoveWindow(hwnd,0,0)
//启用后台模式
//dx.public.disable.window.size
dm_ret = dm.BindWindowEx(hwnd, "dx", "dx", "dx", "dx.public.disable.window.size|dx.public.disable.window.position", 0)
//锁定键盘和鼠标，避免影响窗口内容
dm.LockInput 1

Delay 1500

If dm_ret = 0 Then 
	MessageBox "绑定失败"
	EndScript
End If

interval = 500
//来回跑的小地图目标坐标点
Dim targetPoint(2)
targetPoint(0) = "174,39"
targetPoint(1) = "186,40"

//在大地图上目标坐标点相对窗口的坐标
Dim offset(2)
offset(0) = "489,154"
offset(1) = "524,156"

Dim totalTimes
totalTimes = 0
flag = 0
Do While 1 = 1
	TracePrint "flag:"&flag
	dm_ret = moving (targetPoint(flag),offset(flag))
	If flag = 0 Then 
		flag = 1
	Else
		flag = 0
	End If
Loop

//解锁键盘和鼠标
dm.LockInput 0
dm_ret = dm.UnBindWindow()




