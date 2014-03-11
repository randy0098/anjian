
//KeyPress "L", 1
/*FindColor 0,0,1440,900,"01FC01",intX,intY
If intX > 0 And intY > 0 Then 
	//MessageBox intX+":"+intY
	//MessageBox "test"
	MoveTo intX, intY
	LeftClick 1
	while 1 > 0
		Delay 1000
    	FindPic 0,0,1440,900,"Attachment:\任务完成.bmp",0.9,intX,intY
		If intX > 0 And intY > 0 Then 
			MoveTo intX, intY
			Goto done
		End If
	Wend
	Rem done 
End If*/

/*
//设置识别模式、识别库
Plugin.SR.SetMode 0,0
Plugin.SR.SetLib ".\Plugin\SRLib.txt"
//查找前台左上角区域内"我的文档"的坐标
x1=8:y1=34:x2=66:y2=133
colordsc="FFFFFF-101010":similar=0.95:strfind="太白金星"
Plugin.SR.FindStr 0,0,1440,900,colordsc,similar,strfind,X,Y
If X>=0 and Y>=0
   MoveTo X,Y
End If

base_path = dm.GetBasePath()
dm_ret = dm.SetPath(base_path)
dm_ret = dm.SetDict(0, "dm_soft.txt")
*/


/*
PutAttachment "c:\test_game" ,"*.*"
PutAttachment ".\Plugin" ,"RegDll.dll"
Call Plugin.RegDll.Reg("c:\test_game\dm.dll")
Set dm = createobject("dm.dmsoft")
TracePrint dm.Ver()

ver = dm.Ver()
MessageBox ver


dm_ret = dm.SetPath("c:\test_game")
dm_ret = dm.SetDict(0,"test1.txt")

//dm.MoveTo 800,800


dm_1 = dm.FindStrE(0, 0, 1440, 900, "你好", "FFFFFF-101010", 0.9, intX, intY)
MessageBox intX
//MessageBox dm_ret
If intX >= 0 and intY >= 0 Then 
MessageBox -1
	 MessageBox intX
	 MessageBox intY
     dm.MoveTo intX,intY
End If


/*
i = ""
If i>=0 Then  
    //满足条件，执行下面的脚本  
    MessageBox i
    MessageBox "test1"
End If
MessageBox i
MessageBox "test"
//通过判断表达式的取值，来执行后面的动作或控制
*/



PutAttachment "c:\test_game" ,"*.*"
PutAttachment ".\Plugin" ,"RegDll.dll"
Call Plugin.RegDll.Reg("c:\test_game\dm.dll")
Set dm = createobject("dm.dmsoft")

dm_ret =dm.SetPath("c:\test_game")
dm_ret = dm.SetDict(0, "test.txt")
//dm_ret = dm.SetDict(0,"test1.txt")

//dm_ret = dm.FindStr(0, 0, 1440, 900, "你好", 000000 - 000000, 1.0, intX, intY)
/*dm_ret = dm.FindStr(58,245,95,265, "你好", "000000 - FFFFFF", 1.0, intX, intY)
If intX >= 0 and intY >= 0 Then
     dm.MoveTo intX, intY
     MessageBox intX
     MessageBox intY
     KeyDown 键盘虚拟码,次数

     MessageBox dm_ret
End If*/

//hp = dm.FindStr(58,245,95,265,"你好", 000000 - 000000, 1.0,intX,intY)


/*dm_ret =dm.FindPic (0,0,1440,900,"坐标左.bmp","000000",0.8,2,intX,intY)
dm.MoveTo intX+70, intY+15
 LeftDoubleClick 1
KeyDown 17, 1
KeyPress 65, 1
KeyUp 17, 1
KeyPress "Delete", 1
SayString "292"
*/


/*dm_ret =dm.FindPic (0,0,1440,900,"坐标右.bmp","000000",0.8,2,intX,intY)
dm.MoveTo intX-30, intY+15
 LeftDoubleClick 1
KeyDown 17, 1
KeyPress 65, 1
KeyUp 17, 1
KeyPress "Delete", 1
SayString "292"
*/

 
		/*If intX > 0 And intY > 0 Then 
			MoveTo intX, intY
		    LeftClick 1
		End If*/
		
		
Function 设置坐标(offSet,value) //输入左坐标 offSet:70  输入右坐标:110
    //我是一个函数,被你调用了
dm_ret =dm.FindPic (0,0,1440,900,"坐标左.bmp","000000",0.8,2,intX,intY)
dm.MoveTo intX+offSet, intY+15
 LeftDoubleClick 1
KeyDown 17, 1
KeyPress 65, 1
KeyUp 17, 1
KeyPress "Delete", 1
SayString value
End Function
//定义一个函数,可以在脚本中调用这个函数，支持参数和返回值
/*
Call 设置坐标(70,305)
Call 设置坐标(110, 307)
*/

Function x
    MessageBox "x"
End Function
//定义一个函数,可以在脚本中调用这个函数，支持参数和返回值
Function y
    MessageBox "y"
End Function

z=y   
If z=x Then  
    //满足条件，执行下面的脚本 
     Call z
End If
//通过判断表达式的取值，来执行后面的动作或控制

