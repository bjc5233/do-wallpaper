@echo off& call load.bat _getDeskWallpaperPath& call loadE.bat elevate& setlocal enabledelayedexpansion
::˵��
::  ����������ֽ
::���÷�ʽ
::  A:�޲��� - ����ǰ�����ֽ����Ϊ������ֽ
::  B:������
::     %1 - ��ָ��ͼƬ����Ϊ������ֽ
if "%~1" EQU "" (
	(%_call% ("wallpaperPath") %_getDeskWallpaperPath%)
) else (
	set wallpaperPath=%~1
)
%elevate% -c reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
%elevate% -w reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenImage /t REG_SZ /f /d "%wallpaperPath%"
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
exit