'�������ð������������Ŀ¼
Dim anjianPath
anjianPath = "C:\Program Files (x86)\��������9"

'�����ļ�����
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

'����ĿĿ¼script�µ����нű������������QMScriptĿ¼��
Call copyFiles("script","QMScript\�ɼ�˼��2")

'����ĿĿ¼lib�µ����нű������������libĿ¼��
Call copyFiles("lib","lib")

'�����ļ����µ������ļ���ָ��Ŀ¼
Sub copyFiles(srcFldName,desFldName)
	Dim scriptFolder
	Set scriptFolder = fso.GetFolder(srcFldName)
	'msgbox scriptFolder.DateLastModified
	
	'Ŀ���ļ�����������ھʹ�����
	If(fso.FolderExists(desFldName)<>True) Then
		fso.CreateFolder(anjianPath & "\\" & desFldName)
	End If
	
	'�����ļ����µ������ļ�
	Dim scriptFiles
	Set scriptFiles = scriptFolder.Files
	For Each file in scriptFiles
		file.Copy(anjianPath & "\\" & desFldName & "\\" & file.name)
	Next
End Sub
