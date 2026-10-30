@echo off
rem Cai add-in "QL_Format - Dinh dang de thi" (QL Physics) cho Word tren may nay - chi anh huong tai khoan Windows hien tai
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
echo Dang xoa bo nho tam add-in cua Word (de nhan giao dien moi)...
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo.
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysDinhDangDe" /t REG_SZ /d "%D%\manifest.xml" /f >nul
echo.
echo DA CAI XONG.
echo  1. Mo lai Word, mo file de.
echo  2. Tren thanh Ribbon co the moi ten "QL_Format" (Dung, Sai, A B C D, Muc do, Xuat GV + HS...).
echo  Neu chua thay the QL_Format: Insert (Chen) ^> My Add-ins (Phan bo tro cua toi) ^> Developer Add-ins ^> QL_Format.
echo.
pause
