@echo off& (if "%1"=="" goto :showExample)& (if "%1"=="0" goto :showDescript)& (if "%1"=="1" goto :searchFunction)
::Author[Allen]    ÓÊÏä[bjc5233@gmail.com]    ¿Û¿Û[692008411]    words[ÓĞ¹²Í¬ĞËÈ¤,ÓĞ½¨Òé,ÓĞbug¶¼»¶Ó­À´ÁªÏµÎÒÅ¶~]

::½éÉÜ
::  load.batÖ÷ÒªÊÇÎªÁËÍ³Ò»¹ÜÀíÄÚÁ²º¯Êı¶øĞ´µÄ
::  ÎÒÔÚ¿ªÊ¼Ñ§Ï°Ê¹ÓÃÄÚÁ²º¯ÊıµÄÊ±ºò, ËüµÄËÙ¶ÈÏà±Ècall¿ìÁË½üºõ10±¶, µ«¾­³£ÔÚ¸÷¸öbat´úÂëÖĞÊéĞ´ÏàÍ¬µÄÄÚÁ²º¯Êı´úÂë, 
::  ÓÚÊÇÄ£·ÂÁËJavaÖĞµ¼ÈëµÄ×ö·¨Ğ´ÁËload.bat, ÏÖÔÚÎÒ×Ô¼º±àĞ´´úÂëÊ±, ĞèÒªÓÃµ½µÄº¯Êı¶¼»á·Åµ½ÕâÀï½øĞĞµ÷ÓÃ
::  ÕâÀïµÄ¸÷¸öÄÚÁ²º¯Êı´ó²¿·ÖÊÇÎÒ×Ô¼ºĞ´µÄ, ÓĞ´ÓÍøÉÏÊÕ¼¯µÄ[±§Ç¸²»ÄÜÒ»Ò»Ğ´³ö×÷ÕßÃû×Ö]


::4ÖÖµ÷ÓÃ·½Ê½
::  ±ØĞëÔÚÑÓ³Ù±äÁ¿[setlocal enabledelayedexpansion]¿ªÆôÖ®Ç° ¡¾µ±µ÷ÓÃÎ»ÖÃ´íÎó»áÓĞÌáÊ¾Óï¾ä¡¿
::  1.call load.bat                   ÎŞ²Î´òÓ¡µ÷ÓÃÊµÀı[Ê¹ÓÃµ½¹¤¾ßclip]
::  2.call load.bat _fun1 _func2...   Õı³£µ÷ÓÃÄÚÁ²º¯Êı[½«ĞèÒªµÄÄÚÁ²º¯Êı×÷Îª²ÎÊı´«Èë]
::  3.call load.bat 0 _fun1 _func2... ´òÓ¡ÄÚÁ²º¯ÊıËµÃ÷[µ±²»Ö¸¶¨º¯Êı,Ôò´òÓ¡ËùÓĞº¯ÊıËµÃ÷]
::  4.call load.bat 1 keyWord         °´¹Ø¼ü×ÖËÑË÷ÄÚÁ²º¯Êı[µ±²»Ö¸¶¨keyWord´òÓ¡ËùÓĞº¯ÊıÁĞ±í][Ê¹ÓÃµ½¹¤¾ßfind ckey clip]


::±àĞ´ÄÚÁ²º¯ÊıÊ±µÄ½¨ÒéºÍ×¢Òâµã
::  1.Àí½â»ù±¾½á¹¹for /f "tokens=1-9 delims= " %%1 in ("²ÎÊı1 ²ÎÊı2...") do setlocal enabledelayedexpansion..... endlocal
::                [              ¡ü                  ] [       ¡ü        ] [                  ¡ü                           ]
::                            %_call%                    ÓÃ»§ÊäÈëµÄ²ÎÊı                   ÄÚÁ²º¯Êı
::  2.ÊéĞ´ÄÚÁ²º¯ÊıÊ¹ÓÃËµÃ÷: µÚÒ»ĞĞĞ´º¯Êı×÷ÓÃ, µÚ¶şĞĞĞ´²ÎÊı
::        ²ÎÊıÉùÃ÷ĞèÒªÖ¸¶¨²ÎÊıÀàĞÍIN OUT IN-OUT, ²ÎÊıÖ®¼äÒ»°ã¼ä¸ô4¸ö¿Õ¸ñ, ¿ÉÑ¡²ÎÊıÊ¹ÓÃ{}°üÎ§
::  2.Í¨³£Çé¿öÏÂÄÚÁ²º¯ÊıĞèÒª±»[setlocal--endlocal]°üÎ§, ·ÀÖ¹¶Ôµ÷ÓÃÕß»·¾³±äÁ¿²úÉúÓ°Ïì
::  3.ÔÚÄÚÁ²º¯ÊıÖĞ, ĞèÒª±£Ö¤[setlocal--endlocal]³É¶Ô, ·ñÔò¿ÉÄÜ»á½«µ÷ÓÃÕß»·¾³±äÁ¿È«²¿Çå³ı
::  4.ÄÚÁ²º¯Êıµ÷ÓÃÄÚÁ²º¯Êı[if not defined _xxx call :_xxx]¡¾ÅĞ¶ÏÒªµ÷ÓÃµÄÄÚÁ²º¯ÊıÊÇ·ñÒÑ¾­¶¨Òå, ·ÀÖ¹¶à´Îµ÷ÓÃ¡¿
::  5.µ÷ÓÃÕß¶ÔÄÚÁ²º¯ÊıµÄÓ°Ïì
::        ÄÚÁ²º¯Êı¿ÉÒÔ·ÃÎÊµ½µ÷ÓÃÕßµÄ±äÁ¿, ±»[setlocal--endlocal]°üÎ§µÄÄÚÁ²º¯Êı¶Ô¸Ã±äÁ¿×öµÄ²Ù×÷Ã»ÓĞÖ±½ÓÓ°Ïì, µ÷ÓÃÕßÖ®ºó¶ÁÈ¡µ½µÄ±äÁ¿Öµ²»±ä[³ı·ÇÃ»ÓĞ°üÎ§\ »òÕßÔÚendlocalÊ±ÉèÖµ]
::            set str=outer
::            echo [!str!]
::            %_test% ------------ setlocal enabledelayedexpansion& echo [!str!]& set str=inner& echo [!str!]& endlocal
::            echo [!str!]
::        ÓÉÓÚÄÚÁ²º¯Êı¿ÉÒÔ·ÃÎÊµ½µ÷ÓÃÕß±äÁ¿, Òò´ËÔÚ½øĞĞÈç×Ö·û×Ôµş¼Ó[set a=!a!b], Êı×Ö×ÔÔö[set /a a+=1]Ê±, Ó¦¸ÃÊ×ÏÈÖÃ¿Õ±äÁ¿[set a=]
::  6.ÊÇ·ñĞÍÄÚÁ²º¯Êı[isFolder]µÄÍÆ¼öĞ´·¨
::        Í¨³£×ö·¨ÊÇ´«Èëµ¥¶À±äÁ¿, ÔÚµ÷ÓÃÖ®ºóÍ¨¹ı¸Ã±äÁ¿µÄÖµÊ¹ÓÃif½øĞĞÅĞ¶Ï, ÕâÀïÍÆ¼öÊ¹ÓÃ_true\_falseÁ½¸öÄÚÁ²º¯Êı´¦Àí[ÊµÖÊÉÏ×îºóÊÇÍ¨¹ıerrorlevelÖµ½øĞĞÅĞ¶Ï]
::        ÄÚÁ²º¯ÊıĞ´·¨: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ È·±£´ËÎªÄÚÁ²º¯Êı×îºóÒ»¾ä, ĞèÒª½«¸ÃifÓï¾äÓÃÀ¨ºÅ°üÎ§
::        µ÷ÓÃÕßµÄĞ´·¨: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true´¦¿ÉÒÔÊ¹ÓÃ¶à¸öÓï¾ä,Ö»Òª°üÎ§ÔÚÀ¨ºÅÄÚ


::¼ì²éµ÷ÓÃÕßÔÚµ÷ÓÃload.batÇ°ÊÇ·ñ¿ªÆôÑÓ³Ù±äÁ¿, ÊÇÔò²»Í¨¹ı
set _positionCheck=0& if "!_positionCheck!"=="0" echo ÇëÔÚ[setlocal enabledelayedexpansion]Ç°µ÷ÓÃload.bat& for /l %%i in () do pause>nul
(if not defined _call call :_call)& (for %%i in (%*) do call :%%i)
goto :EOF



:showExample
::ÏÔÊ¾µ÷ÓÃÊµÀı
call :_getLF& setlocal enabledelayedexpansion& mode 32,15
set "exampleStr=@echo off!LF!call load.bat _strlen!LF!setlocal enabledelayedexpansion!LF!!LF!set str=123ÄãºÃ°¡!LF!%%_call%% ("str len") %%_strlen%%!LF!echo [^!str^!]µÄ×Ö·û³¤¶È: ^!len^!!LF!pause>nul"
echo ------µ÷ÓÃÄÚÁ²º¯ÊıÊµÀı------& echo.& echo !exampleStr!& echo.& echo ------µ÷ÓÃÄÚÁ²º¯ÊıÊµÀı------& echo.& echo.
set /p=ÈÎÒâ¼ü¸´ÖÆµ½¼ôÌù°å<nul& pause>nul& echo !exampleStr!>%temp%\exampleStr.temp& clip<%temp%\exampleStr.temp
goto :EOF

