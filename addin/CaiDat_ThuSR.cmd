@echo off
rem Cai add-in THU NGHIEM "Thu SR" (tang toc Ribbon) - dung song song voi QL_Format, khong anh huong ban chinh thuc
setlocal
set "D=%LOCALAPPDATA%\QLPhysics\ThuSR"
if not exist "%D%" mkdir "%D%"
if exist "%D%\manifest_sr.xml" del /q "%D%\manifest_sr.xml"
echo Dang tai file cau hinh add-in thu nghiem...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/manifest_sr.xml' -OutFile '%D%\manifest_sr.xml'"
if not exist "%D%\manifest_sr.xml" if exist "%~dp0manifest_sr.xml" copy /y "%~dp0manifest_sr.xml" "%D%\manifest_sr.xml" >nul
if not exist "%D%\manifest_sr.xml" (
  echo KHONG TAI DUOC. Kiem tra mang Internet roi chay lai.
  pause
  exit /b 1
)
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo.
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThuSR" /t REG_SZ /d "%D%\manifest_sr.xml" /f >nul
echo.
echo DA CAI XONG BAN THU.
echo  Mo lai Word, mo file de: tren Ribbon co them the "Thu SR" (canh the QL_Format).
echo  Neu chua thay: Insert ^> My Add-ins ^> Developer Add-ins ^> QL_Format Thu SR.
echo.
pause
