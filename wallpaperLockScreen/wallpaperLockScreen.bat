@echo off& call load.bat _getDeskWallpaperPath& call loadF.bat _help& call loadE.bat elevate& setlocal enabledelayedexpansion
:::˵��
:::  ����������ֽ
:::���÷�ʽ
:::  A:�޲��� - ����ǰ�����ֽ����Ϊ������ֽ
:::  B:������
:::     %1 - ��ָ��ͼƬ����Ϊ������ֽ
:::     %1 - ��ӡע����Ϣ[help\-help\-h]
if "%~1" EQU "" (
	(%_call% ("wallpaperPath") %_getDeskWallpaperPath%)
) else (
	if "%~1" EQU "help" (call %_help% "%~f0"& goto :EOF)
	if "%~1" EQU "-help" (call %_help% "%~f0"& goto :EOF)
	if "%~1" EQU "-h" (call %_help% "%~f0"& goto :EOF)
	set wallpaperPath=%~1
)
%elevate% -c reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
%elevate% -w reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenImage /t REG_SZ /f /d "%wallpaperPath%"
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
exit