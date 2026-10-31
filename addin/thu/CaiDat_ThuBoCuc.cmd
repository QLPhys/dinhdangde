@echo off
rem Cai 2 the thu bo cuc (Thu 1, Thu 2) de xem Word ve nhom nut ra sao. Khong anh huong the QL_Format.
setlocal
set "D=%LOCALAPPDATA%\QLPhysics\ThuBoCuc"
if not exist "%D%" mkdir "%D%"
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
for %%n in (1 2) do powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/thu/manifest_thu%%n.xml' -OutFile '%D%\manifest_thu%%n.xml'"
if not exist "%D%\manifest_thu2.xml" (
  echo KHONG TAI DUOC. Kiem tra mang Internet roi chay lai.
  pause
  exit /b 1
)
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThu1" /t REG_SZ /d "%D%\manifest_thu1.xml" /f >nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThu2" /t REG_SZ /d "%D%\manifest_thu2.xml" /f >nul
echo.
echo DA CAI XONG. Mo Word (phong to toan man hinh), xem 2 the "Thu 1" va "Thu 2", chup anh gui lai.
echo Xem xong chay GoCaiDat_ThuBoCuc.cmd de go.
pause
