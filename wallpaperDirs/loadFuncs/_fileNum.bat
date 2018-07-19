@echo off& call loadE tl
::说明
::  获取文本行数
::参数
::  filePath num
::      filePath - 文本路径[输入参数]
::      num - 文本行数[输出参数]
::external
::  date       2018-01-21 21:14:19
::  face       (^>﹏^<)
::  weather    shanghai 小雨转中雨 9℃/6℃ 东风转无持续风向
if not exist "%~1" goto :EOF
for /f "tokens=1* delims=:" %%i in ('%tl% "%~1" -i') do if "%%i"=="FILE LINES" set %2=%%j