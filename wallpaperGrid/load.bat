@echo off& (if "%1"=="" goto :showExample)& (if "%1"=="0" goto :showDescript)& (if "%1"=="1" goto :searchFunction)
::Author[Allen]    ����[bjc5233@gmail.com]    �ۿ�[692008411]    words[�й�ͬ��Ȥ,�н���,��bug����ӭ����ϵ��Ŷ~]

::����
::  load.bat��Ҫ��Ϊ��ͳһ��������������д��
::  ���ڿ�ʼѧϰʹ������������ʱ��, �����ٶ����call���˽���10��, �������ڸ���bat��������д��ͬ��������������, 
::  ����ģ����Java�е��������д��load.bat, �������Լ���д����ʱ, ��Ҫ�õ��ĺ�������ŵ�������е���
::  ����ĸ������������󲿷������Լ�д��, �д������ռ���[��Ǹ����һһд����������]


::4�ֵ��÷�ʽ
::  �������ӳٱ���[setlocal enabledelayedexpansion]����֮ǰ ��������λ�ô��������ʾ��䡿
::  1.call load.bat                   �޲δ�ӡ����ʵ��[ʹ�õ�����clip]
::  2.call load.bat _fun1 _func2...   ����������������[����Ҫ������������Ϊ��������]
::  3.call load.bat 0 _fun1 _func2... ��ӡ��������˵��[����ָ������,���ӡ���к���˵��]
::  4.call load.bat 1 keyWord         ���ؼ���������������[����ָ��keyWord��ӡ���к����б�][ʹ�õ�����find ckey clip]


::��д��������ʱ�Ľ����ע���
::  1.�������ṹfor /f "tokens=1-9 delims= " %%1 in ("����1 ����2...") do setlocal enabledelayedexpansion..... endlocal
::                [              ��                  ] [       ��        ] [                  ��                           ]
::                            %_call%                    �û�����Ĳ���                   ��������
::  2.��д��������ʹ��˵��: ��һ��д��������, �ڶ���д����
::        ����������Ҫָ����������IN OUT IN-OUT, ����֮��һ����4���ո�, ��ѡ����ʹ��{}��Χ
::  2.ͨ�����������������Ҫ��[setlocal--endlocal]��Χ, ��ֹ�Ե����߻�����������Ӱ��
::  3.������������, ��Ҫ��֤[setlocal--endlocal]�ɶ�, ������ܻὫ�����߻�������ȫ�����
::  4.��������������������[if not defined _xxx call :_xxx]���ж�Ҫ���õ����������Ƿ��Ѿ�����, ��ֹ��ε��á�
::  5.�����߶�����������Ӱ��
::        �����������Է��ʵ������ߵı���, ��[setlocal--endlocal]��Χ�����������Ըñ������Ĳ���û��ֱ��Ӱ��, ������֮���ȡ���ı���ֵ����[����û�а�Χ\ ������endlocalʱ��ֵ]
::            set str=outer
::            echo [!str!]
::            %_test% ------------ setlocal enabledelayedexpansion& echo [!str!]& set str=inner& echo [!str!]& endlocal
::            echo [!str!]
::        ���������������Է��ʵ������߱���, ����ڽ������ַ��Ե���[set a=!a!b], ��������[set /a a+=1]ʱ, Ӧ�������ÿձ���[set a=]
::  6.�Ƿ�����������[isFolder]���Ƽ�д��
::        ͨ�������Ǵ��뵥������, �ڵ���֮��ͨ���ñ�����ֵʹ��if�����ж�, �����Ƽ�ʹ��_true\_false����������������[ʵ���������ͨ��errorlevelֵ�����ж�]
::        ��������д��: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ ȷ����Ϊ�����������һ��, ��Ҫ����if��������Ű�Χ
::        �����ߵ�д��: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true������ʹ�ö�����,ֻҪ��Χ��������


::���������ڵ���load.batǰ�Ƿ����ӳٱ���, ����ͨ��
set _positionCheck=0& if "!_positionCheck!"=="0" echo ����[setlocal enabledelayedexpansion]ǰ����load.bat& for /l %%i in () do pause>nul
(if not defined _call call :_call)& (for %%i in (%*) do call :%%i)
goto :EOF



:showExample
::��ʾ����ʵ��
call :_getLF& setlocal enabledelayedexpansion& mode 32,15
set "exampleStr=@echo off!LF!call load.bat _strlen!LF!setlocal enabledelayedexpansion!LF!!LF!set str=123��ð�!LF!%%_call%% ("str len") %%_strlen%%!LF!echo [^!str^!]���ַ�����: ^!len^!!LF!pause>nul"
echo ------������������ʵ��------& echo.& echo !exampleStr!& echo.& echo ------������������ʵ��------& echo.& echo.
set /p=��������Ƶ�������<nul& pause>nul& echo !exampleStr!>%temp%\exampleStr.temp& clip<%temp%\exampleStr.temp
goto :EOF

:showDescript
::��ӡָ����������˵��
setlocal enabledelayedexpansion
if "%2"=="" (
    set functionStrat=0
    for /f "delims=" %%i in (%~f0) do (
        if "%%i"==":_call" set functionStrat=1
        if !functionStrat!==1 set curLine=%%i& set prefix=!curLine:~0,2!& if "!prefix!"==":_" (echo.& echo !curLine:~1!) else (if "!prefix!"=="::" echo %%i)
    )
) else (
    for %%i in (%*) do if %%i NEQ %1 (
        echo %%i& set printFlag=0& for /f "delims=" %%j in (%~f0) do set curLine=%%j& (if !printFlag!==1 if "!curLine:~0,2!"=="::" (echo !curLine!) else (set printFlag=0))& (if /i "%%j"==":%%i" set printFlag=1)
        echo.& echo.
    )
)
pause>nul& goto :EOF

:searchFunction
call loadE.bat CurS CKey
::�г������Ѿ�������������\��������ָ���ַ�������������
(call :_getLF)& (call :_call)& (call :_checkDepend)
(%_call% ("CKey.exe") %_checkDepend%) || (echo ȱ��CKey.exe& pause>nul& goto :EOF)
setlocal enabledelayedexpansion
(for /f "delims=" %%i in (%~f0) do set curLine=%%i& if "!curLine:~0,2!"==":_" if "!curLine:~-1!" NEQ "_" echo !curLine:~1!)>>%temp%\functionList.tmp
if "%2"=="" (for /f "delims=" %%i in (%temp%\functionList.tmp) do set /a functionIndex+=1& set function_!functionIndex!=%%i& set function_!functionIndex!=%%i) else (title [%2]& for /f "skip=2 delims=" %%i in ('find /i "%2" %temp%\functionList.tmp') do set /a functionIndex+=1& set function_!functionIndex!=%%i)
del /q %temp%\functionList.tmp
if !functionIndex! LSS 1 echo �Ҳ�������[%2]�ĺ���& pause>nul& exit
set /a functionIndexMax=functionIndex, pointer=functionIndex/2, winWide=30, winHeight=functionIndexMax&  (if !pointer!==0 set pointer=1)& mode !winWide!, !winHeight!& %CurS% /crv 0
REM [1��]  [2��] [3Enter] [4Esc]
for /l %%i in () do (
    cls& set functionStr=& (for /l %%i in (1,1,!functionIndex!) do if %%i==!pointer!  (set functionStr=!functionStr!��  !function_%%i!!LF!) else (set functionStr=!functionStr!    !function_%%i!!LF!))& set /p "=_!functionStr:~0,-1!"<nul
    pause>nul& %CKey% 0 38 40 13& (if !errorlevel!==1 set /a pointerTemp=pointer-1)& (if !errorlevel!==2 set /a pointerTemp=pointer+1)& (if !errorlevel!==3 for %%i in (!pointer!) do set /p"=!function_%%i!"<nul | clip& exit)& (if !pointerTemp! GEQ 1 if !pointerTemp! LEQ !functionIndexMax! set pointer=!pointerTemp!)
)
goto :EOF







