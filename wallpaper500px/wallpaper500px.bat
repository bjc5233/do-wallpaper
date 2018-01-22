@echo off& call load.bat _parseArray _getRandomNum& call loadE.bat jq wget WallpaperChanger& setlocal enabledelayedexpansion& title wallpaper500px
::说明
::  下载500px壁纸并设置为桌面壁纸、锁屏壁纸
::参考
::  https://github.com/500px/api-documentation
::  https://github.com/500px/api-documentation/blob/master/endpoints/photo/GET_photos.md


set lockScreenFlag=1
set "imgFeature={popular,highest_rated,upcoming,editors,fresh_today,fresh_yesterday,fresh_week}"
::(%_call% ("imgFeature") %_parseArray%)
::(%_call% ("0 !imgFeature.maxIndex! imgFeatureIndex") %_getRandomNum%)
::for %%i in (!imgFeatureIndex!) do for %%j in (!imgFeature[%%i]!) do set imgFeatureVal=%%j
set imgFeatureVal=popular
(%_call% ("1 100 pageIndex") %_getRandomNum%)

set imgBase=D:\pic\500pxWallpaper
set jsonPath=%temp%\500px.json

%wget% "https://api.500px.com/v1/photos?rpp=1&feature=%imgFeatureVal%&image_size=2048&formats=jpeg&page=%pageIndex%&sdk_key=10e2aea1742dcba191588e8bb86d9e7d3f63cdd5" -O "%jsonPath%"
for /f "delims=" %%i in ('%jq% -r -c ".photos[0].id" "%jsonPath%"') do (set imgId=%%i)
set imgPath=%imgBase%\%imgId%.jpg
for /f "delims=" %%i in ('%jq% -r -c ".photos[0].image_url" "%jsonPath%"') do (%wget% "%%i" -O "%imgPath%")
%WallpaperChanger% "%imgPath%" 4
if %lockScreenFlag% EQU 1 if exist "%~d0%~p0wallpaperLockScreen.bat" (start /d "%~d0%~p0" /min wallpaperLockScreen.bat)
exit