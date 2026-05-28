@echo off
chcp 65001 >nul
title U盘 macOS 垃圾清理工具
color 07

:: 自动获取U盘根目录（脚本所在位置）
set "targetPath=%~dp0"

echo.
echo  =========================================================
echo          U盘 macOS 垃圾清理工具  v1.0
echo  =========================================================
echo.
echo  将清理 U盘 根目录中的 macOS 垃圾文件
echo  目标: %targetPath%
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
echo  按任意键退出...
pause >nul
