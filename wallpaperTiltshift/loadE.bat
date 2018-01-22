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

::备注
::  zipMini - 直接命名为zip会导致调用zip时报错, 因而改为zipMini


::  loadE.bat管理第三方exe
::      TODO 第三方调用库, exe全部一级存放
::      TODO 第三方存储库，exe各自建立目录, 每次使用exe后，创建该exe使用的说明文件，一级demo.bat
::      call loadE.bat cpaint ckey...   将参数映射为函数路径
::      %cpaint% param1 param2...       调用方式与正常方式相差不大
::      %ckey%   param1 param2...       调用方式与正常方式相差不大