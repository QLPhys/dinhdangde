@echo off
rem Go add-in "QL_Format - Dinh dang de thi" (QL Physics) khoi Word tren may nay
set "GUID={5D6E8A1C-3F2B-4C7D-9E10-A2B3C4D5E6F7}"
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%GUID%" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysDinhDangDe" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThuSR" /f >nul 2>&1
echo Dang go thu muc dung chung (Windows co the hoi quyen quan tri - chon YES)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath powershell.exe -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile -ExecutionPolicy Bypass -EncodedCommand RwBlAHQALQBTAG0AYgBTAGgAYQByAGUAIAAtAE4AYQBtAGUAIAAnAFEATABGAG8AcgBtAGEAdABBAGQAZABpAG4AJwAgAC0ARQByAHIAbwByAEEAYwB0AGkAbwBuACAAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQAgAHwAIABSAGUAbQBvAHYAZQAtAFMAbQBiAFMAaABhAHIAZQAgAC0ARgBvAHIAYwBlACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlAAoA' } catch { }"
if exist "%PUBLIC%\QLPhysics\QLFormat" rmdir /s /q "%PUBLIC%\QLPhysics\QLFormat"
if exist "%LOCALAPPDATA%\QLPhysics\DinhDangDe" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\DinhDangDe"
if exist "%LOCALAPPDATA%\QLPhysics\ThuSR" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\ThuSR"
if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rmdir /s /q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
echo Da go add-in QL_Format. Mo lai Word, the QL_Format se khong con.
pause
