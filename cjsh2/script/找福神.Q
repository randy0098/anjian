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
PutAttachment "C:\Work\Anjian\anjian\cjsh2\resource" ,"*.*"
PutAttachment ".\Plugin" ,"RegDll.dll"
Call Plugin.RegDll.Reg("C:\Work\Anjian\anjian\cjsh2\resource\dm.dll")
Set dm = createobject("dm.dmsoft")
dm_ret = dm.SetPath("C:\Work\Anjian\anjian\cjsh2\resource")
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
End Function

//因为有时候主页面小地图坐标在人物移动时也不变化（可能是bug）
//所以需要将鼠标移动到小地图上然后移出来来触发坐标的变化
Function enablePointChange()
	dm.MoveTo 927, 107
	Delay interval
	dm.MoveTo 927-100, 107
	Delay interval
End Function

Function comparePoint(currentPoint, targetPoint)
	currents = Split(currentPoint, ",")
	currentX = currents(0)
	currentY = currents(1)
	
	targets = Split(targetPoint, ",")
	targetX = targets(0)
	targetY = targets(1)
	
	flagX = false
	flagY = false
	result = false
	
	//X,Y坐标允许误差3个像素
	If Abs(currentX-targetX)<=3 Then 
		flagX = true
	End If
	
	If Abs(currentY-targetY)<=3 Then 
		flagY = true
	End If
	
	If (flagX = true) And (flagY = true) Then 
		result = true
	End If
	
	comparePoint = result

End Function


Function monitorMoving(targetPoint)
	//定义：movingFlag=false时表明结束此函数后，人物要继续往targetPoint跑
	//movingFlag=true时表明结束此函数后，人物要往targetPoint的下一个点跑
	movingFlag = false
	Do While 1 = 1
		//每隔一段时间就扫描是否发现NPC
		Delay 100
		dm_ret = dm.FindPic(0, 0, 1024, 768, "福神1.bmp", "000000", 0.9, 0, intX, intY)
		//如果发现NPC就跑过去交任务
		If intX <> - 1  Then 
			TracePrint "发现NPC"
			//为了避免跑动过程中坐标位置发生变化，这里按下W键来使角色停止移动
			dm.KeyPress 87
			TracePrint "按下W"
			Delay interval
			//鼠标移动到NPC
			dm.moveTo intX + 10, intY + 40
			TracePrint "鼠标移动到NPC"
			Delay interval
			//点击NPC
			dm.LeftClick 
			TracePrint "已点击NPC"
			
			Dim n
			n = 20
			Do While 1 = 1
				//如果20次都搜不到窗口，窗口可能被别人抢了，就重新开始跑动
				If n = 20 Then 
					TracePrint "搜寻NPC超时了就继续跑动"
					Exit Do
				End If
				Delay 100
				dm_ret = dm.FindPic(0, 0, 1024, 768, "我找到你了1.bmp", "000000", 0.9, 0, x, y)
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
					//交完任务人物要继续往targetPoint点跑
					TracePrint "交完任务人物要继续往targetPoint点跑"
					Exit Do
				End If
				TracePrint "无任务窗口"
				n = n + 1
			Loop
			//交完任务或者搜寻NPC超时了就继续跑动
			Exit Do
		Else 
			//如果没有发现NPC就继续往终点跑
			currentPoint = getCurrentPoint()
			TracePrint "monitorMoving" & ":" & currentPoint & "-" & targetPoint
			//当到达终点时就往回跑
			result = comparePoint(currentPoint,targetPoint)
			If result = True Then 
				//到达终点后要往下一点跑
				TracePrint "到达终点后要往下一点跑"
				movingFlag = true
				Exit Do
			End If
		End If
	Loop
	monitorMoving = movingFlag
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
	movingFlag = monitorMoving(targetPoint)
	moving = movingFlag
End Function


//绑定鼠标所在的窗口
//LogStart "C:\anjian.log"
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

interval = 300

//来回跑的小地图目标坐标点
Dim targetPoint(2)
targetPoint(0) = "103,104"
targetPoint(1) = "147,103"


//在大地图上目标坐标点相对窗口的坐标
Dim offset(2)
offset(0) = "293,334"
offset(1) = "421,331"


Dim totalTimes
totalTimes = 0
	
Dim i
i = 0
Do While 1 = 1
	TracePrint "i:"&i
	movingFlag = moving(targetPoint(i), offset(i))
	If movingFlag = True Then 
		i = i + 1
		If i = UBound(targetPoint) Then 
			i = 0
		End If
	Else
		i = i
	End If
Loop

//LogStop
//解锁键盘和鼠标
dm.LockInput 0
dm_ret = dm.UnBindWindow()


