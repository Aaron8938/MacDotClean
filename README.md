# MacDotClean — U盘 macOS 垃圾文件清理工具

把工具放入 U 盘根目录，双击运行即可清理 macOS 在 U 盘上自动生成的各种隐藏垃圾文件。

## 清理内容

| 类型 | 目标 |
|------|------|
| 文件 | `.DS_Store`、`._*`（资源分支文件） |
| 目录 | `.AppleDouble`、`.Spotlight-V100`、`.Trashes`、`.fseventsd`、`TemporaryItems` 等 |

## 使用方式

### macOS

双击运行 `双击清理MacOS垃圾.command`

如果遇到权限问题，先执行：

```bash
chmod +x 双击清理MacOS垃圾.command
```

### Windows

双击运行 `双击清理MacOS垃圾.bat`（需要 PowerShell）

## 原理

macOS 连接 U 盘等外置存储时，会自动写入一些隐藏文件用于 Spotlight 索引、文件预览缓存、资源分支等。在 Windows 或其他系统上这些文件无用且碍眼（尤其是 `._` 文件和 `.DS_Store`）。本工具批量扫描并清除这些文件。

## 安全说明

- 仅删除已知的 macOS 垃圾文件/目录，不会误删用户数据
- 仅作用于脚本所在目录及其子目录（即 U 盘根目录）
