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
	) else if %%i==imagemagick-convert (
		set %%i=%base%\imagemagick\%%i.exe
	) else if %%i==imagemagick-identify (
		set %%i=%base%\imagemagick\%%i.exe
	) else if %%i==imagemagick-mogrify (
		set %%i=%base%\imagemagick\%%i.exe
	) else if %%i==imagemagick-composite (
		set %%i=%base%\imagemagick\%%i.exe
	) else if %%i==zipMini (
		set %%i=%base%\zip.exe
	) else (
		set %%i=%base%\%%i.exe
	)
)

::��ע
::  zipMini - ֱ������Ϊzip�ᵼ�µ���zipʱ����, �����ΪzipMini


::  loadE.bat���������exe
::      TODO ���������ÿ�, exeȫ��һ�����
::      TODO �������洢�⣬exe���Խ���Ŀ¼, ÿ��ʹ��exe�󣬴�����exeʹ�õ�˵���ļ���һ��demo.bat
::      call loadE.bat cpaint ckey...   ������ӳ��Ϊ����·��
::      %cpaint% param1 param2...       ���÷�ʽ��������ʽ����
::      %ckey%   param1 param2...       ���÷�ʽ��������ʽ����