:_call
::�����в����������ĵ���ǰ׺
::����д��������ʱ���ݴ������������ѡ��汾, һ������¶����ð汾һ[�����в�����������9��]
::(%_call% ("arg1 arg2 arg3...") %_func%)        
::   �汾һ֧��[%%1--%%9]��9������
::   �汾��֧��[%%A--%%Z]��26������
set _call=for /f "tokens=1-9 delims= " %%1 in
set _call_=for /f "tokens=1-26 delims= " %%A in
goto :EOF


:_checkDepend
::������������·���Լ�path·�����Ƿ����ָ�����ļ�
::    ע��: ������������Щ��Ҫʹ�õ�����, Ӧ���ô˺�����������ĵ�����; ������һ��ϵͳЯ����exe��find�Ȳ����м��
::IN[�ļ���,������׺]
(call :_getLF)& (if not defined _true call :_true)& (if not defined _false call :_false)
set "_checkDepend=do setlocal enabledelayedexpansion& set path="%cd%"!LF!"%path:;="!LF!"%"& set flag=0& (for %%i in (!path!) do if exist %%~i\%%1 set flag=1)& (if "!flag!"=="1" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF




:_strlen
::�����ַ������ַ���
::�����ַ���������8192==>4096 2048 1024 512 256 128 64 32 16
::�����ַ���������4096==>2048 1024 512 256 128 64 32 16
::�����ַ���������2048==>1024 512 256 128 64 32 16
::IN[�ַ���������]    OUT[len]
set "_strlen=do setlocal enabledelayedexpansion& set $=!%%1!#& set N=& (for %%a in (2048 1024 512 256 128 64 32 16) do if !$:~%%a!. NEQ . set /a N+=%%a& set $=!$:~%%a!)& set $=!$!fedcba9876543210& set /a N+=0x!$:~16,1!& for %%i in (!N!) do endlocal& set /a %%2=%%i"& goto :EOF



:_strlen2
::�����ַ������ֽ���
::IN[�ַ���������]    OUT[len]
set "_strlen2=do setlocal enabledelayedexpansion& (>%temp%\str.tmp echo.!%%1!)& for %%i in (%temp%\str.tmp) do endlocal& set /a %%2=%%~zi-2" & goto :EOF



:_parseArray
::���������ַ���,������array={a,b}ת��Ϊ3������array.length=3, array[0]=a, array[1]=b, array.maxIndex=2
::IN[�����ַ���������]
::set "_parseArray=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do set arrayIndex=0& for %%j in (%%i) do (for %%k in (!arrayIndex!) do endlocal& set %%1[%%k]=%%j)& set /a arrayIndex+=1& setlocal enabledelayedexpansion)& for %%i in (!arrayIndex!) do endlocal& set %%1.length=%%i& set arrayIndex="& goto :EOF
set "_parseArray=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do set arrayIndex=0& for %%j in (%%i) do (for %%k in (!arrayIndex!) do endlocal& set %%1[%%k]=%%j)& set /a arrayIndex+=1& setlocal enabledelayedexpansion)& for %%i in (!arrayIndex!) do (set /a arrayMaxIndex=%%i-1& for %%j in (!arrayMaxIndex!) do endlocal& set %%1.length=%%i& set %%1.maxIndex=%%j& set arrayIndex=& set arrayMaxIndex=)"& goto :EOF


:_destoryArray
::��������Ԫ�ر���
::IN[�����ַ���������]
set "_destoryArray=do setlocal enabledelayedexpansion& set /a %%1.length-=1& (for %%i in (!%%1.length!) do for /l %%j in (0,1,%%i) do endlocal& set %%1[%%j]=& setlocal enabledelayedexpansion)& set %%1.length=& set %%1.maxIndex=& set %%1="& goto :EOF



:_parseJSON
::����JSON�ַ���,������json={name:��xx,age:24} ת��Ϊ array.length=2, array.name=��xx, array.age=24
::IN[JSON�ַ���������]
set "_parseJSON=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do for %%j in (%%i) do (for /f "tokens=1* delims=:" %%k in ("%%j") do endlocal& set %%1.%%k=%%l& set /a %%1.length+=1)& setlocal enabledelayedexpansion)& endlocal"& goto :EOF
:_destoryJSON
::����JSONԪ�ر���
::IN[JSON�ַ���������]
set "_destoryJSON=do (for /f "tokens=1 delims==" %%i in ('set %%1.') do set %%i=)& set %%1="& goto :EOF



