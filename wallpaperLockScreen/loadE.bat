@echo off& set base=%~d0%~p0loadExes
for %%i in (%*) do (
	if %%i==iconv (
		set %%i=%base%\%%i\%%i.exe
	) else if %%i==mplayer (
		set %%i=%base%\%%i\%%i.exe
	) else if %%i==sqlite3 (
		set %%i=%base%\sqlite\%%i.exe
	) else if %%i==node (
		set %%i="C:\Program Files\nodejs\node.exe"
	) else (
		set %%i=%base%\%%i.exe
	)
)
::  loadE.bat���������exe
::      TODO ���������ÿ�, exeȫ��һ�����
::      TODO �������洢�⣬exe���Խ���Ŀ¼, ÿ��ʹ��exe�󣬴�����exeʹ�õ�˵���ļ���һ��demo.bat
::      call loadE.bat cpaint ckey...   ������ӳ��Ϊ����·��
::      %cpaint% param1 param2...       ���÷�ʽ��������ʽ����
::      %ckey%   param1 param2...       ���÷�ʽ��������ʽ����