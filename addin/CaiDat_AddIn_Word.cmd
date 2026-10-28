@echo off
rem Cai add-in "Dinh dang de thi" (QL Physics) cho Word tren may nay - chi anh huong tai khoan Windows hien tai
setlocal
set "D=%LOCALAPPDATA%\QLPhysics\DinhDangDe"
if not exist "%D%" mkdir "%D%"
echo Dang tai file cau hinh add-in...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/manifest.xml' -OutFile '%D%\manifest.xml'"
if not exist "%D%\manifest.xml" (
  echo KHONG TAI DUOC. Kiem tra mang Internet roi chay lai.
  pause
  exit /b 1
)
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysDinhDangDe" /t REG_SZ /d "%D%\manifest.xml" /f >nul
echo.
echo DA CAI XONG.
echo  1. Dong het cac cua so Word, roi mo lai Word.
echo  2. Mo file de tho, vao the Home (Trang dau), bam nut "Dinh dang de" (nhom QL Physics).
echo  Neu chua thay nut: Insert (Chen) ^> My Add-ins (Phan bo tro cua toi) ^> Developer Add-ins ^> Dinh dang de thi.
echo.
pause