:_isPureNum
::�Ƿ��Ǵ�����   ������: [(������������) && echo isPureNum || echo non-isPureNum]
::IN[�ַ���������]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isPureNum=do setlocal enabledelayedexpansion& (set /a flag=!%%~1!*1 >nul 2>nul)& (if "!flag!"=="!%%~1!" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF



:_getRandomNum
::ȡָ����Χ�ڵ������
::IN[��Сֵ]    IN[���ֵ]    OUT[�����]
set "_getRandomNum=do setlocal enabledelayedexpansion& for %%i in (!random!) do endlocal& set /a %%3=%%i%%"(%%2-%%1+1)"+%%1"& goto :EOF


:_getRandomNum2
::��ָ�����ַ�Χ�����ѡ��ָ�������ֵ�����
::IN[��Сֵ]    IN[���ֵ]    IN[ѡȡ����]    OUT[����������ַ���,�Կո�ָ�]
set "_getRandomNum2=do setlocal enabledelayedexpansion& set /a maxIndex=%%2-%%1& set numStr= & (for /l %%i in (%%1,1,%%2) do set numStr=!numStr!%%i )& (for /l %%i in (1,1,%%3) do set /a curIndex=!random!%%"(maxIndex+1)"& set numIndex=0& (for %%j in (!numStr!) do (if !curIndex!==!numIndex! set curNum=%%j)& set /a numIndex+=1)& (for %%j in (!curNum!) do set numStr=!numStr: %%j = !)& set /a maxIndex-=1& set pickNumStr=!pickNumStr!!curNum! )& for %%i in ("!pickNumStr!") do endlocal& set %%4=%%~i"& goto :EOF



:_getRandomColor
::��ȡһ�������ɫֵ
::OUT[�����ɫֵ]
if not defined _getRandomNum call :_getRandomNum
set "_getRandomColor=do setlocal enabledelayedexpansion& set colorStr=abcdef123456789& (%_call% ("0 14 index") %_getRandomNum%)& for %%i in (!index!) do set color=!colorStr:~%%i,1!& for %%j in (!color!) do endlocal& set %%1=0%%j"& goto :EOF

:_randomColor
::����һ�������ɫ
if not defined _getRandomColor call :_getRandomColor
set "_randomColor=setlocal enabledelayedexpansion& (%_call% ("color") %_getRandomColor%)& color !color!& endlocal"& goto :EOF

:_parseColor
::����������ɫֵ, ���޷�����ʱ��ӡ����֧�ֵ���ɫ
::IN[ԭʼ��ɫ�ַ�][���]    OUT[�������ɫ����][��C]
set "_parseColor=do setlocal enabledelayedexpansion& (if %%1==�� set c=0)& (if /i %%1==black set c=0)& (if %%1==�� set c=1)& (if /i %%1==blue set c=1)& (if %%1==�� set c=2)& (if /i %%1==green set c=2)& (if %%1==ˮ�� set c=3)& (if /i %%1==aqua set c=3)& (if %%1==�� set c=4)& (if /i %%1==red set c=4)& (if %%1==�� set c=5)& (if /i %%1==purple set c=5)& (if %%1==�� set c=6)& (if /i %%1==yellow set c=6)& (if %%1==�� set c=7)& (if /i %%1==white set c=7)& (if %%1==�� set c=8)& (if /i %%1==gray set c=8)& (if %%1==���� set c=9)& (if /i %%1==lightblue set c=9)& (if /i %%1==lblue set c=9)& (if %%1==���� set c=A)& (if /i %%1==lightgreen set c=A)& (if /i %%1==lgreen set c=A)& (if %%1==��ˮ�� set c=B)& (if /i %%1==lightaqua set c=B)& (if /i %%1==laqua set c=B)& (if %%1==���� set c=C)& (if /i %%1==lightred set c=C)& (if /i %%1==lred set c=C)& (if %%1==���� set c=D)& (if /i %%1==lightpurple set c=D)& (if /i %%1==lpurple set c=D)& (if %%1==���� set c=E)& (if /i %%1==lightyellow set c=E)& (if /i %%1==lyellow set c=E)& (if %%1==���� set c=F)& (if /i %%1==lightwhite set c=F)& (if /i %%1==lwhite set c=F)& (if "!c!"=="" set c=0& for %%i in (--�޷�����ָ����ɫ--- 0-��-black 1-��-blue 2-��-green 3-ˮ��-aqua 4-��-red 5-��-purple 6-��-yellow 7-��-white 8-��-gray 9-����-lightblue-lblue A-����-lightgreen-lgreen B-��ˮ��-lightaqua-laqua C-����-lightred-lred D-����-lightpurple-lpurple E-����-lightyellow-lyellow F-����-lightwhite-lwhite ---------------------) do echo %%i)& for %%i in (!c!) do endlocal& set %%2=%%i"& goto :EOF



:_downcase
::��д�ַ���תСд�ַ���
::IN[�ַ���������]      OUT[������ַ���]
set "_downcase=do setlocal enabledelayedexpansion& set str=!%%1!& (for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set str=!str:%%i=%%i!)& for %%i in (!str!) do endlocal& set %%2=%%i"& goto :EOF

:_upcase
::Сд�ַ���ת��д�ַ���
::IN[�ַ���������]      OUT[������ַ���]
set "_upcase=do setlocal enabledelayedexpansion& set str=!%%1!& (for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set str=!str:%%i=%%i!)& for %%i in (!str!) do endlocal& set %%2=%%i"& goto :EOF



:_px2colsLines
::����ֵתcmd��ȸ߶�ֵ    cmdĬ��[��������8x16], ��ÿ���ַ���8�����ؿ�16�����ظ�
::IN[pxWidth]    IN[pxHeight]    OUT[cols]    OUT[lines]    {IN[�����С][�鿴��������ѡ�]}
set "_px2colsLines=do setlocal enabledelayedexpansion& (if "%%5"=="" (set fontSize=8x16) else (set fontSize=%%5))& (for /f "tokens=1,2 delims=x" %%i in ("!fontSize!") do set /a mod=%%1%%%%i& (if !mod!==0 (set offset=0) else (set offset=1))& set /a cols=%%1/%%i+offset& set /a mod=%%2%%%%j& (if !mod!==0 (set offset=0) else (set offset=1))& set /a lines=%%2/%%j+offset)& for /f "tokens=1,2 delims= " %%i in ("!cols! !lines!") do endlocal& set /a %%3=%%i, %%4=%%j"& goto :EOF

:_colsLines2px
::cmd��ȸ߶�ֵת����ֵ    cmdĬ��[��������8x16], ��ÿ���ַ���8�����ؿ�16�����ظ�
::IN[cols]    IN[lines]    OUT[pxWidth]    OUT[pxHeight]    {IN[�����С][�鿴��������ѡ�]}
set "_colsLines2px=do setlocal enabledelayedexpansion& (if "%%5"=="" (set fontSize=8x16) else (set fontSize=%%5))& for /f "tokens=1,2 delims=x" %%i in ("!fontSize!") do endlocal& set /a %%3=%%1*%%i, %%4=%%2*%%j"& goto :EOF

:_getColsLines
::�õ���ǰcmd��Ļ��ȸ߶�ֵ
::OUT[cols]    OUT[lines]
set "_getColsLines=do for /f "tokens=1,3 delims=: " %%i in ('mode') do (if "%%i"=="��" set %%2=%%j)& (if "%%i"=="��" set %%1=%%j)"& goto :EOF



:_buildFile
::�������ļ�, 0�ֽ�, �ļ���û���κ�����
::    ע��:echo.>1.txt��ʽ�����Ĳ��ǿ��ļ�
::IN[�ļ���]
set "_buildFile=do cd.>%%1"& goto :EOF


:_getFileName
::�����ļ�·���ַ����õ��ļ���
::IN[�ļ�·��������]    OUT[�ļ���]    {OUT[�ļ���չ��]}
set "_getFileName=do setlocal enabledelayedexpansion& for %%i in ("!%%~1!") do endlocal& set %%2=%%~ni& if "%%3" NEQ "" set %%3=%%~xi"& goto :EOF


:_getFileLine
::����ָ���ļ�����[���Կ���]
::IN[�ļ���]    OUT[�ļ�����]
set "_getFileLine=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%j in (%%1) do set /a line+=1)& for %%i in (!line!) do endlocal& set %%2=%%i"& goto :EOF
:_getFileLine2
::IN[�ļ�·��������]    OUT[�ļ�����]
set "_getFileLine2=do setlocal enabledelayedexpansion& (for %%i in ("!%%~1!") do for /f "eol= delims=" %%j in (%%~si) do set /a line+=1)& for %%i in (!line!) do endlocal& set %%2=%%i"& goto :EOF



:_getFileSize
::����ָ���ļ���С, ��λbyte
::IN[�ļ�·��������]   OUT[�ļ���С]
set "_getFileSize=do setlocal enabledelayedexpansion& for %%i in ("!%%~1!") do for %%j in (%%~si) do endlocal& set %%2=%%~zj"& goto :EOF

:_isFolder
::�Ƿ����ļ���       [%���ñ��ʽ% && echo folder || echo file]
::IN[�ļ���·��������]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isFolder=do setlocal enabledelayedexpansion& (if exist "!%%1!\" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF



:_uniqueStr
::ʹ�õ�ǰ����ʱ��õ�һ��Ψһ���ַ���
::OUT[Ψһ�ַ���]
set "_uniqueStr=do setlocal enabledelayedexpansion& for /f "tokens=1-7 delims=/:." %%i in ("!date:~0,10!:!time: =0!") do endlocal& set %%1=%%i%%j%%k%%l%%m%%n%%o"& goto :EOF




:_getCR
::�õ��س���Carriage Return, ����֮��ʹ��Լ������CR, �����߿����ӳٱ���ʹ��[!CR!], δ�����ӳٱ����޷�����
(for /f %%i in ('copy /Z "%~dpf0" nul') do set CR=%%i)& goto :EOF

:_getLF
::�õ����з�Line Feed[����], ����֮��ʹ��Լ������LF\LF_, �����߿����ӳٱ���ʹ��[!LF! \ %LF_%], δ�����ӳٱ���ʹ��[%LF_%]
set LF=^


set LF_=^^^%LF%%LF%^%LF%%LF%& goto :EOF

:_getTab
::�õ�Tab��, ����֮��ʹ��Լ������Tab, �����߿����ӳٱ���ʹ��[!Tab! \ %Tab%], δ�����ӳٱ���ʹ��[%Tab%]
set Tab=	& goto :EOF

:_getBS
::�õ��˸��, ����֮��ʹ��Լ������Tab, �����߿����ӳٱ���ʹ��[!BS! \ %BS%], δ�����ӳٱ���ʹ��[%BS%]
(for /f %%i in ('"prompt $h&for %%i in (1) do rem"') do set BS=%%i)& goto :EOF



:_speak
::�����speak����  ����%temp%Ŀ¼����tool_speak.vbs
::IN[���ֱ�����]
set "_speak=do setlocal enabledelayedexpansion& (if not exist %temp%\tool_speak.vbs echo CreateObject^("SAPI.SpVoice"^).Speak^(Wscript.Arguments^(0^)^)>%temp%\tool_speak.vbs)& for /f "delims=" %%i in ("!%%1!") do call %temp%\tool_speak.vbs "%%~i""& goto :EOF



:_getScreenSize
::��ȡ��ʾ����Ļ��С
::OUT[���]    OUT[�߶�]
set "_getScreenSize=do for /f "tokens=1,2 delims==" %%i in ('wmic DESKTOPMONITOR where Status^='ok' get ScreenWidth^,ScreenHeight /VALUE') do (if "%%i"=="ScreenWidth" set %%1=%%j)& (if "%%i"=="ScreenHeight" set %%2=%%j)"& goto :EOF


:_getDeskWallpaperPath
::��ȡ�����ֽ·��
::OUT[�����ֽ·��]
set "_getDeskWallpaperPath=do for /f "skip=2 tokens=2* delims= " %%i in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallPaper') do set %%1=%%j"& goto :EOF



:_roundFloat
::��������
::IN[ԭʼ���������ַ���]    IN[��ȷС��λ��]    OUT[����󸡵������ַ���]
set "_roundFloat=do setlocal enabledelayedexpansion& for /f "tokens=1,2 delims=." %%i in ("%%1") do if "%%j" NEQ "" (set integerPart=%%i& set decimalPart=%%j& set boundaryNum=!decimalPart:~%%2,1!& set decimalPart=!decimalPart:~0,%%2!& (if "!boundaryNum!" NEQ "" if !boundaryNum! GEQ 5 if "!decimalPart!"=="" (set /a integerPart+=1) else (set /a decimalPart+=1))& for /f "tokens=1,2 delims= " %%k in ("!integerPart! !decimalPart!") do endlocal& if "%%l"=="" (set %%3=%%k) else (set %%3=%%k.%%l)) else (endlocal& set %%3=%%i)"& goto :EOF



:_infiniteLoopPause
::����pause>nul, һ������bat��β, �û�ֻ���ֶ��رմ���
set "_infiniteLoopPause=for /l %%i in () do pause>nul"& goto :EOF

:_infiniteLoopSome
::���޴����û�ָ������,    ʹ��˫���Ű�Χÿ������, ����֮���Կո�ָ�          set some="echo ok" "pause" "set /a count+=1" "echo ^!count^!"& %_call% ("some") %_infiniteLoopSome%
::IN[ָ�������ַ���������]
set "_infiniteLoopSome=do setlocal enabledelayedexpansion& (for /l %%i in () do for %%j in (!%%1!) do %%~j)& endlocal"& goto :EOF



:_trimStrLeft
::�����ַ������Ƴ���ո�
::IN-OUT[�ַ���������]
set "_trimStrLeft=do setlocal enabledelayedexpansion& for /f "tokens=* delims= " %%i in ("!%%~1!") do set %%1=%%i"& goto :EOF

:_trimStrRight
::�����ַ������Ƴ��ҿո�
::IN-OUT[�ַ���������]
if not defined _strlen call :_strlen
set "_trimStrRight=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set str=!%%1!& (for /l %%i in (1,1,!len!) do if "!str:~-1,1!"==" " set "str=!str:~0,-1!")& for %%i in ("!str!") do endlocal& set "%%1=%%~i""& goto :EOF

:_trimStr
::�����ַ������Ƴ����ҿո�
::IN-OUT[�ַ���������]
(if not defined _trimStrLeft call :_trimStrLeft)& (if not defined _trimStrRight call :_trimStrRight)
set "_trimStr=do (%_call% ("%%1") %_trimStrLeft%)& (%_call% ("%%1") %_trimStrRight%)"& goto :EOF


:_reverseStr
::���ַ���������
::IN[�ַ���������]     OUT[������ַ���]
if not defined _strlen call :_strlen
set "_reverseStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "str=!%%1!"& set /a len-=1& (for /l %%i in (0,1,!len!) do set str2=!str:~%%i,1!!str2!)& for %%i in ("!str2!") do endlocal& set "%%2=%%~i""& goto :EOF



:_shuffleStr
::���ַ���������
::IN[�ַ���������]     OUT[������ַ���]
(if not defined _strlen call :_strlen)& (if not defined _getRandomNum call :_getRandomNum)
set "_shuffleStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "str=!%%1!"& set /a len-=1& (for /l %%i in (0,1,!len!) do (%_call% ("0 !len! index") %_getRandomNum%)& set /a index2=index+1& for /f "tokens=1,2 delims= " %%j in ("!index! !index2!") do set str2=!str2!!str:~%%j,1!& set str=!str:~0,%%j!!str:~%%k!& set /a len-=1)& for %%i in ("!str2!") do endlocal& set "%%2=%%~i""& goto :EOF



:_true
::�õ�һ����ʶ�ɹ���ֵ(errorlevelΪ0), ����֮��ʹ��Լ������_true��ע��ֻ��ʹ��%_true%, ����ʹ��!_true!, ԭ��δ֪
::  1.Ƕ��call���ã�����call��������ʹ��, ����call����ͬ����һ���Ƿ�ķ���ֵ
::        call :test && echo true || echo false
::        :test
::        %_true%& goto :EOF
::  2.Ƕ��������������
::        ��������д��: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ ȷ����Ϊ�����������һ��, ��Ҫ����if��������Ű�Χ
::        �����ߵ�д��: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true������ʹ�ö�����,ֻҪ��Χ��������
set "_true=echo.>nul"& goto :EOF
:_false
::�õ�һ����ʶʧ�ܵ�ֵ(errorlevel����0), ����֮��ʹ��Լ������_false��ע��ֻ��ʹ��%_false%, ����ʹ��!_false!, ԭ��δ֪
::  1.Ƕ��call���ã�����call��������ʹ��, ����call����ͬ����һ���Ƿ�ķ���ֵ
::        call :test && echo true || echo false
::        :test
::        %_false%& goto :EOF
::  2.Ƕ��������������
::        ��������д��: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ ȷ����Ϊ�����������һ��, ��Ҫ����if��������Ű�Χ
::        �����ߵ�д��: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true������ʹ�ö�����,ֻҪ��Χ��������
set "_false=set=2>nul"& goto :EOF



:_parseBlockNum
::���������ַ���ΪbolckNum��ʽ, �ɽ����ַ�[���� +-*/], ��δ֪�ַ�ʹ�ÿո����
::IN[�����ַ���������]    IN-OUT[������ַ���������]    OUT[������ַ�������]
if not defined _strlen call :_strlen
set "_parseBlockNum=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "numStr=!%%1!"& set /a len-=1& (for /l %%i in (1,1,5) do set line%%i=)& (for /l %%i in (0,1,!len!) do set char=!numStr:~%%i,1!& set blockChar=& ((if "!char!"=="0" set blockChar=������ #��  �� #��  �� #��  �� #������ )& (if "!char!"=="1" set blockChar= ��  # ��  # ��  # ��  # ��  )& (if "!char!"=="2" set blockChar=������ #    �� #������ #��     #������ )& (if "!char!"=="3" set blockChar=������ #    �� #������ #    �� #������ )& (if "!char!"=="4" set blockChar=��  �� #��  �� #������ #    �� #    �� )& (if "!char!"=="5" set blockChar=������ #��     #������ #    �� #������ )& (if "!char!"=="6" set blockChar=������ #��     #������ #��  �� #������ )& (if "!char!"=="7" set blockChar=������ #    �� #    �� #    �� #    �� )& (if "!char!"=="8" set blockChar=������ #��  �� #������ #��  �� #������ )& (if "!char!"=="9" set blockChar=������ #��  �� #������ #    �� #������ )& (if "!char!"=="." set blockChar=   #   #   #   #�� )& (if "!char!"==":" set blockChar=   #�� #   #�� #   )& (if "!char!"=="+" set blockChar=       #  ��   #������ #  ��   #       )& (if "!char!"=="-" set blockChar=       #       #������ #       #       )& (if "!char!"=="*" set blockChar=       #��  �� #  ��   #��  �� #       )& (if "!char!"=="/" set blockChar=      #   �� #  ��  # ��   #      )& (if "!char!"=="=" set blockChar=       #������ #       #������ #       )& (if "!blockChar!"=="" set blockChar= # # # # ))& for /f "tokens=1-5 delims=#" %%j in ("!blockChar!") do set line1=!line1!%%j& set line2=!line2!%%k& set line3=!line3!%%l& set line4=!line4!%%m& set line5=!line5!%%n)& for /f "tokens=1-5 delims=#" %%i in ("!line1!#!line2!#!line3!#!line4!#!line5!") do endlocal& set %%2_1=%%i& set %%2_2=%%j& set %%2_3=%%k& set %%2_4=%%l& set %%2_5=%%m& set %%3=5"& goto :EOF

:_parseShowBlockNum
::���������ַ���ΪbolckNum��ʽ, ����ʾ, �ɽ����ַ�[���� +-*/], ��δ֪�ַ�ʹ�ÿո����
::IN[�����ַ���������]    {IN[��ǰ׺]}    {IN[�к�׺]}
(if not defined _parseBlockNum call :_parseBlockNum)& (if not defined _showBlockASCII call :_showBlockASCII)
set "_parseShowBlockNum=do setlocal enabledelayedexpansion& (%_call% ("%%1 numStr numLine") %_parseBlockNum%)& (%_call% ("numStr numLine %%2 %%3") %_showBlockASCII%)& endlocal"& goto :EOF

:_parseShowBlockNum2
::���������ַ���ΪbolckNum��ʽ, ����ʾ, �ɽ����ַ�[���� �ո� +-*/], ��δ֪�ַ�ʹ�ÿո����
::IN[�����ַ���������]    {IN[��ǰ׺������]}    {IN[�к�׺������]}
(if not defined _parseBlockNum call :_parseBlockNum)& (if not defined _showBlockASCII2 call :_showBlockASCII2)
set "_parseShowBlockNum2=do setlocal enabledelayedexpansion& (%_call% ("%%1 numStr numLine") %_parseBlockNum%)& (%_call% ("numStr numLine %%2 %%3") %_showBlockASCII2%)& endlocal"& goto :EOF



:_parseASCIIStr
::�����ַ���תΪASCII��ʽ, �ɽ����ַ�[Ӣ�Ĵ�Сд ���� �ո� ~@#$*(-_+=[]{}\:;'.,?/], ��δ֪�ַ�ʹ�ÿո����
::    ע��: ��д��ĸ\����������figlet��banner3.flf������Ϊ������Сд��ĸ����xhelv.flf������Ϊ�����޸Ķ�������bat��һЩ�����ַ����ܴ���! % & ) | " <> ^
::    ע��: �����������в���ѹ������, bat�б���ֵ��󳤶���8189���ַ�, ��ѹ���򳤶��򳬹�����
::          ѹ����ʽ[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]������ο�C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[�ַ���������]    IN-OUT[������ַ���������]    OUT[������ַ�������]
if not defined _strlen call :_strlen
set "_parseASCIIStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "asciiStr=!%%1!"& set /a len-=1& (for /l %%i in (1,1,7) do set line%%i=)& (for /l %%i in (0,1,!len!) do set c=!asciiStr:~%%i,1!& set c2=& ((if "!c!"=="~" set c2=K$K$A4F$2B2B2A$E4B$K$K)& (if "!c!"=="@" set c2=A7B$2E2A$2A3A2A$2A3A2A$2A5B$2H$A7B)& (if "!c!"=="#" set c2=B2A2C$B2A2C$9A$B2A2C$9A$B2A2C$B2A2C)& (if "!c!"=="$" set c2=A8B$2B2B2A$2B2E$A8B$D2B2A$2B2B2A$A8B)& (if "!c!"=="*" set c2=J$A2C2B$B2A2C$9A$B2A2C$A2C2B$J)& (if "!c!"=="(" set c2=B3A$A2C$2D$2D$2D$A2C$B3A)& (if "!c!"=="-" set c2=H$H$H$7A$H$H$H)& (if "!c!"=="_" set c2=H$H$H$H$H$H$7A)& (if "!c!"=="+" set c2=G$B2C$B2C$6A$B2C$B2C$G)& (if "!c!"=="=" set c2=F$F$5A$F$5A$F$F)& (if "!c!"=="[" set c2=6A$2E$2E$2E$2E$2E$6A)& (if "!c!"=="]" set c2=6A$D2A$D2A$D2A$D2A$D2A$6A)& (if "!c!"=="{" set c2=B4A$A2D$A2D$3D$A2D$A2D$B4A)& (if "!c!"=="}" set c2=4C$C2B$C2B$C3A$C2B$C2B$4C)& (if "!c!"=="\" set c2=2G$A2F$B2E$C2D$D2C$E2B$F2A)& (if "!c!"==":" set c2=E$4A$4A$E$4A$4A$E)& (if "!c!"==";" set c2=4A$4A$E$4A$4A$A2B$2C)& (if "!c!"=="'" set c2=4A$4A$A2B$E$E$E$E)& (if "!c!"=="." set c2=D$D$D$D$D$3A$3A)& (if "!c!"=="," set c2=E$E$E$4A$4A$A2B$2C)& (if "!c!"=="?" set c2=A7B$2E2A$F2B$D3C$C2E$J$C2E)& (if "!c!"=="/" set c2=F2A$E2B$D2C$C2D$B2E$A2F$2G)& (if "!c!"=="0" set c2=B5C$A2C2B$2E2A$2E2A$2E2A$A2C2B$B5C)& (if "!c!"=="1" set c2=C2C$A4C$C2C$C2C$C2C$C2C$A6A)& (if "!c!"=="2" set c2=A7B$2E2A$G2A$A7B$2H$2H$9A)& (if "!c!"=="3" set c2=A7B$2E2A$G2A$A7B$G2A$2E2A$A7B)& (if "!c!"=="4" set c2=2H$2D2B$2D2B$2D2B$9A$F2B$F2B)& (if "!c!"=="5" set c2=8A$2G$2G$7B$F2A$2D2A$A6B)& (if "!c!"=="6" set c2=A7B$2E2A$2H$8B$2E2A$2E2A$A7B)& (if "!c!"=="7" set c2=8A$2D2A$D2C$C2D$B2E$B2E$B2E)& (if "!c!"=="8" set c2=A7B$2E2A$2E2A$A7B$2E2A$2E2A$A7B)& (if "!c!"=="9" set c2=A7B$2E2A$2E2A$A8A$G2A$2E2A$A7B)& (if "!c!"=="a" set c2=H$A4C$D2B$A5B$2B2B$A4A1A$H)& (if "!c!"=="b" set c2=2F$2F$2A3B$3B2A$3B2A$2A3B$H)& (if "!c!"=="c" set c2=G$A4B$2B2A$2E$2B2A$A4B$G)& (if "!c!"=="d" set c2=D2A$D2A$A5A$2B2A$2B2A$A5A$G)& (if "!c!"=="e" set c2=G$A4B$2B2A$6A$2E$A5A$G)& (if "!c!"=="f" set c2=A3A$A2B$4A$A2B$A2B$A2B$E)& (if "!c!"=="g" set c2=H$A5B$2C2A$2C2A$A6A$E2A$A5B)& (if "!c!"=="h" set c2=2E$2E$5B$2B2A$2B2A$2B2A$G)& (if "!c!"=="i" set c2=2A$C$2A$2A$2A$2A$C)& (if "!c!"=="j" set c2=A2A$D$A2A$A2A$A2A$A2A$2B)& (if "!c!"=="k" set c2=2E$2B2A$2A2B$4C$2A2B$2B2A$G)& (if "!c!"=="l" set c2=2A$2A$2A$2A$2A$2A$C)& (if "!c!"=="m" set c2=K$A3A4B$2B2B2A$2B2B2A$2B2B2A$2B2B2A$K)& (if "!c!"=="n" set c2=H$A5B$2C2A$2C2A$2C2A$2C2A$H)& (if "!c!"=="o" set c2=H$A5B$2C2A$2C2A$2C2A$A5B$H)& (if "!c!"=="p" set c2=H$6B$2C2A$2C2A$6B$2F$2F)& (if "!c!"=="q" set c2=H$B5A$2C2A$2C2A$A6A$E2A$E2A)& (if "!c!"=="r" set c2=F$2A2A$2A1B$3C$2D$2D$F)& (if "!c!"=="s" set c2=G$A4B$2E$A4B$D2A$A4B$G)& (if "!c!"=="t" set c2=E$A2B$4A$A2B$A2B$A3A$E)& (if "!c!"=="u" set c2=G$2B2A$2B2A$2B2A$2B2A$A3A1A$G)& (if "!c!"=="v" set c2=H$2C2A$2C2A$A2A2B$A2A2B$C1D$H)& (if "!c!"=="w" set c2=K$2B2B2A$A2A2A2B$A2A2A2B$B2B2C$C1B1D$K)& (if "!c!"=="x" set c2=I$2D2A$A2B2B$C2D$A2B2B$2D2A$I)& (if "!c!"=="y" set c2=H$2C2A$2B2B$A4C$B2D$A2E$2F)& (if "!c!"=="z" set c2=G$6A$C2B$B2C$A2D$6A$G)& (if "!c!"=="A" set c2=C3D$B2A2C$A2C2B$2E2A$9A$2E2A$2E2A)& (if "!c!"=="B" set c2=8B$2E2A$2E2A$8B$2E2A$2E2A$8B)& (if "!c!"=="C" set c2=A6B$2D2A$2G$2G$2G$2D2A$A6B)& (if "!c!"=="D" set c2=8B$2E2A$2E2A$2E2A$2E2A$2E2A$8B)& (if "!c!"=="E" set c2=8A$2G$2G$6C$2G$2G$8A)& (if "!c!"=="F" set c2=8A$2G$2G$6C$2G$2G$2G)& (if "!c!"=="G" set c2=A6C$2D2B$2H$2C4A$2D2B$2D2B$A6C)& (if "!c!"=="H" set c2=2E2A$2E2A$2E2A$9A$2E2A$2E2A$2E2A)& (if "!c!"=="I" set c2=4A$A2B$A2B$A2B$A2B$A2B$4A)& (if "!c!"=="J" set c2=F2A$F2A$F2A$F2A$2D2A$2D2A$A6B)& (if "!c!"=="K" set c2=2D2A$2C2B$2B2C$5D$2B2C$2C2B$2D2A)& (if "!c!"=="L" set c2=2G$2G$2G$2G$2G$2G$8A)& (if "!c!"=="M" set c2=2E2A$3C3A$4A4A$2A3A2A$2E2A$2E2A$2E2A)& (if "!c!"=="N" set c2=2D2A$3C2A$4B2A$2A2A2A$2B4A$2C3A$2D2A)& (if "!c!"=="O" set c2=A7B$2E2A$2E2A$2E2A$2E2A$2E2A$A7B)& (if "!c!"=="P" set c2=8B$2E2A$2E2A$8B$2H$2H$2H)& (if "!c!"=="Q" set c2=A7B$2E2A$2E2A$2E2A$2B2A2A$2D2B$A5A2A)& (if "!c!"=="R" set c2=8B$2E2A$2E2A$8B$2C2C$2D2B$2E2A)& (if "!c!"=="S" set c2=A6B$2D2A$2G$A6B$F2A$2D2A$A6B)& (if "!c!"=="T" set c2=8A$C2D$C2D$C2D$C2D$C2D$C2D)& (if "!c!"=="U" set c2=2E2A$2E2A$2E2A$2E2A$2E2A$2E2A$A7B)& (if "!c!"=="V" set c2=2E2A$2E2A$2E2A$2E2A$A2C2B$B2A2C$C3D)& (if "!c!"=="W" set c2=2F2A$2B2B2A$2B2B2A$2B2B2A$2B2B2A$2B2B2A$A3B3B)& (if "!c!"=="X" set c2=2E2A$A2C2B$B2A2C$C3D$B2A2C$A2C2B$2E2A)& (if "!c!"=="Y" set c2=2D2A$A2B2B$B4C$C2D$C2D$C2D$C2D)& (if "!c!"=="Z" set c2=8A$E2B$D2C$C2D$B2E$A2F$8A)& (if "!c2!"=="" set c2=C$C$C$C$C$C$C))& ((set c2=!c2:K=           !)& (set c2=!c2:J=          !)& (set c2=!c2:I=         !)& (set c2=!c2:H=        !)& (set c2=!c2:G=       !)& (set c2=!c2:F=      !)& (set c2=!c2:E=     !)& (set c2=!c2:D=    !)& (set c2=!c2:C=   !)& (set c2=!c2:B=  !)& (set c2=!c2:A= !)& (set c2=!c2:9=#########!)& (set c2=!c2:8=########!)& (set c2=!c2:7=#######!)& (set c2=!c2:6=######!)& (set c2=!c2:5=#####!)& (set c2=!c2:4=####!)& (set c2=!c2:3=###!)& (set c2=!c2:2=##!)& (set c2=!c2:1=#!))& for /f "tokens=1-7 delims=$" %%j in ("!c2!") do set line1=!line1!%%j& set line2=!line2!%%k& set line3=!line3!%%l& set line4=!line4!%%m& set line5=!line5!%%n& set line6=!line6!%%o& set line7=!line7!%%p)& for /f "tokens=1-7 delims=$" %%i in ("!line1!$!line2!$!line3!$!line4!$!line5!$!line6!$!line7!") do endlocal& set %%2_1=%%i& set %%2_2=%%j& set %%2_3=%%k& set %%2_4=%%l& set %%2_5=%%m& set %%2_6=%%n& set %%2_7=%%o& set %%3=7"& goto :EOF

:_parseShowASCIIStr
::�����ַ���תΪASCII��ʽ, ����ʾ, �ɽ����ַ�[Ӣ�Ĵ�Сд ���� �ո� ~@#$*(-_+=[]{}\:;'.,?/], ��δ֪�ַ�ʹ�ÿո����
::    ע��: ��д��ĸ\����������figlet��banner3.flf������Ϊ������Сд��ĸ����xhelv.flf������Ϊ�����޸Ķ�������bat��һЩ�����ַ����ܴ���! % & ) | " <> ^
::    ע��: �����������в���ѹ������, bat�б���ֵ��󳤶���8189���ַ�, ��ѹ���򳤶��򳬹�����
::          ѹ����ʽ[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]������ο�C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[�ַ���������]      {IN[��ǰ׺]}      {IN[�к�׺]}
(if not defined _parseASCIIStr call :_parseASCIIStr)& (if not defined _showBlockASCII call :_showBlockASCII)
set "_parseShowASCIIStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 asciiStr asciiLine") %_parseASCIIStr%)& (%_call% ("asciiStr asciiLine %%2 %%3") %_showBlockASCII%)& endlocal"& goto :EOF

