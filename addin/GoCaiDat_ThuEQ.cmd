@echo off
rem Go add-in THU NGHIEM "Thu EQ" - ban chinh thuc QL_Format van giu nguyen
tasklist /fi "imagename eq WINWORD.EXE" 2>nul | find /i "WINWORD.EXE" >nul && (
  echo Word dang mo. Hay DONG HET Word roi bam phim bat ky de tiep tuc...
  pause >nul
)
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "QLPhysThuEQ" /f >nul 2>&1
if exist "%LOCALAPPDATA%\QLPhysics\ThuEQ" rmdir /s /q "%LOCALAPPDATA%\QLPhysics\ThuEQ"
rem KHONG xoa bo nho tam Wef cua Word: xoa se lam mat QL_Format da them tu thu muc dung chung
echo Da go ban thu "Thu EQ". The QL_Format chinh thuc van con.
pause
