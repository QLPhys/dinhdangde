@echo off
rem Go add-in "Dinh dang de thi" (QL Physics) khoi Word tren may nay
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysDinhDangDe" /f >nul 2>&1
if exist "%LOCALAPPDATA%\QLPhysics\DinhDangDe" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\DinhDangDe"
echo Da go add-in. Dong Word va mo lai.
pause
