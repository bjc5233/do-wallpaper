@echo off& call loadE eecho
::˵��
::  ��ӡ������Ϣ���˳��ű�
::����
::  [��Դ] [������Ϣ]
%eecho% -b 0 -f 12 errorMsg[%~1]:
%eecho% -b 0 -f 12 "     %~2"
pause>nul& exit