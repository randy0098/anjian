'这里设置按键精灵程序主目录
Dim anjianPath
anjianPath = "C:\Program Files (x86)\按键精灵9"

'创建文件对象
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

'复项目目录script下的所有脚本到按键精灵的QMScript目录下
Call copyFiles("script","QMScript\成吉思汗2")

'复项目目录lib下的所有脚本到按键精灵的lib目录下
Call copyFiles("lib","lib")

'复制文件夹下的所有文件到指定目录
Sub copyFiles(srcFldName,desFldName)
	Dim scriptFolder
	Set scriptFolder = fso.GetFolder(srcFldName)
	'msgbox scriptFolder.DateLastModified
	
	'目标文件夹如果不存在就创建它
	If(fso.FolderExists(desFldName)<>True) Then
		fso.CreateFolder(anjianPath & "\\" & desFldName)
	End If
	
	'复制文件夹下的所有文件
	Dim scriptFiles
	Set scriptFiles = scriptFolder.Files
	For Each file in scriptFiles
		file.Copy(anjianPath & "\\" & desFldName & "\\" & file.name)
	Next
End Sub
