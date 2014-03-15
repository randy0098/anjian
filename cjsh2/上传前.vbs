'按键精灵到项目的文件自动复制

'这里设置按键精灵程序主目录
Dim anjianPath
anjianPath = "C:\Program Files (x86)\按键精灵9"

'创建文件对象
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

'复制按键精灵QMScript\成吉思汗2目录下的所有脚本到项目的script目录下
Call copyFiles("QMScript\成吉思汗2","script")

'复制按键精灵lib目录下的所有脚本到项目目录lib下
Call copyFiles("lib","lib")

'复制文件夹下的所有文件到指定目录
Sub copyFiles(srcFldName,desFldName)
	Dim scriptFolder
	Set scriptFolder = fso.GetFolder(anjianPath & "\\" & srcFldName)
	'复制文件夹下的所有文件
	Dim scriptFiles
	Set scriptFiles = scriptFolder.Files
	For Each file in scriptFiles
		'复制lib下的文件时只复制文件名中有“cjsh2”前缀的文件
		If(srcFldName="lib") Then
			'注意这里的参数，查找是从1开始的而不是从0，要是查不到返回的是0而不是-1！
			If(InStr(1,file.name,"cjsh2")=1) Then
				file.Copy(desFldName & "\\" & file.name)
			End If
		Else
			file.Copy(desFldName & "\\" & file.name)
		End If
	Next
End Sub
