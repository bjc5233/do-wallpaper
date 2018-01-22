@echo off& call load.bat _getMinNum _getDeskWallpaperPath& call loadF.bat _params _errorMsg& call loadE.bat WallpaperChanger bc imagemagick-convert imagemagick-identify& setlocal enabledelayedexpansion
::说明
::  通过ImageMagick工具对图片进行移轴处理
::参考
::  https://www.imagemagick.org/script/convert.php
::  https://www.imagemagick.org/script/command-line-options.php#modulate
::  http://www.fmwconcepts.com/imagemagick/tiltshift/index.php
::参数
::  [-m mode] [-s size] [-b blur] [-p processStep] infile outfile
::      mode - vertical(v), horizontal(h), circle(c) default=vertical
::      size - size of central unblurred area; -100~100 default=0
::      blur - blur amount for outer area; default=22
::      processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
::      infile - 传入图片地址,为空\#时,使用当前桌面壁纸
::      outfile - 保存图片地址,为空时,保存到temp目录

::========================= set default param =========================
set mode=vertical
set size=0
set blur=22
set processStep=2
call %_params% %*


::========================= set user param =========================
if defined _param-m (
	set mode=%_param-m%& set flag=0
	if "!mode!"=="vertical" set flag=1
	if "!mode!"=="horizontal" set flag=1
	if "!mode!"=="circle" set flag=1
	if "!mode!"=="v" set flag=1& set mode=vertical
	if "!mode!"=="h" set flag=1& set mode=horizontal
	if "!mode!"=="c" set flag=1& set mode=circle
	if !flag!==0 (call %_errorMsg% %0 "-m=!mode! IS AN INVALID VALUE")
)
if defined _param-s (
	set size=%_param-s%& set flag=0
	if !size! GEQ -100 if !size! LEQ 100 set flag=1
	if !flag!==0 (call %_errorMsg% %0 "-s=!size! MUST BE AN INTEGER BETWEEN -100 AND 100")
)
if defined _param-b (
	set blur=%_param-b%
)
if defined _param-p (
	set processStep=%_param-p%
)
if defined _param-0 (
	set infile=%_param-0%
    if "!infile!"=="#" (
        (%_call% ("infile") %_getDeskWallpaperPath%)
    ) else (
        if not exist "!infile!" (call %_errorMsg% %0 "!infile! FILE NOT EXIST")
    )
) else (
    (%_call% ("infile") %_getDeskWallpaperPath%)
)
if defined _param-1 (
	set outfile=%_param-1%
) else (
    set outfile=%temp%\wallpaperTiltshift.jpg
)


::========================= get image dimensions =========================
set tmpPath=%temp%\wallpaperTiltShiftTemp.mpc& set tmpPathCache=%temp%\wallpaperTiltShiftTemp.cache
set tmpPath2=%temp%\wallpaperTiltShiftTemp2.mpc& set tmpPath2Cache=%temp%\wallpaperTiltShiftTemp2.cache
%imagemagick-convert% -quiet "!infile!" +repage "!tmpPath!"
for /f "delims=" %%i in ('%imagemagick-identify% -ping -format "%%w" "!tmpPath!"') do (set width=%%i)
for /f "delims=" %%i in ('%imagemagick-identify% -ping -format "%%h" "!tmpPath!"') do (set height=%%i)
(%_call% ("!width! !height! dimension") %_getMinNum%)

if !mode!==vertical (%imagemagick-convert% -size !height!x!width! gradient: -rotate 90 -solarize 50%% -level 0x50%% -negate "!tmpPath2!")
if !mode!==horizontal (%imagemagick-convert% -size !width!x!height! gradient: -solarize 50%% -level 0x50%% -negate "!tmpPath2!")
if !mode!==circle (%imagemagick-convert% -size !dimension!x!dimension! radial-gradient: -negate -gravity center -background white -extent !width!x!height! "!tmpPath2!")


::========================= reset gamma =========================
if !size! LSS 1 (
	for /f "delims=" %%i in ('echo -0.09*!size!+1 ^| %bc% -q') do set size=%%i
) else (
	for /f "delims=" %%i in ('echo -0.0099*!size!+1 ^| %bc% -q') do set size=%%i
)


::========================= create output =========================
%imagemagick-convert% ^
	^( "!tmpPath!" -modulate 100,100,100 -sigmoidal-contrast 0,50%% ^)^
	^( -clone 0 -blur 0x22 ^)^
	^( "!tmpPath2!" -gamma !size! ^)^
	-compose over -composite "!outfile!"
    
    
::========================= setup wallpaper ========================= 
if %processStep% GEQ 1 (%WallpaperChanger% "%outfile%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%outfile%")


::========================= cleanup temp ========================= 
del /q "%tmpPath%" "%tmpPathCache%" "%tmpPath2%" "%tmpPath2Cache%"
exit