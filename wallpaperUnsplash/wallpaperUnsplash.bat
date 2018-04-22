@echo off& call load.bat _uniqueStr& call loadF.bat _help& call loadE.bat wget WallpaperChanger& setlocal enabledelayedexpansion& title unsplashWallpaper
:::说明
:::  下载unsplash随机壁纸并设置为桌面壁纸、锁屏壁纸
:::参考
:::  https://source.unsplash.com/
:::  https://source.unsplash.com/random
:::参数
:::  %1 - 处理步骤[0-download 1-setWallpaper 2-setLockWallpaper(默认值)]
:::  %1 - 打印注释信息[help\-help\-h]

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