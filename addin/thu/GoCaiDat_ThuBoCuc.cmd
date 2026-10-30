@echo off
rem Go 2 the thu bo cuc (Thu 1, Thu 2). The QL_Format van giu nguyen.
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThu1" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThu2" /f >nul 2>&1
if exist "%LOCALAPPDATA%\QLPhysics\ThuBoCuc" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\ThuBoCuc"
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
echo Da go 2 the thu bo cuc.
pause
