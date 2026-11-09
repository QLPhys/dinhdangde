@echo off
rem Cai add-in "PhongEm.Phys - Dinh dang de thi" cho Word.
rem Cai qua "thu muc dung chung" (Trusted Add-in Catalog) de the PhongEm.Phys LUON HIEN tren Ribbon moi lan mo Word.
rem (Tu ban cap nhat Microsoft 365 cuoi thang 9/2026, add-in cai kieu "Developer" bi mat sau moi lan dong Word.)
setlocal
set "CAT=%PUBLIC%\PhongEmPhys\Addin"
set "SHARE=PhongEmPhysAddin"
set "GUID={8B2F4D6A-1C3E-4A5B-9D7F-0E1A2B3C4D5E}"
if not exist "%CAT%" mkdir "%CAT%"
if exist "%CAT%\manifest.xml" del /q "%CAT%\manifest.xml"
rem Kiem tra phien ban Word: tu ban 2205 (build 15225) tro len dung che do chay thuong truc (nut bam nhanh hon)
set "WB=0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$b=0; try{$v=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration' -ErrorAction Stop).VersionToReport; $b=[int]($v.Split('.')[2])}catch{}; if($b -eq 0){try{$p=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe' -ErrorAction Stop).'(default)'; $b=[int]((Get-Item $p).VersionInfo.FileBuildPart)}catch{}}; $b" > "%TEMP%\qlf_wb.txt" 2>nul
if exist "%TEMP%\qlf_wb.txt" set /p WB=<"%TEMP%\qlf_wb.txt"
set /a WB=%WB%+0 >nul 2>&1 || set "WB=0"
set "M=manifest_cu.xml"
if %WB% GEQ 15225 set "M=manifest.xml"
if "%M%"=="manifest.xml" (echo Word build %WB%: dung che do nhanh - chay thuong truc.) else (echo Word build %WB%: dung che do thuong.)
echo Dang tai file cau hinh add-in...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing -Uri 'https://qlphys.github.io/dinhdangde/addin/pe/%M%' -OutFile '%CAT%\manifest.xml'"
if not exist "%CAT%\manifest.xml" if exist "%~dp0%M%" (
  echo Khong tai duoc qua mang, dung file %M% di kem bo cai.
  copy /y "%~dp0%M%" "%CAT%\manifest.xml" >nul
)
if not exist "%CAT%\manifest.xml" (
  echo KHONG TAI DUOC. Kiem tra mang Internet roi chay lai.
  pause
  exit /b 1
)
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo.
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
echo.
echo Dang tao thu muc dung chung cho add-in.
echo  Windows se hien hop "Ban co muon cho phep ung dung nay thay doi thiet bi?" - hay chon YES (Co).
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath powershell.exe -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile -ExecutionPolicy Bypass -EncodedCommand JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQA9ACcAUwB0AG8AcAAnAAoAJABwACAAPQAgAEoAbwBpAG4ALQBQAGEAdABoACAAJABlAG4AdgA6AFAAVQBCAEwASQBDACAAJwBQAGgAbwBuAGcARQBtAFAAaAB5AHMAXABBAGQAZABpAG4AJwAKAHQAcgB5ACAAewAgAFMAZQB0AC0AUwBlAHIAdgBpAGMAZQAgAC0ATgBhAG0AZQAgAEwAYQBuAG0AYQBuAFMAZQByAHYAZQByACAALQBTAHQAYQByAHQAdQBwAFQAeQBwAGUAIABBAHUAdABvAG0AYQB0AGkAYwAgAC0ARQByAHIAbwByAEEAYwB0AGkAbwBuACAAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQA7ACAAUwB0AGEAcgB0AC0AUwBlAHIAdgBpAGMAZQAgAC0ATgBhAG0AZQAgAEwAYQBuAG0AYQBuAFMAZQByAHYAZQByACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACAAfQAgAGMAYQB0AGMAaAAgAHsAfQAKACQAbgAgAD0AIAAoAFsAUwBlAGMAdQByAGkAdAB5AC4AUAByAGkAbgBjAGkAcABhAGwALgBTAGUAYwB1AHIAaQB0AHkASQBkAGUAbgB0AGkAZgBpAGUAcgBdACcAUwAtADEALQAxAC0AMAAnACkALgBUAHIAYQBuAHMAbABhAHQAZQAoAFsAUwBlAGMAdQByAGkAdAB5AC4AUAByAGkAbgBjAGkAcABhAGwALgBOAFQAQQBjAGMAbwB1AG4AdABdACkALgBWAGEAbAB1AGUACgBHAGUAdAAtAFMAbQBiAFMAaABhAHIAZQAgAC0ATgBhAG0AZQAgACcAUABoAG8AbgBnAEUAbQBQAGgAeQBzAEEAZABkAGkAbgAnACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACAAfAAgAFIAZQBtAG8AdgBlAC0AUwBtAGIAUwBoAGEAcgBlACAALQBGAG8AcgBjAGUAIAAtAEUAcgByAG8AcgBBAGMAdABpAG8AbgAgAFMAaQBsAGUAbgB0AGwAeQBDAG8AbgB0AGkAbgB1AGUACgBOAGUAdwAtAFMAbQBiAFMAaABhAHIAZQAgAC0ATgBhAG0AZQAgACcAUABoAG8AbgBnAEUAbQBQAGgAeQBzAEEAZABkAGkAbgAnACAALQBQAGEAdABoACAAJABwACAALQBSAGUAYQBkAEEAYwBjAGUAcwBzACAAJABuACAAfAAgAE8AdQB0AC0ATgB1AGwAbAAKAA==' } catch { }"
set "UNC=\\%COMPUTERNAME%\%SHARE%"
if not exist "%UNC%\manifest.xml" goto cachcu
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%GUID%" /v "Id" /t REG_SZ /d "%GUID%" /f >nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%GUID%" /v "Url" /t REG_SZ /d "%UNC%" /f >nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%GUID%" /v "Flags" /t REG_DWORD /d 1 /f >nul
rem bo cach cai cu (Developer) de khong bi 2 the PhongEm.Phys
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "PhongEmPhys" /f >nul 2>&1
if exist "%LOCALAPPDATA%\PhongEmPhys\Addin" rmdir /s /q "%LOCALAPPDATA%\PhongEmPhys\Addin"
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
echo.
echo DA CAI XONG (thu muc dung chung: %UNC%).
echo  LAM 1 LAN DUY NHAT sau khi cai:
echo   1. Mo Word, mo mot file bat ky.
echo   2. Insert (Chen) ^> My Add-ins (Phan bo tro cua toi)
echo      (Word moi: Home ^> Add-ins ^> More Add-ins / Advanced)
echo   3. Chon the SHARED FOLDER (THU MUC DUNG CHUNG) ^> PhongEm.Phys ^> Add (Them).
echo  Tu lan sau, moi lan mo Word the "PhongEm.Phys" luon co san tren Ribbon.
echo.
pause
exit /b 0

:cachcu
echo.
echo KHONG TAO DUOC THU MUC DUNG CHUNG (chua cho phep quyen quan tri, hoac may chan chia se).
echo Tam cai theo cach cu. Luu y: voi ban Word moi, moi lan mo Word co the phai goi lai add-in:
echo   Insert (Chen) ^> My Add-ins ^> Developer Add-ins ^> PhongEm.Phys.
echo Muon the PhongEm.Phys luon hien: chay lai bo cai nay va chon YES khi Windows hoi.
set "D=%LOCALAPPDATA%\PhongEmPhys\Addin"
if not exist "%D%" mkdir "%D%"
copy /y "%CAT%\manifest.xml" "%D%\manifest.xml" >nul
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
reg add "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "PhongEmPhys" /t REG_SZ /d "%D%\manifest.xml" /f >nul
echo.
pause