:showDescript
::´òÓ¡Ö¸¶¨ÄÚÁ²º¯ÊıËµÃ÷
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
::ÁĞ³öËùÓĞÒÑ¾­¶¨ÒåÄÚÁ²º¯Êı\ËÑË÷°üº¬Ö¸¶¨×Ö·û´®µÄÄÚÁ²º¯Êı
(call :_getLF)& (call :_call)
setlocal enabledelayedexpansion
(for /f "delims=" %%i in (%~f0) do set curLine=%%i& if "!curLine:~0,2!"==":_" if "!curLine:~-1!" NEQ "_" echo !curLine:~1!)>>%temp%\functionList.tmp
if "%2"=="" (for /f "delims=" %%i in (%temp%\functionList.tmp) do set /a functionIndex+=1& set function_!functionIndex!=%%i& set function_!functionIndex!=%%i) else (title [%2]& for /f "skip=2 delims=" %%i in ('find /i "%2" %temp%\functionList.tmp') do set /a functionIndex+=1& set function_!functionIndex!=%%i)
del /q %temp%\functionList.tmp
if !functionIndex! LSS 1 echo ÕÒ²»µ½°üº¬[%2]µÄº¯Êı& pause>nul& exit
set /a functionIndexMax=functionIndex, pointer=functionIndex/2, winWide=30, winHeight=functionIndexMax&  (if !pointer!==0 set pointer=1)& mode !winWide!, !winHeight!& %CurS% /crv 0
REM [1ÉÏ]  [2ÏÂ] [3Enter] [4Esc]
for /l %%i in () do (
    cls& set functionStr=& (for /l %%i in (1,1,!functionIndex!) do if %%i==!pointer!  (set functionStr=!functionStr!¡ú  !function_%%i!!LF!) else (set functionStr=!functionStr!    !function_%%i!!LF!))& set /p "=_!functionStr:~0,-1!"<nul
    pause>nul& %CKey% 0 38 40 13& (if !errorlevel!==1 set /a pointerTemp=pointer-1)& (if !errorlevel!==2 set /a pointerTemp=pointer+1)& (if !errorlevel!==3 for %%i in (!pointer!) do set /p"=!function_%%i!"<nul | clip& exit)& (if !pointerTemp! GEQ 1 if !pointerTemp! LEQ !functionIndexMax! set pointer=!pointerTemp!)
)
goto :EOF







:_call
::µ÷ÓÃÓĞ²ÎÄÚÁ²º¯ÊıµÄµ÷ÓÃÇ°×º
::ÔÚÊéĞ´ÄÚÁ²º¯ÊıÊ±¸ù¾İ´«Èë²ÎÊıµÄÊıÁ¿Ñ¡Ôñ°æ±¾, Ò»°ãÇé¿öÏÂ¶¼ÊÇÓÃ°æ±¾Ò»[ºÜÉÙÓĞ²ÎÊıÊıÁ¿¶àÓÚ9¸ö]
::(%_call% ("arg1 arg2 arg3...") %_func%)        
::   °æ±¾Ò»Ö§³Ö[%%1--%%9]¹²9¸ö²ÎÊı
::   °æ±¾¶şÖ§³Ö[%%A--%%Z]¹²26¸ö²ÎÊı
set _call=for /f "tokens=1-9 delims= " %%1 in
set _call_=for /f "tokens=1-26 delims= " %%A in
goto :EOF


:_checkDepend
::¼ì²éµ÷ÓÃÕßËùÔÚÂ·¾¶ÒÔ¼°pathÂ·¾¶ÖĞÊÇ·ñ°üº¬Ö¸¶¨µÄÎÄ¼ş
::    ×¢Òâ: ÄÚÁ²º¯ÊıÖĞÓĞĞ©ĞèÒªÊ¹ÓÃµÚÈı·½, Ó¦µ÷ÓÃ´Ëº¯Êı¼ì²éÒÀÀµµÄµÚÈı·½; µ«¶ÔÓÚÒ»°ãÏµÍ³Ğ¯´øµÄexeÈçfindµÈ²»½øĞĞ¼ì²é
::IN[ÎÄ¼şÃû,°üº¬ºó×º]
(call :_getLF)& (if not defined _true call :_true)& (if not defined _false call :_false)
set "_checkDepend=do setlocal enabledelayedexpansion& set path="%cd%"!LF!"%path:;="!LF!"%"& set flag=0& (for %%i in (!path!) do if exist %%~i\%%1 set flag=1)& (if "!flag!"=="1" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF




:_strlen
::¼ÆËã×Ö·û´®µÄ×Ö·ûÊı
::ËùÇó×Ö·û´®²»³¬¹ı8192==>4096 2048 1024 512 256 128 64 32 16
::ËùÇó×Ö·û´®²»³¬¹ı4096==>2048 1024 512 256 128 64 32 16
::ËùÇó×Ö·û´®²»³¬¹ı2048==>1024 512 256 128 64 32 16
::IN[×Ö·û´®±äÁ¿Ãû]    OUT[len]
set "_strlen=do setlocal enabledelayedexpansion& set $=!%%1!#& set N=& (for %%a in (2048 1024 512 256 128 64 32 16) do if !$:~%%a!. NEQ . set /a N+=%%a& set $=!$:~%%a!)& set $=!$!fedcba9876543210& set /a N+=0x!$:~16,1!& for %%i in (!N!) do endlocal& set /a %%2=%%i"& goto :EOF



:_strlen2
::¼ÆËã×Ö·û´®µÄ×Ö½ÚÊı
::IN[×Ö·û´®±äÁ¿Ãû]    OUT[len]
set "_strlen2=do setlocal enabledelayedexpansion& (>%temp%\str.tmp echo.!%%1!)& for %%i in (%temp%\str.tmp) do endlocal& set /a %%2=%%~zi-2" & goto :EOF



:_parseArray
::½âÎöÊı×é×Ö·û´®,½«±äÁ¿array={a,b}×ª»»Îª3¸ö±äÁ¿array.length=3, array[0]=a, array[1]=b, array.maxIndex=2
::IN[Êı×é×Ö·û´®±äÁ¿Ãû]
::set "_parseArray=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do set arrayIndex=0& for %%j in (%%i) do (for %%k in (!arrayIndex!) do endlocal& set %%1[%%k]=%%j)& set /a arrayIndex+=1& setlocal enabledelayedexpansion)& for %%i in (!arrayIndex!) do endlocal& set %%1.length=%%i& set arrayIndex="& goto :EOF
set "_parseArray=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do set arrayIndex=0& for %%j in (%%i) do (for %%k in (!arrayIndex!) do endlocal& set %%1[%%k]=%%j)& set /a arrayIndex+=1& setlocal enabledelayedexpansion)& for %%i in (!arrayIndex!) do (set /a arrayMaxIndex=%%i-1& for %%j in (!arrayMaxIndex!) do endlocal& set %%1.length=%%i& set %%1.maxIndex=%%j& set arrayIndex=& set arrayMaxIndex=)"& goto :EOF


:_destoryArray
::Ïú»ÙÊı×éÔªËØ±äÁ¿
::IN[Êı×é×Ö·û´®±äÁ¿Ãû]
set "_destoryArray=do setlocal enabledelayedexpansion& set /a %%1.length-=1& (for %%i in (!%%1.length!) do for /l %%j in (0,1,%%i) do endlocal& set %%1[%%j]=& setlocal enabledelayedexpansion)& set %%1.length=& set %%1.maxIndex=& set %%1="& goto :EOF



:_parseJSON
::½âÎöJSON×Ö·û´®,½«±äÁ¿json={name:±«xx,age:24} ×ª»»Îª array.length=2, array.name=±«xx, array.age=24
::IN[JSON×Ö·û´®±äÁ¿Ãû]
set "_parseJSON=do setlocal enabledelayedexpansion& (for /f "tokens=1 delims={}" %%i in ("!%%1!") do for %%j in (%%i) do (for /f "tokens=1* delims=:" %%k in ("%%j") do endlocal& set %%1.%%k=%%l& set /a %%1.length+=1)& setlocal enabledelayedexpansion)& endlocal"& goto :EOF
:_destoryJSON
::Ïú»ÙJSONÔªËØ±äÁ¿
::IN[JSON×Ö·û´®±äÁ¿Ãû]
set "_destoryJSON=do (for /f "tokens=1 delims==" %%i in ('set %%1.') do set %%i=)& set %%1="& goto :EOF



