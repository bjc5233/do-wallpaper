@echo off
::格式化bat参数,支持参数类型: 
::  key-value型  [-size -20]==>[_param-size=-20]
::  flag型       [-switch]==>[_param-switch=true]后续代码通过判断_param-switch变量是否定义来判断-switch是否有用户传值
::  纯value型    ["d:\in.jpg"]==>[_param-0=d:\in.jpg]按这种参数顺序给予012...标识
::注意
::  key格式必须以[-]开头, 且后续部分不能为纯数字
::  纯value型参数可以自由放置在参数列表中的任意位置, 但建议统一放置到参数类表最后; 且纯value型参数前不能有flag型参数
::  bat中变量名不区分大小写, 因此不能设置[-size -SIZE]两个key
::调用方式
::  ------ demo.bat代码 ------
::      call loadF.bat _params
::      call %_params% %*
::      set _param
::  ------ demo.bat代码 ------
::  demo.bat -size -20 -flag -name bjc -len 10 "d:\in.jpg" "d:\out.jpg"
::  输出结果=====>
::      _param-flag=true
::      _param-len=10
::      _param-name=bjc
::      _param-size=-20
::      _param-0=d:\in.jpg
::      _param-1=d:\out.jpg
::      _param_num=6
set _param_num=0& set _param_no_key_index=0
:_param_loop
set _param=%~1
if "%_param%"=="" set _param_no_key_index=& set _param_flag=& set _param_p1=& set _param_p2=& set _param_is_key=& goto :EOF
set _param_p1=%_param:~0,1%& set _param_p2=%_param:~1%& set _param_is_key=false
set /a _param_flag=%_param_p2%*1 >nul 2>nul
if "%_param_p1%"=="-" if not "%_param_flag%"=="%_param_p2%" set _param_is_key=true
if %_param_is_key%==true (
	set _param_last_key=%~1& set /a _param_num+=1& set _param%_param%=true
) else (
	if defined _param_last_key (
        ::key-value型参数
		set _param%_param_last_key%=%_param%& set _param_last_key=
	) else (
        ::纯value型参数
		set _param-%_param_no_key_index%=%_param%& set /a _param_no_key_index+=1, _param_num+=1
	)
)
shift& goto :_param_loop