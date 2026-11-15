@echo off
rem KIEM TRA add-in QL_Format / PhongEm.Phys tren may nay. CHI DOC thong tin, KHONG thay doi gi.
rem Ket qua ghi vao file KiemTra_AddIn.txt tren Desktop roi tu mo bang Notepad.
setlocal
set "O=%USERPROFILE%\Desktop\KiemTra_AddIn.txt"
> "%O%" echo ===== KIEM TRA ADD-IN QL_Format / PhongEm.Phys =====
>>"%O%" echo May: %COMPUTERNAME%   Nguoi dung: %USERNAME%   Ngay: %DATE% %TIME%
>>"%O%" echo.
>>"%O%" echo --- Quyen quan tri ---
net session >nul 2>&1 && (>>"%O%" echo Dang chay voi quyen quan tri) || (>>"%O%" echo Khong co quyen quan tri trong lan chay nay)
whoami /groups 2>nul | find /i "S-1-5-32-544" >nul && (>>"%O%" echo Tai khoan thuoc nhom Administrators) || (>>"%O%" echo Tai khoan KHONG thuoc nhom Administrators)
>>"%O%" echo.
>>"%O%" echo --- Phien ban Office / Word ---
reg query "HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" /v VersionToReport >>"%O%" 2>&1
reg query "HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" /v ProductReleaseIds >>"%O%" 2>&1
reg query "HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" /v UpdatesEnabled >>"%O%" 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "try{$p=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe' -ErrorAction Stop).'(default)'; 'WINWORD.EXE: ' + $p + '  ban ' + (Get-Item $p).VersionInfo.FileVersion}catch{'Khong doc duoc ban WINWORD.EXE'}" >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Trinh duyet chay add-in (WebView2) ---
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /v pv >>"%O%" 2>&1
reg query "HKCU\Software\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /v pv >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Thu muc dung chung da khai bao cho Word (TrustedCatalogs) ---
reg query "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs" /s >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Chinh sach co the chan add-in ---
reg query "HKCU\Software\Policies\Microsoft\Office\16.0\WEF" /s >>"%O%" 2>&1
reg query "HKLM\SOFTWARE\Policies\Microsoft\Office\16.0\WEF" /s >>"%O%" 2>&1
reg query "HKCU\Software\Policies\Microsoft\Office\16.0\Common\Security" /s >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Add-in cai kieu Developer ---
reg query "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /s >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Thu muc chia se tren may ---
net share >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Dich vu chia se file (LanmanServer) ---
sc query LanmanServer >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Thu muc %PUBLIC%\WordAddins ---
dir "%PUBLIC%\WordAddins" >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Doc thu qua duong mang \\%COMPUTERNAME%\WordAddins ---
dir "\\%COMPUTERNAME%\WordAddins" >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Noi dung chinh cua file cau hinh add-in ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath (Join-Path $env:PUBLIC 'WordAddins') -Filter *.xml -ErrorAction SilentlyContinue | ForEach-Object { $f = $_; try { [xml]$x = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8; $f.Name + ': Id=' + $x.OfficeApp.Id + '  Version=' + $x.OfficeApp.Version + '  Ten=' + $x.OfficeApp.DisplayName.DefaultValue + '  Kieu=' + $(if ((Get-Content -LiteralPath $f.FullName -Raw) -match 'lifetime=.long') {'thuong truc'} else {'thuong'}) } catch { $f.Name + ': FILE LOI - ' + $_.Exception.Message } }" >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Ket noi toi trang add-in ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; foreach($u in @('https://qlphys.github.io/dinhdangde/addin/pe/taskpane.html','https://qlphys.github.io/dinhdangde/addin/taskpane.html','https://appsforoffice.microsoft.com/lib/1/hosted/office.js')){ try { $r=Invoke-WebRequest -UseBasicParsing -Uri $u -Method Head -TimeoutSec 15; $u + ' -> ' + $r.StatusCode } catch { $u + ' -> LOI: ' + $_.Exception.Message } }" >>"%O%" 2>&1
>>"%O%" echo.
>>"%O%" echo --- Bo nho tam add-in cua Word (chi liet ke ten) ---
dir /b "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" >>"%O%" 2>&1
>>"%O%" echo ===== HET =====
copy /y "%O%" "%~dp0KiemTra_AddIn.txt" >nul 2>&1
start "" notepad "%O%"
echo Da ghi ket qua vao %O%
echo Gui file nay cho thay Lap de kiem tra.
pause