:_parseShowASCIIStr2
::�����ַ���תΪASCII��ʽ, ����ʾ, �ɽ����ַ�[Ӣ�Ĵ�Сд ���� �ո� ~@#$*(-_+=[]{}\:;'.,?/], ��δ֪�ַ�ʹ�ÿո����
::    ע��: ��д��ĸ\����������figlet��banner3.flf������Ϊ������Сд��ĸ����xhelv.flf������Ϊ�����޸Ķ�������bat��һЩ�����ַ����ܴ���! % & ) | " <> ^
::    ע��: �����������в���ѹ������, bat�б���ֵ��󳤶���8189���ַ�, ��ѹ���򳤶��򳬹�����
::          ѹ����ʽ[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]������ο�C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[�ַ���������]      {IN[��ǰ׺������]}      {IN[�к�׺������]}
(if not defined _parseASCIIStr call :_parseASCIIStr)& (if not defined _showBlockASCII2 call :_showBlockASCII2)
set "_parseShowASCIIStr2=do setlocal enabledelayedexpansion& (%_call% ("%%1 asciiStr asciiLine") %_parseASCIIStr%)& (%_call% ("asciiStr asciiLine %%2 %%3") %_showBlockASCII2%)& endlocal"& goto :EOF


:_showBlockASCII
::��ʾbolckNum\ ASCIIStr�ַ���
::IN[�ַ���������]    IN[����������]    {IN[��ǰ׺]}    {IN[�к�׺]}
set "_showBlockASCII=do setlocal enabledelayedexpansion& (for /l %%i in (1,1,!%%2!) do echo.%%3!%%1_%%i!%%4)& endlocal"& goto :EOF
:_showBlockASCII2
::��ʾbolckNum\ ASCIIStr�ַ���
::IN[�ַ���������]    IN[����������]    {IN[��ǰ׺������]}    {IN[�к�׺������]}
set "_showBlockASCII2=do setlocal enabledelayedexpansion& (for /l %%i in (1,1,!%%2!) do echo.!%%3!!%%1_%%i!!%%4!)& endlocal"& goto :EOF


