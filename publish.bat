@echo off
setlocal enabledelayedexpansion
cd /d "D:\01 Google DahuaDSS\01 DSS CLUB\18 Web bán hàng SD\01_TONG_QUAN_LY_DU_AN\11_Trinh_Bay"

echo.
echo ========================================
echo   PUBLISH len GitHub Pages - Kho Tot
echo ========================================
echo.
echo Danh sach file HTML trong thu muc:
echo.

set COUNT=0
for %%f in (*.html) do (
    set /a COUNT+=1
    set "FILE_!COUNT!=%%f"
    echo   [!COUNT!] %%f
)

if !COUNT!==0 (
    echo   Khong co file HTML nao trong thu muc!
    pause
    exit /b
)

echo.
set /p CHOICE="Chon so thu tu file can push (1-!COUNT!): "

set "SELECTED=!FILE_%CHOICE%!"

if "!SELECTED!"=="" (
    echo Lua chon khong hop le!
    pause
    exit /b
)

echo.
echo >> Dang xu ly: !SELECTED!
echo.

:: Luon git add file HTML va thu muc images de dam bao du tai nguyen
git add "!SELECTED!"
if exist "images" (
    echo >> Dang dong bo thu muc images...
    git add "images/"
)

:: Kiem tra co gi de commit khong
git diff --cached --quiet
if !errorlevel!==0 (
    echo File nay chua co thay doi moi, khong can commit.
) else (
    git commit -m "Deploy: !SELECTED!"
    git push origin main
    echo.
    echo ========================================
    echo   XONG! Truy cap tai:
    echo   https://babaduoc.github.io/presentations_Khotot/!SELECTED!
    echo ========================================
)

echo.
pause
