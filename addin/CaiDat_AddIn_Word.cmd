@echo off
rem Cai add-in "QL_Format - Dinh dang de thi" (QL Physics) cho Word tren may nay - chi anh huong tai khoan Windows hien tai
setlocal
set "D=%LOCALAPPDATA%\QLPhysics\DinhDangDe"
if not exist "%D%" mkdir "%D%"
if exist "%D%\manifest.xml" del /q "%D%\manifest.xml"
rem Kiem tra phien ban Word: tu ban 2205 (build 15225) tro len dung che do chay thuong truc (nut bam nhanh hon)
set "WB=0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$b=0; try{$v=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration' -ErrorAction Stop).VersionToReport; $b=[int]($v.Split('.')[2])}catch{}; if($b -eq 0){try{$p=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe' -ErrorAction Stop).'(default)'; $b=[int]((Get-Item $p).VersionInfo.FileBuildPart)}catch{}}; $b" > "%TEMP%\qlf_wb.txt" 2>nul
if exist "%TEMP%\qlf_wb.txt" set /p WB=<"%TEMP%\qlf_wb.txt"
set /a WB=%WB%+0 >nul 2>&1 || set "WB=0"
set "M=manifest_cu.xml"
if %WB% GEQ 15225 set "M=manifest.xml"
if "%M%"=="manifest.xml" (echo Word build %WB%: dung che do nhanh - chay thuong truc.) else (echo Word build %WB%: dung che do thuong.)
echo Dang tai file cau hinh add-in...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/%M%' -OutFile '%D%\manifest.xml'"
if not exist "%D%\manifest.xml" if exist "%~dp0%M%" (
  echo Khong tai duoc qua mang, dung file %M% di kem bo cai.
  copy /y "%~dp0%M%" "%D%\manifest.xml" >nul
)
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
rem go ban thu "Thu SR" neu con
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThuSR" /f >nul 2>&1
if exist "%LOCALAPPDATA%\QLPhysics\ThuSR" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\ThuSR"
echo.
echo DA CAI XONG.
echo  1. Mo lai Word, mo file de.
echo  2. Tren thanh Ribbon co the moi ten "QL_Format" (Dung, Sai, A B C D, Muc do, Xuat GV + HS...).
echo  Neu chua thay the QL_Format: Insert (Chen) ^> My Add-ins (Phan bo tro cua toi) ^> Developer Add-ins ^> QL_Format.
echo.
pause
