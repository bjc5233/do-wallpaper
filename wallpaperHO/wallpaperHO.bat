@echo off& call load.bat _getRandomNum _getDeskWallpaperPath& call loadF.bat _params _errorMsg& call loadE.bat bc WallpaperChanger imagemagick-mogrify imagemagick-convert imagemagick-identify& setlocal enabledelayedexpansion
::说明
::  通过ImageMagick工具合并图片
::参考
::  https://www.imagemagick.org/script/convert.php
::  http://www.imagemagick.org/Usage/thumbnails/
::参数
::  [-m mode] [-s coverScalePercent] [-x coverPosXPercent] [-y coverPosYPercent] [-b blurNum] [-p processStep] infile outfile
::      mode - cover图在back图中的样式 1[rect] 2[rect-shadow] 3[circle] 4[circle-shadow] default=random
::      coverScalePercent - cover图缩放值
::      coverPosXPercent - cover图在back图X轴所处位置百分比
::      coverPosYPercent - cover图在back图Y轴所处位置百分比
::      blur - back图模糊程度,默认值22,值越大花费的时间越长
::      processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
::      infile - 传入图片地址,为空\#时,使用当前桌面壁纸
::      outfile - 保存图片地址,为空时,保存到temp目录

::========================= set default param =========================
set blurNum=27
set coverScalePercent=0.3
set coverPosXPercent=0.5
set coverPosYPercent=0.2
set processStep=2
call %_params% %*


::========================= set user param =========================
if defined _param-m (
	set mode=%_param-m%& set flag=0
	if !mode! GEQ 1 if !mode! LEQ 4 set flag=1
	if !flag!==0 (call %_errorMsg% %0 "-m=!mode! MUST BE AN INTEGER BETWEEN 1 AND 4")
) else (
    (%_call% ("1 4 mode") %_getRandomNum%)
)
if defined _param-s (set coverScalePercent=%_param-s%)
if defined _param-x (set coverPosXPercent=%_param-x%)
if defined _param-y (set coverPosYPercent=%_param-y%)
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
	set HOWallpaperPath=%_param-1%
) else (
    set HOWallpaperPath=%temp%\wallpaperHO.jpg
)


::========================= setup temp path =========================
set HOCoverWallpaperPath=%temp%\wallpaperHOCover.png
set HOBackWallpaperPath=%temp%\wallpaperHOBack.jpg


::========================= pre process img =========================
::======== final img ========
copy /y "%wallpaperPath%" "%HOCoverWallpaperPath%" >nul
::======== cover img ========
if %mode% EQU 1 (
    %imagemagick-convert% "%HOCoverWallpaperPath%" -border 6 "%HOCoverWallpaperPath%"
)
if %mode% EQU 2 (
	%imagemagick-convert% -page +20+20 "%HOCoverWallpaperPath%" -alpha set^
          ^( +clone -background black -shadow 60x20+20+20 ^) +swap^
          -background none -mosaic "%HOCoverWallpaperPath%"
)
if %mode% EQU 3 (
    %imagemagick-convert% "%HOCoverWallpaperPath%"^
    -alpha set^
    ^( +clone -distort DePolar 0 -virtual-pixel HorizontalTile -background None -distort Polar 0 ^)^
    -compose Dst_In -composite -trim +repage "%HOCoverWallpaperPath%"
)
if %mode% EQU 4 (
    %imagemagick-convert% "%HOCoverWallpaperPath%"^
    -alpha set^
    ^( +clone -distort DePolar 0 -virtual-pixel HorizontalTile -background None -distort Polar 0 ^)^
    -compose Dst_In -composite -trim +repage "%HOCoverWallpaperPath%"
	
	%imagemagick-convert% -page +20+20 "%HOCoverWallpaperPath%" -alpha set^
          ^( +clone -background black -shadow 60x20+20+20 ^) +swap^
          -background none -mosaic "%HOCoverWallpaperPath%"
)
::======== back img ========
copy /y "%wallpaperPath%" "%HOBackWallpaperPath%" >nul
%imagemagick-mogrify% -blur 0.0x%blurNum% "%HOBackWallpaperPath%"


::========================= calc img width height position =========================
for /f "tokens=1,2 delims=x" %%i in ('%imagemagick-identify% -format "%%wx%%h" %HOCoverWallpaperPath%') do (set coverWidth=%%i& set coverHeight=%%j)
for /f "tokens=1,2 delims=x" %%i in ('%imagemagick-identify% -format "%%wx%%h" %HOBackWallpaperPath%') do (set backWidth=%%i& set backHeight=%%j)
for /f "delims=" %%i in ('echo %coverScalePercent%*100 ^| %bc% -q') do set coverScale=%%i
for /f "delims=" %%i in ('echo ^(%backWidth%-%coverWidth%*%coverScalePercent%^)*%coverPosXPercent% ^| %bc% -q') do set coverX=%%i
for /f "delims=" %%i in ('echo ^(%backHeight%-%coverHeight%*%coverScalePercent%^)*%coverPosYPercent% ^| %bc% -q') do set coverY=%%i


::========================= img union =========================
%imagemagick-convert% "%HOBackWallpaperPath%"^
    -compose over "%HOCoverWallpaperPath%"^
    -geometry %coverScale%%%x%coverScale%+%coverX%+%coverY%^
    -composite "%HOWallpaperPath%"
    

::========================= setup wallpaper ========================= 
if %processStep% GEQ 1 (%WallpaperChanger% "%HOWallpaperPath%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%HOWallpaperPath%")


::========================= cleanup temp ========================= 
del /q "%HOCoverWallpaperPath%" "%HOBackWallpaperPath%"
exit