:_playMusicMini
::ָ�������������ּ�, ��Ҫ����gplay.exe֧��
::IN[musicPaths][·���пո��˫����][���·��ʹ�ÿո���]    IN[times][��д����0��ʾѭ��]
call loadE.bat gplay
(if not defined _checkDepend call :_checkDepend)
(%_call% ("gplay.exe") %_checkDepend%) || (echo ȱ��gplay.exe& pause>nul& goto :EOF)
set "_playMusicMini=do setlocal enabledelayedexpansion& (if "%%2"=="" (set times=) else (if %%2==0 (set times=) else (set times=1,1,%%2)))& (for /l %%i in (!times!) do %gplay% !%%1!>nul 2>nul)& endlocal"& goto :EOF

:_playMusic
::ָ������ģʽ�������ּ�, ��Ҫgplay.exe֧��
::IN[musicPaths][·���пո��˫����][���·��ʹ�ÿո���]    IN[mode][��������0\����ѭ��1\˳�򲥷�2\ѭ������3\�������4]
call loadE.bat gplay
(if not defined _checkDepend call :_checkDepend)& (%_call% ("gplay.exe") %_checkDepend%) || (echo ȱ��gplay.exe& pause>nul& goto :EOF)
if not defined _getRandomNum call :_getRandomNum
set "_playMusic=do setlocal enabledelayedexpansion& (if "%%2"=="" (set mode=0) else (set mode=%%2))& (if !mode!==0 set times=1,1,1& set musicPath=& for %%i in (!%%1!) do if not defined musicPath set musicPath=%%i)& (if !mode!==1 set times=& set musicPath=& for %%i in (!%%1!) do if "!musicPath!"=="" set musicPath=%%i)& (if !mode!==2 set times=1,1,1& set musicPath=!%%1!)& (if !mode!==3 set times=& set musicPath=!%%1!)& (if !mode!==4 set times=& set musicPath=!%%1!& set musicIndex=0& (for %%i in (!%%1!) do set /a musicIndex+=1& set musicPath_!musicIndex!=%%i)& set musicIndexMax=!musicIndex!)& (for /l %%i in (!times!) do (if !mode!==4 (%_call% ("1 !musicIndexMax! musicIndex") %_getRandomNum%)& for %%j in (!musicIndex!) do set musicPath=!musicPath_%%j!)& %gplay% !musicPath!>nul 2>nul)& endlocal"& goto :EOF



