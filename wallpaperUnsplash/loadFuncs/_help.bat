@echo off& setlocal enabledelayedexpansion
:::˵��
:::  ��ӡ����\ע��[������:��ͷ����]��Ϣ
:::����
:::  [batFile]
:::      batFile - bat�ļ�·��
if "%1"=="" (set batFile=%~f0) else (set batFile=%~1)
set descFlag=0
set tipStr=:::====================================================
echo :::[%batFile%]
echo %tipStr%
echo :::
for /f "delims=" %%i in (!batFile!) do (
	if !descFlag!==2 (echo :::& echo %tipStr%& endlocal& goto :EOF)
	set "curLine=%%i"& set prefix=!curLine:~0,3!
	if "!prefix!"==":::" (
		set descFlag=1
		echo %%i
	) else (
		if !descFlag!==1 set descFlag=2
	)
)
echo %tipStr%& endlocal