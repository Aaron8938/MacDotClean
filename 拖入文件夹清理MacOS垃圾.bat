@echo off
chcp 65001 >nul
title macOS 垃圾清理工具 - 自定义路径
color 07

echo.
echo  =========================================================
echo         macOS 垃圾清理工具  v1.0
echo  =========================================================
echo.

set /p "targetPath=  请拖入或输入需要清理的文件夹路径，然后按回车："

:: 去除首尾引号
set "targetPath=%targetPath:"=%"

:: 去除末尾反斜杠
if "%targetPath:~-1%"=="\" set "targetPath=%targetPath:~0,-1%"

:: 校验是否为空
if "%targetPath%"=="" (
    echo.
    echo  [错误] 未输入路径，按任意键退出...
    pause >nul
    exit /b
)

:: 校验路径是否存在
if not exist "%targetPath%" (
    echo.
    echo  [错误] 路径不存在: %targetPath%
    echo  按任意键退出...
    pause >nul
    exit /b
)

:: 校验是否为文件夹
if not exist "%targetPath%\" (
    echo.
    echo  [错误] 不是文件夹: %targetPath%
    echo  按任意键退出...
    pause >nul
    exit /b
)

echo.
echo  目标路径: %targetPath%
echo.
echo  将清理该路径下所有子文件夹中的 macOS 垃圾文件
echo.
echo  正在扫描和清理...
echo.

:: 删除 macOS 垃圾文件
powershell -Command "Get-ChildItem -Path '%targetPath%' -Recurse -Force -Include '.DS_Store','._*','.LSOverride' -File | ForEach-Object { Write-Host '  [删除文件]' $_.Name; Remove-Item $_.FullName -Force }"

:: 删除 macOS 垃圾目录
powershell -Command "Get-ChildItem -Path '%targetPath%' -Recurse -Force -Directory | Where-Object { $_.Name -in '.AppleDouble','.Spotlight-V100','Spotlight','.Trashes','.fseventsd','TemporaryItems','.TemporaryItems','.VolumeIcon.icns','.com.apple.timemachine.donotpresent','DocumentRevisions-V100' } | ForEach-Object { Write-Host '  [删除目录]' $_.Name; Remove-Item $_.FullName -Recurse -Force }"

echo.
echo  =========================================================
echo  === 清理完成 ===
echo  =========================================================
echo.
<nul set /p "=  按任意键退出..."
pause >nul
