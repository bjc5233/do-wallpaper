@echo off& call load.bat _getDeskWallpaperPath& call loadE.bat elevate& setlocal enabledelayedexpansion
::说明
::  设置锁屏壁纸
::调用方式
::  A:无参数 - 将当前桌面壁纸设置为锁屏壁纸
::  B:带参数
::     %1 - 将指定图片设置为锁屏壁纸
if "%~1" EQU "" (
	(%_call% ("wallpaperPath") %_getDeskWallpaperPath%)
) else (
	set wallpaperPath=%~1
)
%elevate% -c reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
%elevate% -w reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenImage /t REG_SZ /f /d "%wallpaperPath%"
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
exit