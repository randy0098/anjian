'�������鵽��Ŀ���ļ��Զ�����

'�������ð������������Ŀ¼
Dim anjianPath
anjianPath = "C:\Program Files (x86)\��������9"

'�����ļ�����
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

'���ư�������QMScript\�ɼ�˼��2Ŀ¼�µ����нű�����Ŀ��scriptĿ¼��
Call copyFiles("QMScript\�ɼ�˼��2","script")

'���ư�������libĿ¼�µ����нű�����ĿĿ¼lib��
Call copyFiles("lib","lib")

'�����ļ����µ������ļ���ָ��Ŀ¼
Sub copyFiles(srcFldName,desFldName)
	Dim scriptFolder
	Set scriptFolder = fso.GetFolder(anjianPath & "\\" & srcFldName)
	'�����ļ����µ������ļ�
	Dim scriptFiles
	Set scriptFiles = scriptFolder.Files
	For Each file in scriptFiles
		'����lib�µ��ļ�ʱֻ�����ļ������С�cjsh2��ǰ׺���ļ�
		If(srcFldName="lib") Then
			'ע������Ĳ����������Ǵ�1��ʼ�Ķ����Ǵ�0��Ҫ�ǲ鲻�����ص���0������-1��
			If(InStr(1,file.name,"cjsh2")=1) Then
				file.Copy(desFldName & "\\" & file.name)
			End If
		Else
			file.Copy(desFldName & "\\" & file.name)
		End If
	Next
End Sub
