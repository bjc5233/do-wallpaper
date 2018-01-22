@echo off& call load.bat _uniqueStr& call loadE.bat wget WallpaperChanger& setlocal enabledelayedexpansion
::说明
::  下载unsplash随机壁纸并设置为桌面壁纸、锁屏壁纸
::参考
::  https://source.unsplash.com/
::  https://source.unsplash.com/random

title unsplashWallpaper
set lockScreenFlag=0
set width=2560
set height=1440
set imgBase=D:\pic\unsplashWallpaper
(%_call% ("imgName") %_uniqueStr%)
set imgPath=%imgBase%\%imgName%.jpg
%wget% "https://source.unsplash.com/random/%width%x%height%" -O "%imgPath%"
%WallpaperChanger% "%imgPath%" 4
if %lockScreenFlag% EQU 1 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat)
exit