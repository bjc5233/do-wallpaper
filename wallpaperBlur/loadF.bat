@echo off& set base=%~d0%~p0loadFuncs
for %%i in (%*) do set %%i=%base%\%%i.bat
::Author[Allen]    ����[bjc5233@gmail.com]    �ۿ�[692008411]    words[�й�ͬ��Ȥ,�н���,��bug����ӭ����ϵ��Ŷ~]
::����
::  load.bat������������[������], ���Խ�����������һ������������, �ٶ���call��ʽ��10������
::  loadF.bat���ǹ����޷���laod.bat���ɵĺ���[������], ����Ҫ�����ǩ�ĺ���, �ٶ���ֱ��call xx.exe�����޲��
::ʹ�÷�ʽ
::  call loadF.bat _fun1 _func2...   ������ӳ��Ϊ����·��
::  call %_fun1% param1 param2...