#!/usr/bin/env bash
# 重装前备份脚本 —— 把"不在 git 里"的数据全部打包
# 用法: ./backup.sh <目标目录>
# 例:   ./backup.sh /run/media/$USER/Backup     (外置盘)
#       ./backup.sh /home/voiddreamz/data/_backup (data 分区, 前提是重装保留该分区)
set -euo pipefail

TARGET="${1:?用法: $0 <目标目录>}"
mkdir -p "$TARGET"
echo "==> 备份到: $TARGET"

# 1. doc/ 数据 (8.8G) —— 排除 heart(git 仓库, 已上云)
echo "==> [1/6] doc/ 数据 ..."
rsync -a --exclude 'heart' --info=progress2 ~/doc/ "$TARGET/doc/"

# 2. 密钥与凭据 (含 .mbsyncrc 明文邮箱授权码)
echo "==> [2/6] 密钥 .ssh/.gnupg/.mbsyncrc/.gitconfig ..."
tar czf "$TARGET/keys.tar.gz" -C ~ .ssh .gnupg .mbsyncrc .gitconfig

# 3. Zotero 文献库 + 游戏存档
echo "==> [3/6] Zotero + 游戏存档 ..."
tar czf "$TARGET/zotero.tar.gz" -C ~ .zotero Zotero 2>/dev/null || true
tar czf "$TARGET/gamesaves.tar.gz" -C ~ "Larian Studios" FiraxisLive 2>/dev/null || true
tar czf "$TARGET/dos2-backup.tar.gz" -C ~/tmp dos2-backup 2>/dev/null || true

# 4. /etc 关键系统配置 (需要 sudo, 会提示输密码)
echo "==> [4/6] /etc 配置 ..."
sudo tar czf "$TARGET/etc-configs.tar.gz" \
  /etc/fstab /etc/pacman.conf /etc/makepkg.conf /etc/default/grub /etc/hosts /etc/tlp.conf 2>/dev/null || true

# 5. 可选兜底: 整份 ~/.config 应用数据 (约 6G, 含浏览器配置等未入 heart 的)
#    默认注释掉。需要时取消注释:
# echo "==> [5/6] ~/.config 兜底 ..."
# rsync -a --info=progress2 ~/.config/ "$TARGET/config-backup/"

# 6. 可选: .local/src 完整源码 (3.6G, 多数可重克隆, 默认不备份)
#    若想保留原始下载物(anich/qq):
# echo "==> [6/6] .local/src ..."
# rsync -a --info=progress2 ~/.local/src/ "$TARGET/localsrc/"

echo
echo "==> 备份完成。校验:"
ls -lh "$TARGET"
echo
echo "下一步: 按 doc/heart/RESTORE.md 在新系统上恢复。"
