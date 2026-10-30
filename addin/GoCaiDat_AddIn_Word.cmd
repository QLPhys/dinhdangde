@echo off
rem Go add-in "QL_Format - Dinh dang de thi" (QL Physics) khoi Word tren may nay
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysDinhDangDe" /f >nul 2>&1
if exist "%LOCALAPPDATA%\QLPhysics\DinhDangDe" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\DinhDangDe"
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
echo Da go add-in QL_Format. Mo lai Word, the QL_Format se khong con.
pause
