#!/bin/bash
# U盘 macOS 垃圾清理工具 v2.0
# 放入U盘根目录，双击运行即可
# 清理目标：.DS_Store、._*、.AppleDouble、.Spotlight-*、.Trashes、.fseventsd 等 macOS 产生的垃圾文件

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================================"
echo "       U盘 macOS 垃圾清理工具  v2.0"
echo "========================================================"
echo ""
echo "目标: $SCRIPT_DIR"
echo "--------------------------------------------------------"

file_count=0
dir_count=0

# 清理 .DS_Store 文件
while IFS= read -r -d '' file; do
    echo "[删除] $(basename "$file")"
    rm -f "$file"
    ((file_count++))
done < <(find "$SCRIPT_DIR" -depth -name ".DS_Store" -print0 2>/dev/null)

# 清理 ._* 文件
while IFS= read -r -d '' file; do
    echo "[删除] $(basename "$file")"
    rm -f "$file"
    ((file_count++))
done < <(find "$SCRIPT_DIR" -depth -name "._*" -print0 2>/dev/null)

# 清理垃圾目录
junk_dirs=(
    ".AppleDouble"
    ".Spotlight-V100"
    ".Spotlight"
    ".Trashes"
    ".fseventsd"
    ".VolumeIcon.icns"
    ".com.apple.timemachine.donotpresent"
    "DocumentRevisions-V100"
    "TemporaryItems"
    ".TemporaryItems"
)

for dir_name in "${junk_dirs[@]}"; do
    while IFS= read -r -d '' dir; do
        echo "[删除目录] $(basename "$dir")"
        rm -rf "$dir"
        ((dir_count++))
    done < <(find "$SCRIPT_DIR" -depth -type d -name "$dir_name" -print0 2>/dev/null)
done

echo "--------------------------------------------------------"
echo ""
echo "=== 清理完成 ==="
echo ""
echo "  删除文件: $file_count 个"
echo "  删除目录: $dir_count 个"
echo ""
echo "可以安全拔出U盘了。"
echo ""
echo "按 Enter 键退出..."
read -r
