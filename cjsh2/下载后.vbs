'��Ŀ�����������ļ����Զ�����

'�������ð������������Ŀ¼
Dim anjianPath
anjianPath = "C:\Work\Program\��������9"

Dim value
value = MsgBox ("�˲����Ḳ�ǰ��������ļ�!", 49, "ע�⣺")

If value = 1 Then
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
End If