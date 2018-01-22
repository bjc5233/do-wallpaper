@echo off& call loadE eecho
::说明
::  打印错误信息并退出脚本
::参数
::  [来源] [错误信息]
%eecho% -b 0 -f 12 errorMsg[%~1]:
%eecho% -b 0 -f 12 "     %~2"
pause>nul& exit