@echo off
rem Go add-in "PhongEm.Phys - Dinh dang de thi" khoi Word tren may nay
set "GUID={8B2F4D6A-1C3E-4A5B-9D7F-0E1A2B3C4D5E}"
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%GUID%" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "PhongEmPhys" /f >nul 2>&1
echo Dang go thu muc dung chung (Windows co the hoi quyen quan tri - chon YES)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath powershell.exe -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile -ExecutionPolicy Bypass -EncodedCommand RwBlAHQALQBTAG0AYgBTAGgAYQByAGUAIAAtAE4AYQBtAGUAIAAnAFAAaABvAG4AZwBFAG0AUABoAHkAcwBBAGQAZABpAG4AJwAgAC0ARQByAHIAbwByAEEAYwB0AGkAbwBuACAAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQAgAHwAIABSAGUAbQBvAHYAZQAtAFMAbQBiAFMAaABhAHIAZQAgAC0ARgBvAHIAYwBlACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlAAoA' } catch { }"
if exist "%PUBLIC%\PhongEmPhys\Addin" rmdir /s /q "%PUBLIC%\PhongEmPhys\Addin"
if exist "%LOCALAPPDATA%\PhongEmPhys\Addin" rmdir /s /q "%LOCALAPPDATA%\PhongEmPhys\Addin"
rem KHONG xoa bo nho tam Wef cua Word: xoa se lam mat ca cac add-in khac da them tu thu muc dung chung
echo Da go add-in PhongEm.Phys. Mo lai Word, the PhongEm.Phys se khong con.
pause
