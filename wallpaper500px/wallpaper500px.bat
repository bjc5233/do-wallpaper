@echo off& call load.bat _parseArray _getRandomNum& call loadF.bat _help& call loadE.bat jq wget WallpaperChanger& setlocal enabledelayedexpansion& title wallpaper500px
:::说明
:::  下载500px壁纸并设置为桌面壁纸、锁屏壁纸
:::参考
:::  https://github.com/500px/api-documentation
:::  https://github.com/500px/api-documentation/blob/master/endpoints/photo/GET_photos.md
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
set "imgFeature={popular,highest_rated,upcoming,editors,fresh_today,fresh_yesterday,fresh_week}"
(%_call% ("imgFeature") %_parseArray%)
(%_call% ("0 !imgFeature.maxIndex! imgFeatureIndex") %_getRandomNum%)
for %%i in (!imgFeatureIndex!) do for %%j in (!imgFeature[%%i]!) do set imgFeatureVal=%%j
::set imgFeatureVal=popular
(%_call% ("1 100 pageIndex") %_getRandomNum%)

set imgBase=D:\pic\500pxWallpaper
set jsonPath=%temp%\500px.json

%wget% "https://api.500px.com/v1/photos?rpp=1&feature=%imgFeatureVal%&image_size=2048&formats=jpeg&page=%pageIndex%&sdk_key=10e2aea1742dcba191588e8bb86d9e7d3f63cdd5" -O "%jsonPath%"
for /f "delims=" %%i in ('%jq% -r -c ".photos[0].id" "%jsonPath%"') do (set imgId=%%i)
set imgPath=%imgBase%\%imgId%.jpg
for /f "delims=" %%i in ('%jq% -r -c ".photos[0].image_url" "%jsonPath%"') do (if %processStep% GEQ 0 (%wget% "%%i" -O "%imgPath%"))


if %processStep% GEQ 1 (%WallpaperChanger% "%imgPath%" 4)
if %processStep% GEQ 2 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat "%imgPath%")
exit