:_setFontSize
::�޸�cmd���������С   Ŀǰֻ֧��[��������]
::    ע��:ע�����FontSize�ֶ�[����λΪ�ָ�, ����λΪ�ֿ�], ��00100008���������x��=16����08Hx10H=10����8��16
::IN[�����x��][8x16]
set "_setFontSize=do setlocal enabledelayedexpansion& set fontSize=& (if %%1==3x5 set fontSize=0x00050003)& (if %%1==5x8 set fontSize=0x00080005)& (if %%1==6x12 set fontSize=0x000c0006)& (if %%1==8x16 set fontSize=0x00100008)& (if %%1==8x18 set fontSize=0x00120008)& (if %%1==10x20 set fontSize=0x0014000a)& (if defined fontSize reg add "HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe" /v "FontSize" /t REG_DWORD /d !fontSize! /f >nul)"& goto :EOF



:_setWallpaper
::���������ֽ  ����%temp%Ŀ¼����tool_setWallpaper.vbs
::IN[��ֽ·��������]
set "_setWallpaper=do setlocal enabledelayedexpansion& (if not exist %temp%\tool_setWallpaper.vbs (echo Dim shApp, picFile, items& echo Set shApp = CreateObject^("Shell.Application"^)& echo Set picFile = CreateObject^("Scripting.FileSystemObject"^).GetFile^(Wscript.Arguments^(0^)^)& echo Set items = shApp.NameSpace^(picFile.ParentFolder.Path^).ParseName^(picFile.Name^).Verbs& echo For Each item In items& echo   If item.Name = "����Ϊ���汳��(^&B)" Then item.DoIt& echo Next& echo WScript.Sleep 3000)>%temp%\tool_setWallpaper.vbs)& for /f "delims=" %%i in ("!%%1!") do call %temp%\tool_setWallpaper.vbs "%%~i""& goto :EOF