:_isPureNum
::ÊÇ·ñÊÇ´¿Êı×Ö   µ÷ÓÃÕß: [(µ÷ÓÃÄÚÁ²º¯Êı) && echo isPureNum || echo non-isPureNum]
::IN[×Ö·û´®±äÁ¿Ãû]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isPureNum=do setlocal enabledelayedexpansion& (set /a flag=!%%~1!*1 >nul 2>nul)& (if "!flag!"=="!%%~1!" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF



:_getRandomNum
::È¡Ö¸¶¨·¶Î§ÄÚµÄËæ»úÊı
::IN[×îĞ¡Öµ]    IN[×î´óÖµ]    OUT[Ëæ»úÊı]
set "_getRandomNum=do setlocal enabledelayedexpansion& for %%i in (!random!) do endlocal& set /a %%3=%%i%%"(%%2-%%1+1)"+%%1"& goto :EOF


:_getRandomNum2
::´ÓÖ¸¶¨Êı×Ö·¶Î§ÄÚËæ»úÑ¡ÔñÖ¸¶¨¸öÊı×ÖµÄÊı×Ö
::IN[×îĞ¡Öµ]    IN[×î´óÖµ]    IN[Ñ¡È¡¸öÊı]    OUT[Êä³öµÄÊı×Ö×Ö·û´®,ÒÔ¿Õ¸ñ·Ö¸ô]
set "_getRandomNum2=do setlocal enabledelayedexpansion& set /a maxIndex=%%2-%%1& set numStr= & (for /l %%i in (%%1,1,%%2) do set numStr=!numStr!%%i )& (for /l %%i in (1,1,%%3) do set /a curIndex=!random!%%"(maxIndex+1)"& set numIndex=0& (for %%j in (!numStr!) do (if !curIndex!==!numIndex! set curNum=%%j)& set /a numIndex+=1)& (for %%j in (!curNum!) do set numStr=!numStr: %%j = !)& set /a maxIndex-=1& set pickNumStr=!pickNumStr!!curNum! )& for %%i in ("!pickNumStr!") do endlocal& set %%4=%%~i"& goto :EOF



:_getRandomColor
::»ñÈ¡Ò»¸öËæ»úÑÕÉ«Öµ
::OUT[Ëæ»úÑÕÉ«Öµ]
if not defined _getRandomNum call :_getRandomNum
set "_getRandomColor=do setlocal enabledelayedexpansion& set colorStr=abcdef123456789& (%_call% ("0 14 index") %_getRandomNum%)& for %%i in (!index!) do set color=!colorStr:~%%i,1!& for %%j in (!color!) do endlocal& set %%1=0%%j"& goto :EOF

:_randomColor
::ÉèÖÃÒ»¸öËæ»úÑÕÉ«
if not defined _getRandomColor call :_getRandomColor
set "_randomColor=setlocal enabledelayedexpansion& (%_call% ("color") %_getRandomColor%)& color !color!& endlocal"& goto :EOF

:_parseColor
::½âÎöµ¥¸öÑÕÉ«Öµ, µ±ÎŞ·¨½âÎöÊ±´òÓ¡³öËùÖ§³ÖµÄÑÕÉ«
::IN[Ô­Ê¼ÑÕÉ«×Ö·û][Èçºì]    OUT[´¦ÀíºóÑÕÉ«´úÂë][ÈçC]
set "_parseColor=do setlocal enabledelayedexpansion& (if %%1==ºÚ set c=0)& (if /i %%1==black set c=0)& (if %%1==À¶ set c=1)& (if /i %%1==blue set c=1)& (if %%1==ÂÌ set c=2)& (if /i %%1==green set c=2)& (if %%1==Ë®ÂÌ set c=3)& (if /i %%1==aqua set c=3)& (if %%1==ºì set c=4)& (if /i %%1==red set c=4)& (if %%1==×Ï set c=5)& (if /i %%1==purple set c=5)& (if %%1==»Æ set c=6)& (if /i %%1==yellow set c=6)& (if %%1==°× set c=7)& (if /i %%1==white set c=7)& (if %%1==»Ò set c=8)& (if /i %%1==gray set c=8)& (if %%1==µ­À¶ set c=9)& (if /i %%1==lightblue set c=9)& (if /i %%1==lblue set c=9)& (if %%1==µ­ÂÌ set c=A)& (if /i %%1==lightgreen set c=A)& (if /i %%1==lgreen set c=A)& (if %%1==µ­Ë®ÂÌ set c=B)& (if /i %%1==lightaqua set c=B)& (if /i %%1==laqua set c=B)& (if %%1==µ­ºì set c=C)& (if /i %%1==lightred set c=C)& (if /i %%1==lred set c=C)& (if %%1==µ­×Ï set c=D)& (if /i %%1==lightpurple set c=D)& (if /i %%1==lpurple set c=D)& (if %%1==µ­»Æ set c=E)& (if /i %%1==lightyellow set c=E)& (if /i %%1==lyellow set c=E)& (if %%1==µ­°× set c=F)& (if /i %%1==lightwhite set c=F)& (if /i %%1==lwhite set c=F)& (if "!c!"=="" set c=0& for %%i in (--ÎŞ·¨½âÎöÖ¸¶¨ÑÕÉ«--- 0-ºÚ-black 1-À¶-blue 2-ÂÌ-green 3-Ë®ÂÌ-aqua 4-ºì-red 5-×Ï-purple 6-»Æ-yellow 7-°×-white 8-»Ò-gray 9-µ­À¶-lightblue-lblue A-µ­ÂÌ-lightgreen-lgreen B-µ­Ë®ÂÌ-lightaqua-laqua C-µ­ºì-lightred-lred D-µ­×Ï-lightpurple-lpurple E-µ­»Æ-lightyellow-lyellow F-µ­°×-lightwhite-lwhite ---------------------) do echo %%i)& for %%i in (!c!) do endlocal& set %%2=%%i"& goto :EOF



:_downcase
::´óĞ´×Ö·û´®×ªĞ¡Ğ´×Ö·û´®
::IN[×Ö·û´®±äÁ¿Ãû]      OUT[´¦Àíºó×Ö·û´®]
set "_downcase=do setlocal enabledelayedexpansion& set str=!%%1!& (for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set str=!str:%%i=%%i!)& for %%i in (!str!) do endlocal& set %%2=%%i"& goto :EOF

:_upcase
::Ğ¡Ğ´×Ö·û´®×ª´óĞ´×Ö·û´®
::IN[×Ö·û´®±äÁ¿Ãû]      OUT[´¦Àíºó×Ö·û´®]
set "_upcase=do setlocal enabledelayedexpansion& set str=!%%1!& (for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set str=!str:%%i=%%i!)& for %%i in (!str!) do endlocal& set %%2=%%i"& goto :EOF



:_px2colsLines
::ÏñËØÖµ×ªcmd¿í¶È¸ß¶ÈÖµ    cmdÄ¬ÈÏ[µãÕó×ÖÌå8x16], ¼´Ã¿¸ö×Ö·ûÊÇ8¸öÏñËØ¿í£¬16¸öÏñËØ¸ß
::IN[pxWidth]    IN[pxHeight]    OUT[cols]    OUT[lines]    {IN[×ÖÌå´óĞ¡][²é¿´ÊôĞÔ×ÖÌåÑ¡Ïî¿¨]}
set "_px2colsLines=do setlocal enabledelayedexpansion& (if "%%5"=="" (set fontSize=8x16) else (set fontSize=%%5))& (for /f "tokens=1,2 delims=x" %%i in ("!fontSize!") do set /a mod=%%1%%%%i& (if !mod!==0 (set offset=0) else (set offset=1))& set /a cols=%%1/%%i+offset& set /a mod=%%2%%%%j& (if !mod!==0 (set offset=0) else (set offset=1))& set /a lines=%%2/%%j+offset)& for /f "tokens=1,2 delims= " %%i in ("!cols! !lines!") do endlocal& set /a %%3=%%i, %%4=%%j"& goto :EOF

:_colsLines2px
::cmd¿í¶È¸ß¶ÈÖµ×ªÏñËØÖµ    cmdÄ¬ÈÏ[µãÕó×ÖÌå8x16], ¼´Ã¿¸ö×Ö·ûÊÇ8¸öÏñËØ¿í£¬16¸öÏñËØ¸ß
::IN[cols]    IN[lines]    OUT[pxWidth]    OUT[pxHeight]    {IN[×ÖÌå´óĞ¡][²é¿´ÊôĞÔ×ÖÌåÑ¡Ïî¿¨]}
set "_colsLines2px=do setlocal enabledelayedexpansion& (if "%%5"=="" (set fontSize=8x16) else (set fontSize=%%5))& for /f "tokens=1,2 delims=x" %%i in ("!fontSize!") do endlocal& set /a %%3=%%1*%%i, %%4=%%2*%%j"& goto :EOF

:_getColsLines
::µÃµ½µ±Ç°cmdÆÁÄ»¿í¶È¸ß¶ÈÖµ
::OUT[cols]    OUT[lines]
set "_getColsLines=do for /f "tokens=1,3 delims=: " %%i in ('mode') do (if "%%i"=="ĞĞ" set %%2=%%j)& (if "%%i"=="ÁĞ" set %%1=%%j)"& goto :EOF



:_buildFile
::´´½¨¿ÕÎÄ¼ş, 0×Ö½Ú, ÎÄ¼şÄÚÃ»ÓĞÈÎºÎÄÚÈİ
::    ×¢Òâ:echo.>1.txt·½Ê½´´½¨µÄ²»ÊÇ¿ÕÎÄ¼ş
::IN[ÎÄ¼şÃû]
set "_buildFile=do cd.>%%1"& goto :EOF


:_getFileName
::½âÎöÎÄ¼şÂ·¾¶×Ö·û´®µÃµ½ÎÄ¼şÃû
::IN[ÎÄ¼şÂ·¾¶±äÁ¿Ãû]    OUT[ÎÄ¼şÃû]    {OUT[ÎÄ¼şÀ©Õ¹Ãû]}
set "_getFileName=do setlocal enabledelayedexpansion& for %%i in ("!%%~1!") do endlocal& set %%2=%%~ni& if "%%3" NEQ "" set %%3=%%~xi"& goto :EOF


:_getFileLine
::¼ÆËãÖ¸¶¨ÎÄ¼şĞĞÊı[ºöÂÔ¿ÕĞĞ]
::IN[ÎÄ¼şÃû]    OUT[ÎÄ¼şĞĞÊı]
set "_getFileLine=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%j in (%%1) do set /a line+=1)& for %%i in (!line!) do endlocal& set %%2=%%i"& goto :EOF
:_getFileLine2
::IN[ÎÄ¼şÂ·¾¶±äÁ¿Ãû]    OUT[ÎÄ¼şĞĞÊı]
set "_getFileLine2=do setlocal enabledelayedexpansion& (for %%i in ("!%%~1!") do for /f "eol= delims=" %%j in (%%~si) do set /a line+=1)& for %%i in (!line!) do endlocal& set %%2=%%i"& goto :EOF



:_getFileSize
::¼ÆËãÖ¸¶¨ÎÄ¼ş´óĞ¡, µ¥Î»byte
::IN[ÎÄ¼şÂ·¾¶±äÁ¿Ãû]   OUT[ÎÄ¼ş´óĞ¡]
set "_getFileSize=do setlocal enabledelayedexpansion& for %%i in ("!%%~1!") do for %%j in (%%~si) do endlocal& set %%2=%%~zj"& goto :EOF

:_isFolder
::ÊÇ·ñÊÇÎÄ¼ş¼Ğ       [%µ÷ÓÃ±í´ïÊ½% && echo folder || echo file]
::IN[ÎÄ¼ş¼ĞÂ·¾¶±äÁ¿Ãû]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isFolder=do setlocal enabledelayedexpansion& (if exist "!%%1!\" (endlocal& %_true%) else (endlocal& %_false%))"& goto :EOF



:_uniqueStr
::Ê¹ÓÃµ±Ç°ÈÕÆÚÊ±¼äµÃµ½Ò»¸öÎ¨Ò»µÄ×Ö·û´®
::OUT[Î¨Ò»×Ö·û´®]
set "_uniqueStr=do setlocal enabledelayedexpansion& for /f "tokens=1-7 delims=/:." %%i in ("!date:~0,10!:!time: =0!") do endlocal& set %%1=%%i%%j%%k%%l%%m%%n%%o"& goto :EOF




:_getCR
::µÃµ½»Ø³µ·ûCarriage Return, µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿CR, µ÷ÓÃÕß¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[!CR!], Î´¿ªÆôÑÓ³Ù±äÁ¿ÎŞ·¨µ÷ÓÃ
(for /f %%i in ('copy /Z "%~dpf0" nul') do set CR=%%i)& goto :EOF

:_getLF
::µÃµ½»»ĞĞ·ûLine Feed[ĞĞÂú], µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿LF\LF_, µ÷ÓÃÕß¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[!LF! \ %LF_%], Î´¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[%LF_%]
set LF=^


set LF_=^^^%LF%%LF%^%LF%%LF%& goto :EOF

:_getTab
::µÃµ½Tab·û, µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿Tab, µ÷ÓÃÕß¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[!Tab! \ %Tab%], Î´¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[%Tab%]
set Tab=	& goto :EOF

:_getBS
::µÃµ½ÍË¸ñ·û, µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿Tab, µ÷ÓÃÕß¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[!BS! \ %BS%], Î´¿ªÆôÑÓ³Ù±äÁ¿Ê¹ÓÃ[%BS%]
(for /f %%i in ('"prompt $h&for %%i in (1) do rem"') do set BS=%%i)& goto :EOF



:_speak
::¼ÆËã»úspeakÎÄ×Ö  »áÔÚ%temp%Ä¿Â¼Éú³Étool_speak.vbs
::IN[ÎÄ×Ö±äÁ¿Ãû]
set "_speak=do setlocal enabledelayedexpansion& (if not exist %temp%\tool_speak.vbs echo CreateObject^("SAPI.SpVoice"^).Speak^(Wscript.Arguments^(0^)^)>%temp%\tool_speak.vbs)& for /f "delims=" %%i in ("!%%1!") do call %temp%\tool_speak.vbs "%%~i""& goto :EOF



:_getScreenSize
::»ñÈ¡ÏÔÊ¾Æ÷ÆÁÄ»´óĞ¡
::OUT[¿í¶È]    OUT[¸ß¶È]
set "_getScreenSize=do for /f "tokens=1,2 delims==" %%i in ('wmic DESKTOPMONITOR where Status^='ok' get ScreenWidth^,ScreenHeight /VALUE') do (if "%%i"=="ScreenWidth" set %%1=%%j)& (if "%%i"=="ScreenHeight" set %%2=%%j)"& goto :EOF


:_getDeskWallpaperPath
::»ñÈ¡×ÀÃæ±ÚÖ½Â·¾¶
::OUT[×ÀÃæ±ÚÖ½Â·¾¶]
set "_getDeskWallpaperPath=do for /f "skip=2 tokens=2* delims= " %%i in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallPaper') do set %%1=%%j"& goto :EOF



:_roundFloat
::ËÄÉáÎåÈë
::IN[Ô­Ê¼¸¡µãÊı×Ö×Ö·û´®]    IN[¾«È·Ğ¡ÊıÎ»Êı]    OUT[´¦Àíºó¸¡µãÊı×Ö×Ö·û´®]
set "_roundFloat=do setlocal enabledelayedexpansion& for /f "tokens=1,2 delims=." %%i in ("%%1") do if "%%j" NEQ "" (set integerPart=%%i& set decimalPart=%%j& set boundaryNum=!decimalPart:~%%2,1!& set decimalPart=!decimalPart:~0,%%2!& (if "!boundaryNum!" NEQ "" if !boundaryNum! GEQ 5 if "!decimalPart!"=="" (set /a integerPart+=1) else (set /a decimalPart+=1))& for /f "tokens=1,2 delims= " %%k in ("!integerPart! !decimalPart!") do endlocal& if "%%l"=="" (set %%3=%%k) else (set %%3=%%k.%%l)) else (endlocal& set %%3=%%i)"& goto :EOF



:_infiniteLoopPause
::ÎŞÏŞpause>nul, Ò»°ãÓÃÓÚbat½áÎ², ÓÃ»§Ö»ÄÜÊÖ¶¯¹Ø±Õ´°¿Ú
set "_infiniteLoopPause=for /l %%i in () do pause>nul"& goto :EOF

:_infiniteLoopSome
::ÎŞÏŞ´¦ÀíÓÃ»§Ö¸¶¨ÃüÁî,    Ê¹ÓÃË«ÒıºÅ°üÎ§Ã¿ÌõÃüÁî, ÃüÁîÖ®¼äÒÔ¿Õ¸ñ·Ö¸ô          set some="echo ok" "pause" "set /a count+=1" "echo ^!count^!"& %_call% ("some") %_infiniteLoopSome%
::IN[Ö¸¶¨ÃüÁî×Ö·û´®±äÁ¿Ãû]
set "_infiniteLoopSome=do setlocal enabledelayedexpansion& (for /l %%i in () do for %%j in (!%%1!) do %%~j)& endlocal"& goto :EOF



:_trimStrLeft
::ĞŞÕû×Ö·û´®£¬ÒÆ³ı×ó¿Õ¸ñ
::IN-OUT[×Ö·û´®±äÁ¿Ãû]
set "_trimStrLeft=do setlocal enabledelayedexpansion& for /f "tokens=* delims= " %%i in ("!%%~1!") do set %%1=%%i"& goto :EOF

:_trimStrRight
::ĞŞÕû×Ö·û´®£¬ÒÆ³ıÓÒ¿Õ¸ñ
::IN-OUT[×Ö·û´®±äÁ¿Ãû]
if not defined _strlen call :_strlen
set "_trimStrRight=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set str=!%%1!& (for /l %%i in (1,1,!len!) do if "!str:~-1,1!"==" " set "str=!str:~0,-1!")& for %%i in ("!str!") do endlocal& set "%%1=%%~i""& goto :EOF

:_trimStr
::ĞŞÕû×Ö·û´®£¬ÒÆ³ı×óÓÒ¿Õ¸ñ
::IN-OUT[×Ö·û´®±äÁ¿Ãû]
(if not defined _trimStrLeft call :_trimStrLeft)& (if not defined _trimStrRight call :_trimStrRight)
set "_trimStr=do (%_call% ("%%1") %_trimStrLeft%)& (%_call% ("%%1") %_trimStrRight%)"& goto :EOF


:_reverseStr
::½«×Ö·û´®·´Ğò´¦Àí
::IN[×Ö·û´®±äÁ¿Ãû]     OUT[´¦Àíºó×Ö·û´®]
if not defined _strlen call :_strlen
set "_reverseStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "str=!%%1!"& set /a len-=1& (for /l %%i in (0,1,!len!) do set str2=!str:~%%i,1!!str2!)& for %%i in ("!str2!") do endlocal& set "%%2=%%~i""& goto :EOF



:_shuffleStr
::½«×Ö·û´®ÂÒĞò´¦Àí
::IN[×Ö·û´®±äÁ¿Ãû]     OUT[´¦Àíºó×Ö·û´®]
(if not defined _strlen call :_strlen)& (if not defined _getRandomNum call :_getRandomNum)
set "_shuffleStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "str=!%%1!"& set /a len-=1& (for /l %%i in (0,1,!len!) do (%_call% ("0 !len! index") %_getRandomNum%)& set /a index2=index+1& for /f "tokens=1,2 delims= " %%j in ("!index! !index2!") do set str2=!str2!!str:~%%j,1!& set str=!str:~0,%%j!!str:~%%k!& set /a len-=1)& for %%i in ("!str2!") do endlocal& set "%%2=%%~i""& goto :EOF



:_true
::µÃµ½Ò»¸ö±êÊ¶³É¹¦µÄÖµ(errorlevelÎª0), µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿_true£¬×¢ÒâÖ»ÄÜÊ¹ÓÃ%_true%, ²»ÄÜÊ¹ÓÃ!_true!, Ô­ÒòÎ´Öª
::  1.Ç¶Èëcallµ÷ÓÃ£º·ÅÔÚcall´úÂë¶Î×îºó´¦Ê¹ÓÃ, ÕâÑùcall¾ÍÈçÍ¬´æÔÚÒ»¸öÊÇ·ñµÄ·µ»ØÖµ
::        call :test && echo true || echo false
::        :test
::        %_true%& goto :EOF
::  2.Ç¶ÈëÄÚÁ²º¯Êıµ÷ÓÃ
::        ÄÚÁ²º¯ÊıĞ´·¨: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ È·±£´ËÎªÄÚÁ²º¯Êı×îºóÒ»¾ä, ĞèÒª½«¸ÃifÓï¾äÓÃÀ¨ºÅ°üÎ§
::        µ÷ÓÃÕßµÄĞ´·¨: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true´¦¿ÉÒÔÊ¹ÓÃ¶à¸öÓï¾ä,Ö»Òª°üÎ§ÔÚÀ¨ºÅÄÚ
set "_true=echo.>nul"& goto :EOF
:_false
::µÃµ½Ò»¸ö±êÊ¶Ê§°ÜµÄÖµ(errorlevel´óÓÚ0), µ¼ÈëÖ®ºóÊ¹ÓÃÔ¼¶¨±äÁ¿_false£¬×¢ÒâÖ»ÄÜÊ¹ÓÃ%_false%, ²»ÄÜÊ¹ÓÃ!_false!, Ô­ÒòÎ´Öª
::  1.Ç¶Èëcallµ÷ÓÃ£º·ÅÔÚcall´úÂë¶Î×îºó´¦Ê¹ÓÃ, ÕâÑùcall¾ÍÈçÍ¬´æÔÚÒ»¸öÊÇ·ñµÄ·µ»ØÖµ
::        call :test && echo true || echo false
::        :test
::        %_false%& goto :EOF
::  2.Ç¶ÈëÄÚÁ²º¯Êıµ÷ÓÃ
::        ÄÚÁ²º¯ÊıĞ´·¨: (if condition (endlocal& %_true%) else (endlocal& %_false%)) ------ È·±£´ËÎªÄÚÁ²º¯Êı×îºóÒ»¾ä, ĞèÒª½«¸ÃifÓï¾äÓÃÀ¨ºÅ°üÎ§
::        µ÷ÓÃÕßµÄĞ´·¨: (%_call% ("myFolder") %_isFolder%) && echo true || echo false ------ echo true´¦¿ÉÒÔÊ¹ÓÃ¶à¸öÓï¾ä,Ö»Òª°üÎ§ÔÚÀ¨ºÅÄÚ
set "_false=set=2>nul"& goto :EOF



:_parseBlockNum
::½âÎöÊı×Ö×Ö·û´®ÎªbolckNumĞÎÊ½, ¿É½ÓÊÜ×Ö·û[Êı×Ö +-*/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::IN[Êı×Ö×Ö·û´®±äÁ¿Ãû]    IN-OUT[´¦Àíºó×Ö·û´®±äÁ¿Ãû]    OUT[´¦Àíºó×Ö·û´®ĞĞÊı]
if not defined _strlen call :_strlen
set "_parseBlockNum=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "numStr=!%%1!"& set /a len-=1& (for /l %%i in (1,1,5) do set line%%i=)& (for /l %%i in (0,1,!len!) do set char=!numStr:~%%i,1!& set blockChar=& ((if "!char!"=="0" set blockChar=¡ö¡ö¡ö #¡ö  ¡ö #¡ö  ¡ö #¡ö  ¡ö #¡ö¡ö¡ö )& (if "!char!"=="1" set blockChar= ¡ö  # ¡ö  # ¡ö  # ¡ö  # ¡ö  )& (if "!char!"=="2" set blockChar=¡ö¡ö¡ö #    ¡ö #¡ö¡ö¡ö #¡ö     #¡ö¡ö¡ö )& (if "!char!"=="3" set blockChar=¡ö¡ö¡ö #    ¡ö #¡ö¡ö¡ö #    ¡ö #¡ö¡ö¡ö )& (if "!char!"=="4" set blockChar=¡ö  ¡ö #¡ö  ¡ö #¡ö¡ö¡ö #    ¡ö #    ¡ö )& (if "!char!"=="5" set blockChar=¡ö¡ö¡ö #¡ö     #¡ö¡ö¡ö #    ¡ö #¡ö¡ö¡ö )& (if "!char!"=="6" set blockChar=¡ö¡ö¡ö #¡ö     #¡ö¡ö¡ö #¡ö  ¡ö #¡ö¡ö¡ö )& (if "!char!"=="7" set blockChar=¡ö¡ö¡ö #    ¡ö #    ¡ö #    ¡ö #    ¡ö )& (if "!char!"=="8" set blockChar=¡ö¡ö¡ö #¡ö  ¡ö #¡ö¡ö¡ö #¡ö  ¡ö #¡ö¡ö¡ö )& (if "!char!"=="9" set blockChar=¡ö¡ö¡ö #¡ö  ¡ö #¡ö¡ö¡ö #    ¡ö #¡ö¡ö¡ö )& (if "!char!"=="." set blockChar=   #   #   #   #¡ö )& (if "!char!"==":" set blockChar=   #¡ö #   #¡ö #   )& (if "!char!"=="+" set blockChar=       #  ¡ö   #¡ö¡ö¡ö #  ¡ö   #       )& (if "!char!"=="-" set blockChar=       #       #¡ö¡ö¡ö #       #       )& (if "!char!"=="*" set blockChar=       #¡ö  ¡ö #  ¡ö   #¡ö  ¡ö #       )& (if "!char!"=="/" set blockChar=      #   ¡ö #  ¡ö  # ¡ö   #      )& (if "!char!"=="=" set blockChar=       #¡ö¡ö¡ö #       #¡ö¡ö¡ö #       )& (if "!blockChar!"=="" set blockChar= # # # # ))& for /f "tokens=1-5 delims=#" %%j in ("!blockChar!") do set line1=!line1!%%j& set line2=!line2!%%k& set line3=!line3!%%l& set line4=!line4!%%m& set line5=!line5!%%n)& for /f "tokens=1-5 delims=#" %%i in ("!line1!#!line2!#!line3!#!line4!#!line5!") do endlocal& set %%2_1=%%i& set %%2_2=%%j& set %%2_3=%%k& set %%2_4=%%l& set %%2_5=%%m& set %%3=5"& goto :EOF

:_parseShowBlockNum
::½âÎöÊı×Ö×Ö·û´®ÎªbolckNumĞÎÊ½, ²¢ÏÔÊ¾, ¿É½ÓÊÜ×Ö·û[Êı×Ö +-*/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::IN[Êı×Ö×Ö·û´®±äÁ¿Ãû]    {IN[ĞĞÇ°×º]}    {IN[ĞĞºó×º]}
(if not defined _parseBlockNum call :_parseBlockNum)& (if not defined _showBlockASCII call :_showBlockASCII)
set "_parseShowBlockNum=do setlocal enabledelayedexpansion& (%_call% ("%%1 numStr numLine") %_parseBlockNum%)& (%_call% ("numStr numLine %%2 %%3") %_showBlockASCII%)& endlocal"& goto :EOF

:_parseShowBlockNum2
::½âÎöÊı×Ö×Ö·û´®ÎªbolckNumĞÎÊ½, ²¢ÏÔÊ¾, ¿É½ÓÊÜ×Ö·û[Êı×Ö ¿Õ¸ñ +-*/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::IN[Êı×Ö×Ö·û´®±äÁ¿Ãû]    {IN[ĞĞÇ°×º±äÁ¿Ãû]}    {IN[ĞĞºó×º±äÁ¿Ãû]}
(if not defined _parseBlockNum call :_parseBlockNum)& (if not defined _showBlockASCII2 call :_showBlockASCII2)
set "_parseShowBlockNum2=do setlocal enabledelayedexpansion& (%_call% ("%%1 numStr numLine") %_parseBlockNum%)& (%_call% ("numStr numLine %%2 %%3") %_showBlockASCII2%)& endlocal"& goto :EOF



:_parseASCIIStr
::½âÎö×Ö·û´®×ªÎªASCIIĞÎÊ½, ¿É½ÓÊÜ×Ö·û[Ó¢ÎÄ´óĞ¡Ğ´ Êı×Ö ¿Õ¸ñ ~@#$*(-_+=[]{}\:;'.,?/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::    ×¢Òâ: ´óĞ´×ÖÄ¸\±êµã·ûºÅÊÇÒÔfigletµÄbanner3.flf×ÖÌå×÷Îª»ù´¡£¬Ğ¡Ğ´×ÖÄ¸ÊÇÒÔxhelv.flf×ÖÌå×÷Îª»ù´¡ĞŞ¸Ä¶øÀ´£¬ÔÚbatÖĞÒ»Ğ©ÌØÊâ×Ö·û²»ÄÜ´¦Àí! % & ) | " <> ^
::    ×¢Òâ: ´ËÄÚÁ²º¯ÊıÖĞ²ÉÓÃÑ¹Ëõ´¦Àí, batÖĞ±äÁ¿Öµ×î´ó³¤¶ÈÊÇ8189¸ö×Ö·û, ²»Ñ¹ËõÔò³¤¶ÈÔò³¬¹ıÉÏÏŞ
::          Ñ¹ËõĞÎÊ½[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]£¬¾ßÌå²Î¿¼C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[×Ö·û´®±äÁ¿Ãû]    IN-OUT[´¦Àíºó×Ö·û´®±äÁ¿Ãû]    OUT[´¦Àíºó×Ö·û´®ĞĞÊı]
if not defined _strlen call :_strlen
set "_parseASCIIStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 len") %_strlen%)& set "asciiStr=!%%1!"& set /a len-=1& (for /l %%i in (1,1,7) do set line%%i=)& (for /l %%i in (0,1,!len!) do set c=!asciiStr:~%%i,1!& set c2=& ((if "!c!"=="~" set c2=K$K$A4F$2B2B2A$E4B$K$K)& (if "!c!"=="@" set c2=A7B$2E2A$2A3A2A$2A3A2A$2A5B$2H$A7B)& (if "!c!"=="#" set c2=B2A2C$B2A2C$9A$B2A2C$9A$B2A2C$B2A2C)& (if "!c!"=="$" set c2=A8B$2B2B2A$2B2E$A8B$D2B2A$2B2B2A$A8B)& (if "!c!"=="*" set c2=J$A2C2B$B2A2C$9A$B2A2C$A2C2B$J)& (if "!c!"=="(" set c2=B3A$A2C$2D$2D$2D$A2C$B3A)& (if "!c!"=="-" set c2=H$H$H$7A$H$H$H)& (if "!c!"=="_" set c2=H$H$H$H$H$H$7A)& (if "!c!"=="+" set c2=G$B2C$B2C$6A$B2C$B2C$G)& (if "!c!"=="=" set c2=F$F$5A$F$5A$F$F)& (if "!c!"=="[" set c2=6A$2E$2E$2E$2E$2E$6A)& (if "!c!"=="]" set c2=6A$D2A$D2A$D2A$D2A$D2A$6A)& (if "!c!"=="{" set c2=B4A$A2D$A2D$3D$A2D$A2D$B4A)& (if "!c!"=="}" set c2=4C$C2B$C2B$C3A$C2B$C2B$4C)& (if "!c!"=="\" set c2=2G$A2F$B2E$C2D$D2C$E2B$F2A)& (if "!c!"==":" set c2=E$4A$4A$E$4A$4A$E)& (if "!c!"==";" set c2=4A$4A$E$4A$4A$A2B$2C)& (if "!c!"=="'" set c2=4A$4A$A2B$E$E$E$E)& (if "!c!"=="." set c2=D$D$D$D$D$3A$3A)& (if "!c!"=="," set c2=E$E$E$4A$4A$A2B$2C)& (if "!c!"=="?" set c2=A7B$2E2A$F2B$D3C$C2E$J$C2E)& (if "!c!"=="/" set c2=F2A$E2B$D2C$C2D$B2E$A2F$2G)& (if "!c!"=="0" set c2=B5C$A2C2B$2E2A$2E2A$2E2A$A2C2B$B5C)& (if "!c!"=="1" set c2=C2C$A4C$C2C$C2C$C2C$C2C$A6A)& (if "!c!"=="2" set c2=A7B$2E2A$G2A$A7B$2H$2H$9A)& (if "!c!"=="3" set c2=A7B$2E2A$G2A$A7B$G2A$2E2A$A7B)& (if "!c!"=="4" set c2=2H$2D2B$2D2B$2D2B$9A$F2B$F2B)& (if "!c!"=="5" set c2=8A$2G$2G$7B$F2A$2D2A$A6B)& (if "!c!"=="6" set c2=A7B$2E2A$2H$8B$2E2A$2E2A$A7B)& (if "!c!"=="7" set c2=8A$2D2A$D2C$C2D$B2E$B2E$B2E)& (if "!c!"=="8" set c2=A7B$2E2A$2E2A$A7B$2E2A$2E2A$A7B)& (if "!c!"=="9" set c2=A7B$2E2A$2E2A$A8A$G2A$2E2A$A7B)& (if "!c!"=="a" set c2=H$A4C$D2B$A5B$2B2B$A4A1A$H)& (if "!c!"=="b" set c2=2F$2F$2A3B$3B2A$3B2A$2A3B$H)& (if "!c!"=="c" set c2=G$A4B$2B2A$2E$2B2A$A4B$G)& (if "!c!"=="d" set c2=D2A$D2A$A5A$2B2A$2B2A$A5A$G)& (if "!c!"=="e" set c2=G$A4B$2B2A$6A$2E$A5A$G)& (if "!c!"=="f" set c2=A3A$A2B$4A$A2B$A2B$A2B$E)& (if "!c!"=="g" set c2=H$A5B$2C2A$2C2A$A6A$E2A$A5B)& (if "!c!"=="h" set c2=2E$2E$5B$2B2A$2B2A$2B2A$G)& (if "!c!"=="i" set c2=2A$C$2A$2A$2A$2A$C)& (if "!c!"=="j" set c2=A2A$D$A2A$A2A$A2A$A2A$2B)& (if "!c!"=="k" set c2=2E$2B2A$2A2B$4C$2A2B$2B2A$G)& (if "!c!"=="l" set c2=2A$2A$2A$2A$2A$2A$C)& (if "!c!"=="m" set c2=K$A3A4B$2B2B2A$2B2B2A$2B2B2A$2B2B2A$K)& (if "!c!"=="n" set c2=H$A5B$2C2A$2C2A$2C2A$2C2A$H)& (if "!c!"=="o" set c2=H$A5B$2C2A$2C2A$2C2A$A5B$H)& (if "!c!"=="p" set c2=H$6B$2C2A$2C2A$6B$2F$2F)& (if "!c!"=="q" set c2=H$B5A$2C2A$2C2A$A6A$E2A$E2A)& (if "!c!"=="r" set c2=F$2A2A$2A1B$3C$2D$2D$F)& (if "!c!"=="s" set c2=G$A4B$2E$A4B$D2A$A4B$G)& (if "!c!"=="t" set c2=E$A2B$4A$A2B$A2B$A3A$E)& (if "!c!"=="u" set c2=G$2B2A$2B2A$2B2A$2B2A$A3A1A$G)& (if "!c!"=="v" set c2=H$2C2A$2C2A$A2A2B$A2A2B$C1D$H)& (if "!c!"=="w" set c2=K$2B2B2A$A2A2A2B$A2A2A2B$B2B2C$C1B1D$K)& (if "!c!"=="x" set c2=I$2D2A$A2B2B$C2D$A2B2B$2D2A$I)& (if "!c!"=="y" set c2=H$2C2A$2B2B$A4C$B2D$A2E$2F)& (if "!c!"=="z" set c2=G$6A$C2B$B2C$A2D$6A$G)& (if "!c!"=="A" set c2=C3D$B2A2C$A2C2B$2E2A$9A$2E2A$2E2A)& (if "!c!"=="B" set c2=8B$2E2A$2E2A$8B$2E2A$2E2A$8B)& (if "!c!"=="C" set c2=A6B$2D2A$2G$2G$2G$2D2A$A6B)& (if "!c!"=="D" set c2=8B$2E2A$2E2A$2E2A$2E2A$2E2A$8B)& (if "!c!"=="E" set c2=8A$2G$2G$6C$2G$2G$8A)& (if "!c!"=="F" set c2=8A$2G$2G$6C$2G$2G$2G)& (if "!c!"=="G" set c2=A6C$2D2B$2H$2C4A$2D2B$2D2B$A6C)& (if "!c!"=="H" set c2=2E2A$2E2A$2E2A$9A$2E2A$2E2A$2E2A)& (if "!c!"=="I" set c2=4A$A2B$A2B$A2B$A2B$A2B$4A)& (if "!c!"=="J" set c2=F2A$F2A$F2A$F2A$2D2A$2D2A$A6B)& (if "!c!"=="K" set c2=2D2A$2C2B$2B2C$5D$2B2C$2C2B$2D2A)& (if "!c!"=="L" set c2=2G$2G$2G$2G$2G$2G$8A)& (if "!c!"=="M" set c2=2E2A$3C3A$4A4A$2A3A2A$2E2A$2E2A$2E2A)& (if "!c!"=="N" set c2=2D2A$3C2A$4B2A$2A2A2A$2B4A$2C3A$2D2A)& (if "!c!"=="O" set c2=A7B$2E2A$2E2A$2E2A$2E2A$2E2A$A7B)& (if "!c!"=="P" set c2=8B$2E2A$2E2A$8B$2H$2H$2H)& (if "!c!"=="Q" set c2=A7B$2E2A$2E2A$2E2A$2B2A2A$2D2B$A5A2A)& (if "!c!"=="R" set c2=8B$2E2A$2E2A$8B$2C2C$2D2B$2E2A)& (if "!c!"=="S" set c2=A6B$2D2A$2G$A6B$F2A$2D2A$A6B)& (if "!c!"=="T" set c2=8A$C2D$C2D$C2D$C2D$C2D$C2D)& (if "!c!"=="U" set c2=2E2A$2E2A$2E2A$2E2A$2E2A$2E2A$A7B)& (if "!c!"=="V" set c2=2E2A$2E2A$2E2A$2E2A$A2C2B$B2A2C$C3D)& (if "!c!"=="W" set c2=2F2A$2B2B2A$2B2B2A$2B2B2A$2B2B2A$2B2B2A$A3B3B)& (if "!c!"=="X" set c2=2E2A$A2C2B$B2A2C$C3D$B2A2C$A2C2B$2E2A)& (if "!c!"=="Y" set c2=2D2A$A2B2B$B4C$C2D$C2D$C2D$C2D)& (if "!c!"=="Z" set c2=8A$E2B$D2C$C2D$B2E$A2F$8A)& (if "!c2!"=="" set c2=C$C$C$C$C$C$C))& ((set c2=!c2:K=           !)& (set c2=!c2:J=          !)& (set c2=!c2:I=         !)& (set c2=!c2:H=        !)& (set c2=!c2:G=       !)& (set c2=!c2:F=      !)& (set c2=!c2:E=     !)& (set c2=!c2:D=    !)& (set c2=!c2:C=   !)& (set c2=!c2:B=  !)& (set c2=!c2:A= !)& (set c2=!c2:9=#########!)& (set c2=!c2:8=########!)& (set c2=!c2:7=#######!)& (set c2=!c2:6=######!)& (set c2=!c2:5=#####!)& (set c2=!c2:4=####!)& (set c2=!c2:3=###!)& (set c2=!c2:2=##!)& (set c2=!c2:1=#!))& for /f "tokens=1-7 delims=$" %%j in ("!c2!") do set line1=!line1!%%j& set line2=!line2!%%k& set line3=!line3!%%l& set line4=!line4!%%m& set line5=!line5!%%n& set line6=!line6!%%o& set line7=!line7!%%p)& for /f "tokens=1-7 delims=$" %%i in ("!line1!$!line2!$!line3!$!line4!$!line5!$!line6!$!line7!") do endlocal& set %%2_1=%%i& set %%2_2=%%j& set %%2_3=%%k& set %%2_4=%%l& set %%2_5=%%m& set %%2_6=%%n& set %%2_7=%%o& set %%3=7"& goto :EOF

:_parseShowASCIIStr
::½âÎö×Ö·û´®×ªÎªASCIIĞÎÊ½, ²¢ÏÔÊ¾, ¿É½ÓÊÜ×Ö·û[Ó¢ÎÄ´óĞ¡Ğ´ Êı×Ö ¿Õ¸ñ ~@#$*(-_+=[]{}\:;'.,?/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::    ×¢Òâ: ´óĞ´×ÖÄ¸\±êµã·ûºÅÊÇÒÔfigletµÄbanner3.flf×ÖÌå×÷Îª»ù´¡£¬Ğ¡Ğ´×ÖÄ¸ÊÇÒÔxhelv.flf×ÖÌå×÷Îª»ù´¡ĞŞ¸Ä¶øÀ´£¬ÔÚbatÖĞÒ»Ğ©ÌØÊâ×Ö·û²»ÄÜ´¦Àí! % & ) | " <> ^
::    ×¢Òâ: ´ËÄÚÁ²º¯ÊıÖĞ²ÉÓÃÑ¹Ëõ´¦Àí, batÖĞ±äÁ¿Öµ×î´ó³¤¶ÈÊÇ8189¸ö×Ö·û, ²»Ñ¹ËõÔò³¤¶ÈÔò³¬¹ıÉÏÏŞ
::          Ñ¹ËõĞÎÊ½[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]£¬¾ßÌå²Î¿¼C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[×Ö·û´®±äÁ¿Ãû]      {IN[ĞĞÇ°×º]}      {IN[ĞĞºó×º]}
(if not defined _parseASCIIStr call :_parseASCIIStr)& (if not defined _showBlockASCII call :_showBlockASCII)
set "_parseShowASCIIStr=do setlocal enabledelayedexpansion& (%_call% ("%%1 asciiStr asciiLine") %_parseASCIIStr%)& (%_call% ("asciiStr asciiLine %%2 %%3") %_showBlockASCII%)& endlocal"& goto :EOF

:_parseShowASCIIStr2
::½âÎö×Ö·û´®×ªÎªASCIIĞÎÊ½, ²¢ÏÔÊ¾, ¿É½ÓÊÜ×Ö·û[Ó¢ÎÄ´óĞ¡Ğ´ Êı×Ö ¿Õ¸ñ ~@#$*(-_+=[]{}\:;'.,?/], ¶ÔÎ´Öª×Ö·ûÊ¹ÓÃ¿Õ¸ñÌæ´ú
::    ×¢Òâ: ´óĞ´×ÖÄ¸\±êµã·ûºÅÊÇÒÔfigletµÄbanner3.flf×ÖÌå×÷Îª»ù´¡£¬Ğ¡Ğ´×ÖÄ¸ÊÇÒÔxhelv.flf×ÖÌå×÷Îª»ù´¡ĞŞ¸Ä¶øÀ´£¬ÔÚbatÖĞÒ»Ğ©ÌØÊâ×Ö·û²»ÄÜ´¦Àí! % & ) | " <> ^
::    ×¢Òâ: ´ËÄÚÁ²º¯ÊıÖĞ²ÉÓÃÑ¹Ëõ´¦Àí, batÖĞ±äÁ¿Öµ×î´ó³¤¶ÈÊÇ8189¸ö×Ö·û, ²»Ñ¹ËõÔò³¤¶ÈÔò³¬¹ıÉÏÏŞ
::          Ñ¹ËõĞÎÊ½[-]=>[           $           $ ####      $##  ##  ## $     ####  $           $       ]=>[H$H$H$7A$H$H$H]£¬¾ßÌå²Î¿¼C:\path\bat\batlearn\ASCIIChar\convert.bat
::IN[×Ö·û´®±äÁ¿Ãû]      {IN[ĞĞÇ°×º±äÁ¿Ãû]}      {IN[ĞĞºó×º±äÁ¿Ãû]}
(if not defined _parseASCIIStr call :_parseASCIIStr)& (if not defined _showBlockASCII2 call :_showBlockASCII2)
set "_parseShowASCIIStr2=do setlocal enabledelayedexpansion& (%_call% ("%%1 asciiStr asciiLine") %_parseASCIIStr%)& (%_call% ("asciiStr asciiLine %%2 %%3") %_showBlockASCII2%)& endlocal"& goto :EOF


:_showBlockASCII
::ÏÔÊ¾bolckNum\ ASCIIStr×Ö·û´®
::IN[×Ö·û´®±äÁ¿Ãû]    IN[ĞĞÊı±äÁ¿Ãû]    {IN[ĞĞÇ°×º]}    {IN[ĞĞºó×º]}
set "_showBlockASCII=do setlocal enabledelayedexpansion& (for /l %%i in (1,1,!%%2!) do echo.%%3!%%1_%%i!%%4)& endlocal"& goto :EOF
:_showBlockASCII2
::ÏÔÊ¾bolckNum\ ASCIIStr×Ö·û´®
::IN[×Ö·û´®±äÁ¿Ãû]    IN[ĞĞÊı±äÁ¿Ãû]    {IN[ĞĞÇ°×º±äÁ¿Ãû]}    {IN[ĞĞºó×º±äÁ¿Ãû]}
set "_showBlockASCII2=do setlocal enabledelayedexpansion& (for /l %%i in (1,1,!%%2!) do echo.!%%3!!%%1_%%i!!%%4!)& endlocal"& goto :EOF


:_playMusicMini
::Ö¸¶¨´ÎÊı²¥·ÅÒôÀÖ¼¯, ĞèÒª¹¤¾ßgplay.exeÖ§³Ö
::IN[musicPaths][Â·¾¶ÓĞ¿Õ¸ñ¼ÓË«ÒıºÅ][¶à¸öÂ·¾¶Ê¹ÓÃ¿Õ¸ñ¼ä¸ô]    IN[times][²»Ğ´»òÕß0±íÊ¾Ñ­»·]
call loadE.bat gplay
(if not defined _checkDepend call :_checkDepend)
(%_call% ("gplay.exe") %_checkDepend%) || (echo È±ÉÙgplay.exe& pause>nul& goto :EOF)
set "_playMusicMini=do setlocal enabledelayedexpansion& (if "%%2"=="" (set times=) else (if %%2==0 (set times=) else (set times=1,1,%%2)))& (for /l %%i in (!times!) do %gplay% !%%1!>nul 2>nul)& endlocal"& goto :EOF

:_playMusic
::Ö¸¶¨²¥·ÅÄ£Ê½²¥·ÅÒôÀÖ¼¯, ĞèÒªgplay.exeÖ§³Ö
::IN[musicPaths][Â·¾¶ÓĞ¿Õ¸ñ¼ÓË«ÒıºÅ][¶à¸öÂ·¾¶Ê¹ÓÃ¿Õ¸ñ¼ä¸ô]    IN[mode][µ¥Çú²¥·Å0\µ¥ÇúÑ­»·1\Ë³Ğò²¥·Å2\Ñ­»·²¥·Å3\Ëæ»ú²¥·Å4]
call loadE.bat gplay
(if not defined _checkDepend call :_checkDepend)& (%_call% ("gplay.exe") %_checkDepend%) || (echo È±ÉÙgplay.exe& pause>nul& goto :EOF)
if not defined _getRandomNum call :_getRandomNum
set "_playMusic=do setlocal enabledelayedexpansion& (if "%%2"=="" (set mode=0) else (set mode=%%2))& (if !mode!==0 set times=1,1,1& set musicPath=& for %%i in (!%%1!) do if not defined musicPath set musicPath=%%i)& (if !mode!==1 set times=& set musicPath=& for %%i in (!%%1!) do if "!musicPath!"=="" set musicPath=%%i)& (if !mode!==2 set times=1,1,1& set musicPath=!%%1!)& (if !mode!==3 set times=& set musicPath=!%%1!)& (if !mode!==4 set times=& set musicPath=!%%1!& set musicIndex=0& (for %%i in (!%%1!) do set /a musicIndex+=1& set musicPath_!musicIndex!=%%i)& set musicIndexMax=!musicIndex!)& (for /l %%i in (!times!) do (if !mode!==4 (%_call% ("1 !musicIndexMax! musicIndex") %_getRandomNum%)& for %%j in (!musicIndex!) do set musicPath=!musicPath_%%j!)& %gplay% !musicPath!>nul 2>nul)& endlocal"& goto :EOF



:_setFontSize
::ĞŞ¸Äcmd´°¿Ú×ÖÌå´óĞ¡   Ä¿Ç°Ö»Ö§³Ö[µãÕó×ÖÌå]
::    ×¢Òâ:×¢²á±íÖĞFontSize×Ö¶Î[¸ßËÄÎ»Îª×Ö¸ß, µÍËÄÎ»Îª×Ö¿í], Èç00100008£¬¼´×ÖÌå¿íx¸ß=16½øÖÆ08Hx10H=10½øÖÆ8¡Á16
::IN[×ÖÌå¿íx¸ß][8x16]
set "_setFontSize=do setlocal enabledelayedexpansion& set fontSize=& (if %%1==3x5 set fontSize=0x00050003)& (if %%1==5x8 set fontSize=0x00080005)& (if %%1==6x12 set fontSize=0x000c0006)& (if %%1==8x16 set fontSize=0x00100008)& (if %%1==8x18 set fontSize=0x00120008)& (if %%1==10x20 set fontSize=0x0014000a)& (if defined fontSize reg add "HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe" /v "FontSize" /t REG_DWORD /d !fontSize! /f >nul)"& goto :EOF



:_setWallpaper
::ÉèÖÃ×ÀÃæ±ÚÖ½  »áÔÚ%temp%Ä¿Â¼Éú³Étool_setWallpaper.vbs
::IN[±ÚÖ½Â·¾¶±äÁ¿Ãû]
set "_setWallpaper=do setlocal enabledelayedexpansion& (if not exist %temp%\tool_setWallpaper.vbs (echo Dim shApp, picFile, items& echo Set shApp = CreateObject^("Shell.Application"^)& echo Set picFile = CreateObject^("Scripting.FileSystemObject"^).GetFile^(Wscript.Arguments^(0^)^)& echo Set items = shApp.NameSpace^(picFile.ParentFolder.Path^).ParseName^(picFile.Name^).Verbs& echo For Each item In items& echo   If item.Name = "ÉèÖÃÎª×ÀÃæ±³¾°(^&B)" Then item.DoIt& echo Next& echo WScript.Sleep 3000)>%temp%\tool_setWallpaper.vbs)& for /f "delims=" %%i in ("!%%1!") do call %temp%\tool_setWallpaper.vbs "%%~i""& goto :EOF



:_readConfig
::¶ÁÈ¡Ö¸¶¨ÅäÖÃÎÄ¼şÖ¸¶¨keyÖµ      ´ÓÅäÖÃÎÄ¼şÖĞ¶Á³ö¼üÎªkeyµÄÖµ, Èç¹ûvalue²ÎÊı´æÔÚ, ½«ÖµÉèÖÃµ½valueÖĞ, ·ñÔòÉèÖÃµ½keyÖĞ
::    ×¢Òâ:forÓï¾ä¶ÁÈ¡ÎÄ¼şÊ±Ä¬ÈÏÌø¹ı;¿ªÍ·µÄĞĞ, Òò´Ë;¿ªÍ·µÄĞĞ¿ÉÒÔ×÷Îª×¢ÊÍ
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN[key]    {OUT[value±äÁ¿Ãû]}
set "_readConfig=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do if %%i==%%2 endlocal& if "%%3" EQU "" (set "%%2=%%j") else (set "%%3=%%j")"& goto :EOF

:_readConfigMulti
::¶ÁÈ¡Ö¸¶¨ÅäÖÃÎÄ¼şÖ¸¶¨µÄ¶à¸ökeyÖµ      ´ÓÅäÖÃÎÄ¼şÖĞ¶Á³ö¼üÎªkeyµÄÖµ, Èç¹ûvalue²ÎÊı´æÔÚ, ½«ÖµÉèÖÃµ½valueÖĞ, ·ñÔòÉèÖÃµ½keyÖĞ
::    ×¢Òâ:forÓï¾ä¶ÁÈ¡ÎÄ¼şÊ±Ä¬ÈÏÌø¹ı;¿ªÍ·µÄĞĞ, Òò´Ë;¿ªÍ·µÄĞĞ¿ÉÒÔ×÷Îª×¢ÊÍ
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN-OUT[keys±äÁ¿Ãû][¿Õ¸ñ·Ö¸ôkey]
set "_readConfigMulti=do setlocal enabledelayedexpansion& (for /f "tokens=1* delims==" %%i in (%%1) do (for %%k in (!%%2!) do (if %%i==%%k endlocal& set "%%k=%%j"& setlocal enabledelayedexpansion)))& endlocal"& goto :EOF
REM set "_readConfigMulti=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do (for %%k in (!%%2!) do (if %%i==%%k endlocal& set "%%k=%%j")& setlocal enabledelayedexpansion)& endlocal"& goto :EOF


:_writeConfig
::¶ÁÈ¡Ö¸¶¨ÅäÖÃÎÄ¼şÖ¸¶¨keyÖµ      ´ÓÅäÖÃÎÄ¼şÖĞÑ°ÕÒ¼üÎªkeyµÄĞĞ, Èç¹ûvalue²ÎÊı´æÔÚ, ½«ÖµÉèÎªvalue, ·ñÔò¶ÁÈ¡key±äÁ¿Öµ
::    ×¢Òâ:forÓï¾ä¶ÁÈ¡ÎÄ¼şÊ±Ä¬ÈÏÌø¹ı;¿ªÍ·µÄĞĞ, Òò´Ë;¿ªÍ·µÄĞĞ¿ÉÒÔ×÷Îª×¢ÊÍ
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN[key±äÁ¿Ãû]    {IN[value]}
set "_writeConfig=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do if %%j==%%2 (if "%%3" EQU "" (echo %%j=!%%2!) else (echo %%j=%%3)) else (echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF
:_writeConfig2
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN[key±äÁ¿Ãû]    {IN[value±äÁ¿Ãû]}
set "_writeConfig2=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do if %%j==%%2 (if "%%3" EQU "" (echo %%j=!%%2!) else (echo %%j=!%%3!)) else (echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF

:_writeConfigMulti
::½«Ö¸¶¨µÄ¶à¸ökeyÖµĞ´ÈëÅäÖÃÎÄ¼ş
::    ×¢Òâ:forÓï¾ä¶ÁÈ¡ÎÄ¼şÊ±Ä¬ÈÏÌø¹ı;¿ªÍ·µÄĞĞ, Òò´Ë;¿ªÍ·µÄĞĞ¿ÉÒÔ×÷Îª×¢ÊÍ
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN[keys±äÁ¿Ãû][¿Õ¸ñ·Ö¸ôkey]
set "_writeConfigMulti=do setlocal enabledelayedexpansion& (for /f "eol= delims=" %%i in (%%1) do set line=%%i& if "!line:~0,1!"==";" (echo %%i) else (for /f "tokens=1* delims==" %%j in ("!line!") do (set flag=0& (for %%k in (!%%2!) do if %%j==%%k set flag=1& echo %%j=!%%k!)& if !flag!==0 echo %%i)))>>%temp%\config.tmp& (copy /y %temp%\config.tmp %%1>nul)& (del /q %temp%\config.tmp)& endlocal"& goto :EOF




:_readConfig
::¶ÁÈ¡Ö¸¶¨ÅäÖÃÎÄ¼şÖ¸¶¨keyÖµ      ´ÓÅäÖÃÎÄ¼şÖĞ¶Á³ö¼üÎªkeyµÄÖµ, Èç¹ûvalue²ÎÊı´æÔÚ, ½«ÖµÉèÖÃµ½valueÖĞ, ·ñÔòÉèÖÃµ½keyÖĞ
::    ×¢Òâ:forÓï¾ä¶ÁÈ¡ÎÄ¼şÊ±Ä¬ÈÏÌø¹ı;¿ªÍ·µÄĞĞ, Òò´Ë;¿ªÍ·µÄĞĞ¿ÉÒÔ×÷Îª×¢ÊÍ
::IN[ÅäÖÃÎÄ¼şÂ·¾¶]    IN[key]    {OUT[value±äÁ¿Ãû]}
set "_readConfig=do setlocal enabledelayedexpansion& for /f "tokens=1* delims==" %%i in (%%1) do if %%i==%%2 endlocal& if "%%3" EQU "" (set "%%2=%%j") else (set "%%3=%%j")"& goto :EOF



:_getDate
::È¡µ±Ç°µÄÄêÔÂÈÕ
::OUT[Äê-ÔÂ-ÈÕ] {IN[separatorÁ¬½Ó·û], Ä¬ÈÏÖµÎª¿Õ}
set "_getDate=do setlocal enabledelayedexpansion& set dateTemp=!date:~0,10!& for %%i in ("!dateTemp:/=%%2!") do endlocal& set %%1=%%~i"& goto :EOF
:_getYear
::È¡µ±Ç°µÄÄê
::OUT[Äê]
set "_getYear=do setlocal enabledelayedexpansion& for %%i in ("!date:~0,4!") do endlocal& set %%1=%%~i"& goto :EOF
:_getMonth
::È¡µ±Ç°µÄÔÂ
::OUT[ÔÂ] {IN[needRemoveZeroPrefix]: 0·ñ 1ÊÇ}
::set "_getMonth=do setlocal enabledelayedexpansion& (if "!date:~5,1!" EQU "0" if "%%2" EQU "1" (set monthTemp=!date:~6,1!) else (set monthTemp=!date:~5,2!))& for %%i in (!monthTemp!) do endlocal& set %%1=%%i"& goto :EOF
set "_getMonth=do setlocal enabledelayedexpansion& (if "!date:~5,1!" EQU "0" if "%%2" EQU "1" (set needRemoveZeroPrefix=1) else (set needRemoveZeroPrefix=0))& (if !needRemoveZeroPrefix!==1 (set monthTemp=!date:~6,1!) else (set monthTemp=!date:~5,2!))& for %%i in (!monthTemp!) do endlocal& set %%1=%%i"& goto :EOF
:_getDay
::È¡µ±Ç°µÄÈÕ
::OUT[ÈÕ] {IN[needRemoveZeroPrefix]: 0·ñ 1ÊÇ}
set "_getDay=do setlocal enabledelayedexpansion& (if "!date:~8,1!" EQU "0" if "%%2" EQU "1" (set needRemoveZeroPrefix=1) else (set needRemoveZeroPrefix=0))& (if !needRemoveZeroPrefix!==1 (set dayTemp=!date:~9,1!) else (set dayTemp=!date:~8,2!))& for %%i in (!dayTemp!) do endlocal& set %%1=%%i"& goto :EOF



:_bell
::·¢Éù
set "_bell=echo "& goto :EOF



:_isOddNum
::ÊÇ·ñÊÇÆæÊı   µ÷ÓÃÕß: [(µ÷ÓÃÄÚÁ²º¯Êı) && echo isOddNum || echo non-isOddNum]
::IN[±äÁ¿Ãû]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isOddNum=do setlocal enabledelayedexpansion& set /a mod=!%%1! %% 2& if "!mod!"=="1" (endlocal& %_true%) else (endlocal& %_false%)"& goto :EOF



:_isEvenNum
::ÊÇ·ñÊÇÅ¼Êı   µ÷ÓÃÕß: [(µ÷ÓÃÄÚÁ²º¯Êı) && echo isEvenNum || echo non-isEvenNum]
::IN[±äÁ¿Ãû]
(if not defined _true call :_true)& (if not defined _false call :_false)
set "_isEvenNum=do setlocal enabledelayedexpansion& set /a mod=!%%1! %% 2& if "!mod!"=="0" (endlocal& %_true%) else (endlocal& %_false%)"& goto :EOF



:_showHR
::´òÓ¡ºáÏß
::IN[ÔªËØ(Ä¬ÈÏ-)]    IN[³¤¶È(Ä¬ÈÏ10)]
set "_showHR=do setlocal enabledelayedexpansion& (if "%%1" EQU "" (set hrElement=-) else (set hrElement=%%1))& (if "%%2" EQU "" (set hrLen=10) else (set hrLen=%%2))& set hrStr=& (for /l %%i in (1,1,!hrLen!) do set hrStr=!hrStr!!hrElement!)& echo !hrStr!"& goto :EOF








