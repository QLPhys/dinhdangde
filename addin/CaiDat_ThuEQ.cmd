@echo off
rem Cai add-in THU NGHIEM "Thu EQ" (nut Equation) - dung song song voi QL_Format, khong anh huong ban chinh thuc
setlocal
set "D=%LOCALAPPDATA%\QLPhysics\ThuEQ"
if not exist "%D%" mkdir "%D%"
if exist "%D%\manifest_eq.xml" del /q "%D%\manifest_eq.xml"
echo Dang tai file cau hinh add-in thu nghiem...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/manifest_eq.xml' -OutFile '%D%\manifest_eq.xml'"
if not exist "%D%\manifest_eq.xml" if exist "%~dp0manifest_eq.xml" copy /y "%~dp0manifest_eq.xml" "%D%\manifest_eq.xml" >nul
if not exist "%D%\manifest_eq.xml" (
  echo KHONG TAI DUOC. Kiem tra mang Internet roi chay lai.
  pause
  exit /b 1
)
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo.
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
rem KHONG xoa bo nho tam Wef cua Word: xoa se lam mat QL_Format da them tu thu muc dung chung
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThuEQ" /t REG_SZ /d "%D%\manifest_eq.xml" /f >nul
echo.
echo DA CAI XONG BAN THU.
echo  Mo lai Word, mo file de: tren Ribbon co them the "Thu EQ" (canh the QL_Format).
echo  Neu chua thay: Insert ^> My Add-ins ^> Developer Add-ins ^> QL_Format Thu EQ.
echo.
pause
