@echo off& call loadE tl
::˵��
::  ��ȡ�ı�����
::����
::  filePath num
::      filePath - �ı�·��[�������]
::      num - �ı�����[�������]
::external
::  date       2018-01-21 21:14:19
::  face       (^>�n^<)
::  weather    shanghai С��ת���� 9��/6�� ����ת�޳�������
if not exist "%~1" goto :EOF
for /f "tokens=1* delims=:" %%i in ('%tl% "%~1" -i') do if "%%i"=="FILE LINES" set %2=%%j