@echo off& call load.bat _uniqueStr& call loadF.bat _help& call loadE.bat wget WallpaperChanger& setlocal enabledelayedexpansion& title unsplashWallpaper
:::˵��
:::  ����unsplash�����ֽ������Ϊ�����ֽ��������ֽ
:::�ο�
:::  https://source.unsplash.com/
:::  https://source.unsplash.com/random
:::����
:::  %1 - ������[0-download 1-setWallpaper 2-setLockWallpaper(Ĭ��ֵ)]
:::  %1 - ��ӡע����Ϣ[help\-help\-h]

if not "%~1" EQU "" (
	if "%~1" EQU "help" (call %_help% "%~f0"& goto :EOF)
	if "%~1" EQU "-help" (call %_help% "%~f0"& goto :EOF)
	if "%~1" EQU "-h" (call %_help% "%~f0"& goto :EOF)
	set processStep=%~1
) else (
	set processStep=2
)
set width=2560
set height=1440
set imgBase=D:\pic\unsplashWallpaper
(%_call% ("imgName") %_uniqueStr%)
set imgPath=%imgBase%\%imgName%.jpg
if %processStep% GEQ 0 (%wget% "https://source.unsplash.com/random/%width%x%height%" -O "%imgPath%")
if %processStep% GEQ 1 (%WallpaperChanger% "%imgPath%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%imgPath%")
exit