:_readConfig
::��ȡָ�������ļ�ָ��keyֵ      �������ļ��ж�����Ϊkey��ֵ, ���value��������, ��ֵ���õ�value��, �������õ�key��
::    ע��:for����ȡ�ļ�ʱĬ������;��ͷ����, ���;��ͷ���п�����Ϊע��
::IN[�����ļ�·��]    IN[key]    {OUT[value������]}
set "_readConfig=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do if %%i==%%2 endlocal& if "%%3" EQU "" (set "%%2=%%j") else (set "%%3=%%j")"& goto :EOF

:_readConfigMulti
::��ȡָ�������ļ�ָ���Ķ��keyֵ      �������ļ��ж�����Ϊkey��ֵ, ���value��������, ��ֵ���õ�value��, �������õ�key��
::    ע��:for����ȡ�ļ�ʱĬ������;��ͷ����, ���;��ͷ���п�����Ϊע��
::IN[�����ļ�·��]    IN-OUT[keys������][�ո�ָ�key]
set "_readConfigMulti=do setlocal enabledelayedexpansion& (for /f "tokens=1* delims==" %%i in (%%1) do (for %%k in (!%%2!) do (if %%i==%%k endlocal& set "%%k=%%j"& setlocal enabledelayedexpansion)))& endlocal"& goto :EOF
REM set "_readConfigMulti=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do (for %%k in (!%%2!) do (if %%i==%%k endlocal& set "%%k=%%j")& setlocal enabledelayedexpansion)& endlocal"& goto :EOF


