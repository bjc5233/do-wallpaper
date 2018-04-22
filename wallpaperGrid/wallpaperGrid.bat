@echo off& call load.bat _getRandomNum _getDeskWallpaperPath& call loadF.bat _params _errorMsg _help& call loadE.bat bc WallpaperChanger imagemagick-convert imagemagick-identify imagemagick-composite& setlocal enabledelayedexpansion
:::说明
:::  通过ImageMagick工具制作九宫格图片
:::参考
:::  https://www.imagemagick.org/script/convert.php
:::参数
:::  [-p padding] [-c color] infile outfile
:::      padding - 宫格之间间隔 default=10
:::      color - 宫格之间间隔颜色 default=255,255,255,0.4
:::      infile - 传入图片地址,为空\#时,使用当前桌面壁纸
:::      outfile - 保存图片地址,为空时,保存到temp目录
:::  [-h help]
:::      help - 打印注释信息

::========================= set default param =========================
set padding=10
set color=255,255,255,0.4
::处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
set processStep=2
call %_params% %*


::========================= set user param =========================
if defined _param-h (call %_help% "%~f0"& goto :EOF)
if defined _param-help (call %_help% "%~f0"& goto :EOF)
if defined _param-p (set padding=%_param-p%)
if defined _param-c (set color=%_param-c%)
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
	set wallpaperGrid=%_param-1%
) else (
    set wallpaperGrid=%temp%\wallpaperGrid.png
)


::========================= setup temp path =========================
set wallpaperGridSrc=%temp%\wallpaperGridSrc.jpg
set wallpaperGridCropPrefix=%temp%\wallpaperGridCrop
set wallpaperGridCrop=%wallpaperGridCropPrefix%.jpg
::======== final img ========
copy /y "%wallpaperPath%" "%wallpaperGridSrc%" >nul



::========================= calc img width height position =========================
for /f "tokens=1,2 delims=x" %%i in ('%imagemagick-identify% -format "%%wx%%h" %wallpaperGridSrc%') do (set width=%%i& set height=%%j)
for /f "delims=" %%i in ('echo %width%/3 ^| %bc% -q') do set widthMin=%%i& set /a widthMin_2=widthMin+padding, widthMin_3=(widthMin+padding)*2
for /f "delims=" %%i in ('echo %height%/3 ^| %bc% -q') do set heightMin=%%i& set /a heightMin_2=heightMin+padding, heightMin_3=(heightMin+padding)*2
for /f "delims=" %%i in ('echo %widthMin%*3 ^| %bc% -q') do set width=%%i
for /f "delims=" %%i in ('echo %heightMin%*3 ^| %bc% -q') do set height=%%i

for /f "delims=" %%i in ('echo %width%+%padding%*2 ^| %bc% -q') do set widthPadding=%%i
for /f "delims=" %%i in ('echo %height%+%padding%*2 ^| %bc% -q') do set heightPadding=%%i


::========================= img crop and union =========================
%imagemagick-convert% "%wallpaperGridSrc%" -crop %width%x%height%+0+0 "%wallpaperGridSrc%"
%imagemagick-convert% "%wallpaperGridSrc%" -crop %widthMin%x%heightMin% "%wallpaperGridCrop%"
%imagemagick-convert% -size %widthPadding%x%heightPadding% -strip xc:rgba(%color%,0.2) "%wallpaperGrid%"
set cropIndex=0
for /l %%y in (0,1,2) do (
	for /l %%x in (0,1,2) do (
		set /a posX="%%x*(widthMin+padding)", posY="%%y*(heightMin+padding)"
		%imagemagick-composite% -geometry +!posX!+!posY! "%wallpaperGridCropPrefix%-!cropIndex!.jpg" "%wallpaperGrid%" "%wallpaperGrid%"
		set /a cropIndex+=1
	)
)



::========================= setup wallpaper ========================= 
if %processStep% GEQ 1 (%WallpaperChanger% "%wallpaperGrid%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%wallpaperGrid%")


::========================= cleanup temp ========================= 
del /q "%wallpaperGridSrc%" "%wallpaperGridCropPrefix%-*.jpg"
exit