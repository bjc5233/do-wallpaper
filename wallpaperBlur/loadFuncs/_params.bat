@echo off
::��ʽ��bat����,֧�ֲ�������: 
::  key-value��  [-size -20]==>[_param-size=-20]
::  flag��       [-switch]==>[_param-switch=true]��������ͨ���ж�_param-switch�����Ƿ������ж�-switch�Ƿ����û���ֵ
::  ��value��    ["d:\in.jpg"]==>[_param-0=d:\in.jpg]�����ֲ���˳�����012...��ʶ
::ע��
::  key��ʽ������[-]��ͷ, �Һ������ֲ���Ϊ������
::  ��value�Ͳ����������ɷ����ڲ����б��е�����λ��, ������ͳһ���õ�����������; �Ҵ�value�Ͳ���ǰ������flag�Ͳ���
::  bat�б����������ִ�Сд, ��˲�������[-size -SIZE]����key
::���÷�ʽ
::  ------ demo.bat���� ------
::      call loadF.bat _params
::      call %_params% %*
::      set _param
::  ------ demo.bat���� ------
::  demo.bat -size -20 -flag -name bjc -len 10 "d:\in.jpg" "d:\out.jpg"
::  ������=====>
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
        ::key-value�Ͳ���
		set _param%_param_last_key%=%_param%& set _param_last_key=
	) else (
        ::��value�Ͳ���
		set _param-%_param_no_key_index%=%_param%& set /a _param_no_key_index+=1, _param_num+=1
	)
)
shift& goto :_param_loop