:_writeConfig
::��ȡָ�������ļ�ָ��keyֵ      �������ļ���Ѱ�Ҽ�Ϊkey����, ���value��������, ��ֵ��Ϊvalue, �����ȡkey����ֵ
::    ע��:for����ȡ�ļ�ʱĬ������;��ͷ����, ���;��ͷ���п�����Ϊע��
::IN[�����ļ�·��]    IN[key������]    {IN[value]}
set "_writeConfig=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do if %%j==%%2 (if "%%3" EQU "" (echo %%j=!%%2!) else (echo %%j=%%3)) else (echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF
:_writeConfig2
::IN[�����ļ�·��]    IN[key������]    {IN[value������]}
set "_writeConfig2=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do if %%j==%%2 (if "%%3" EQU "" (echo %%j=!%%2!) else (echo %%j=!%%3!)) else (echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF

:_writeConfigMulti
::��ָ���Ķ��keyֵд�������ļ�
::    ע��:for����ȡ�ļ�ʱĬ������;��ͷ����, ���;��ͷ���п�����Ϊע��
::IN[�����ļ�·��]    IN[keys������][�ո�ָ�key]
set "_writeConfigMulti=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do (set flag=0& (for %%k in (!%%2!) do if %%j==%%k set flag=1& echo %%j=!%%k!)& if !flag!==0 echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF




:_readConfig
::��ȡָ�������ļ�ָ��keyֵ      �������ļ��ж�����Ϊkey��ֵ, ���value��������, ��ֵ���õ�value��, �������õ�key��
::    ע��:for����ȡ�ļ�ʱĬ������;��ͷ����, ���;��ͷ���п�����Ϊע��
::IN[�����ļ�·��]    IN[key]    {OUT[value������]}
set "_readConfig=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do if %%i==%%2 endlocal& if "%%3" EQU "" (set "%%2=%%j") else (set "%%3=%%j")"& goto :EOF



:_getDate
::ȡ��ǰ��������
::OUT[��-��-��] {IN[separator���ӷ�], Ĭ��ֵΪ��}
set "_getDate=do setlocal enabledelayedexpansion& set dateTemp=!date:~0,10!& for %%i in ("!dateTemp:/=%%2!") do endlocal& set %%1=%%~i"& goto :EOF
:_getYear
::ȡ��ǰ����
::OUT[��]
set "_getYear=do setlocal enabledelayedexpansion& for %%i in ("!date:~0,4!") do endlocal& set %%1=%%~i"& goto :EOF
:_getMonth
::ȡ��ǰ����
::OUT[��] {IN[needRemoveZeroPrefix]: 0�� 1��}
::set "_getMonth=do setlocal enabledelayedexpansion& (if "!date:~5,1!" EQU "0" if "%%2" EQU "1" (set monthTemp=!date:~6,1!) else (set monthTemp=!date:~5,2!))& for %%i in (!monthTemp!) do endlocal& set %%1=%%i"& goto :EOF
set "_getMonth=do setlocal enabledelayedexpansion& (if "!date:~5,1!" EQU "0" if "%%2" EQU "1" (set needRemoveZeroPrefix=1) else (set needRemoveZeroPrefix=0))& (if !needRemoveZeroPrefix!==1 (set monthTemp=!date:~6,1!) else (set monthTemp=!date:~5,2!))& for %%i in (!monthTemp!) do endlocal& set %%1=%%i"& goto :EOF
:_getDay
::ȡ��ǰ����
::OUT[��] {IN[needRemoveZeroPrefix]: 0�� 1��}
set "_getDay=do setlocal enabledelayedexpansion& (if "!date:~8,1!" EQU "0" if "%%2" EQU "1" (set needRemoveZeroPrefix=1) else (set needRemoveZeroPrefix=0))& (if !needRemoveZeroPrefix!==1 (set dayTemp=!date:~9,1!) else (set dayTemp=!date:~8,2!))& for %%i in (!dayTemp!) do endlocal& set %%1=%%i"& goto :EOF



:_bell
::����
set "_bell=echo "& goto :EOF



:_isOddNum
::�Ƿ�������   ������: [(������������) && echo isOddNum || echo non-isOddNum]
::IN[������]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isOddNum=do setlocal enabledelayedexpansion& set /a mod=!%%1! %% 2& if "!mod!"=="1" (endlocal& %_true%) else (endlocal& %_false%)"& goto :EOF



:_isEvenNum
::�Ƿ���ż��   ������: [(������������) && echo isEvenNum || echo non-isEvenNum]
::IN[������]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isEvenNum=do setlocal enabledelayedexpansion& set /a mod=!%%1! %% 2& if "!mod!"=="0" (endlocal& %_true%) else (endlocal& %_false%)"& goto :EOF



:_showHR
::��ӡ����
::IN[Ԫ��(Ĭ��-)]    IN[����(Ĭ��10)]
set "_showHR=do setlocal enabledelayedexpansion& (if "%%1" EQU "" (set hrElement=-) else (set hrElement=%%1))& (if "%%2" EQU "" (set hrLen=10) else (set hrLen=%%2))& set hrStr=& (for /l %%i in (1,1,!hrLen!) do set hrStr=!hrStr!!hrElement!)& echo !hrStr!"& goto :EOF








