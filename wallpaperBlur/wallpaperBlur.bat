@echo off& call load.bat _getDeskWallpaperPath& call loadF.bat _params _errorMsg& call loadE.bat WallpaperChanger imagemagick-mogrify& setlocal enabledelayedexpansion
::说明
::  通过ImageMagick工具模糊壁纸，设置为桌面壁纸、锁屏壁纸
::参考
::  https://www.imagemagick.org/script/command-line-options.php#blur
::参数
::  [-b blurNum] [-p processStep] infile outfile
::      blurNum - 模糊程度,默认值22,值越大花费的时间越长
::      processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
::      infile - 传入图片地址,为空\#时,使用当前桌面壁纸
::      outfile - 保存图片地址,为空时,保存到temp目录

::========================= set default param =========================
set blurNum=22
set processStep=2
call %_params% %*

::========================= set user param =========================
if defined _param-b (set blurNum=%_param-b%)
if defined _param-0 (
    set wallpaperPath=%_param-0%
    if "!wallpaperPath!"=="#" (
        (%_call% ("wallpaperPath") %_getDeskWallpaperPath%)
    ) else (
        if not exist "!wallpaperPath!" (call %_errorMsg% %0 "!wallpaperPath! FILE NOT EXIST")
    )
) else (
    (%_call% ("wallpaperPath") %_getDeskWallpaperPath%)
)
if defined _param-1 (
	set blurWallpaperPath=%_param-1%
) else (
    set blurWallpaperPath=%temp%\blurWallpaper
)


::========================= img process =========================
copy /y "%wallpaperPath%" "%blurWallpaperPath%" >nul
%imagemagick-mogrify% -blur 0.0x%blurNum% "%blurWallpaperPath%"


::========================= setup wallpaper ========================= 
if %processStep% GEQ 1 (%WallpaperChanger% "%blurWallpaperPath%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%blurWallpaperPath%")
exit