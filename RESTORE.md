# 系统恢复指南（给新系统上的 AI 读）

> 原系统状态快照：2026-08-26
> 本文件位于 dotfiles 仓库（heart）根目录，仓库远端：`github.com/voiddreamz/dotfiles` 与 `codeberg.org/voiddreamz/dotfiles`（双远端，内容一致）。
> 你的任务：按本文件逐步操作，把新系统恢复到与原系统等价的可用状态。

## 0. 总览：什么东西在哪里

| 内容 | 位置 | 是否云端安全 |
|---|---|---|
| dotfiles / 配置 / 技能 / 包清单 / 源码清单 / patch | 本仓库 | ✅ 双远端 |
| `doc/` 数据（mail 邮件、papers、class_slides、books、proj、川大真题、手写等 8.8G） | **备份位置** | ❌ 必须从备份恢复 |
| 密钥与凭据（`.ssh` `.gnupg` `.mbsyncrc` `.gitconfig`） | **备份位置**（keys.tar.gz） | ❌ 必须从备份恢复 |
| Zotero 文献库、游戏存档（Larian/FiraxisLive/dos2-backup） | **备份位置** | ❌ 必须从备份恢复 |
| `/etc` 系统配置（fstab/pacman.conf/grub/tlp 等） | **备份位置**（etc-configs.tar.gz） | ❌ 参考恢复 |

原系统为 EndeavourOS（Arch 系）。若新系统选择 Debian，包恢复方式不同（见第 3 节）。

---

## 1. 基础环境

```bash
# Arch 系
sudo pacman -S git stow base-devel && git clone https://aur.archlinux.org/yay-bin.git /tmp/yay && cd /tmp/yay && makepkg -si
# Debian 系
sudo apt install git stow
```

配置 git 身份：
```bash
git config --global user.name  voiddreamz
git config --global user.email voiddreamz@163.com
```

## 2. 恢复 dotfiles（heart）

```bash
mkdir -p ~/doc
git clone https://github.com/voiddreamz/dotfiles.git ~/doc/heart
# 或: git clone git@codeberg.org:voiddreamz/dotfiles.git ~/doc/heart
cd ~/doc/heart
# 若新系统 ~ 下有同名文件挡住 stow（如默认 .bashrc/.profile），先移开：
# mkdir -p ~/_defaults && mv ~/.bashrc ~/.profile ~/.zshrc ~/.config/* ~/_defaults/ 2>/dev/null
stow -d ~/doc -t ~ heart
```

**注意**：`~/.config` 必须是真实目录，stow 会把 heart/.config 下的每个子目录链进去。验证：`ls -la ~/.config | grep '^l'`。

### opencode 插件依赖
```bash
cd ~/.config/opencode && npm install
# 重新登录（API 密钥不进 git）：
opencode auth login
```

### tlp（系统级，不是 dotfile）
```bash
sudo cp ~/doc/heart/tlp.conf /etc/tlp.conf
```

## 3. 恢复系统包

### 若新系统是 Arch 系（EndeavourOS / CachyOS / Arch）
```bash
sudo pacman -S --needed - < ~/doc/heart/pkglist.txt    # 314 个叶子包
yay -S --needed - < ~/doc/heart/aurlist.txt            # 23 个 AUR 叶子包
# 缺失项对照 pkglist-full.txt (433) / aurlist-full.txt (26) 补装
# 游戏性能内核可选 CachyOS 系或 XanMod（Arch 上也有 cachyos 内核包）
```

### 若新系统是 Debian 13
包清单是 Arch 格式，不能直接 apt 装。做法：
1. 对照 `pkglist-full.txt` 按需找 Debian 对应包（大部分同名或近名，如 `octave`、`mpv`、`newsboat`、`zathura`、`fcitx5`、`tlp`）
2. 常用闭源应用走官方 deb / AppImage（微信、QQ、VS Code、Scrivano）
3. 游戏内核可选 XanMod（官方 Debian 仓库，`linux-xanmod-lts-x64v3`），保留原厂内核做 GRUB 回退
4. 用户态尽量不引入 Flatpak（偏好：官方 deb + AppImage）

## 4. 恢复自建源码（~/.local/src）

按 `~/doc/heart/src-manifest.md` 逐项重建：
```bash
# 有远端的项目（18 个）：
git clone <远端> <项目名> && cd <项目名> && git checkout <提交哈希>
# 有本地改动的项目（dam/river/river-classic/riverdeck/scrivano）先应用 patch：
git apply ~/doc/heart/patches/<项目名>.patch
# 然后按构建方式编译：make / zig build / makepkg / npm install
```
无远端的 `anich/`、`qq/`：从备份恢复，或按清单说明重新下载（它们是下载的应用，不是源码构建）。
构建产物软链目标：`~/.local/bin/*`（149 个软链指向 `../../doc/heart/.local/bin/`，随 heart 自动恢复）。

## 5. 恢复密钥与凭据（从备份）

```bash
tar xzf <备份位置>/keys.tar.gz -C ~
chmod 700 ~/.ssh ~/.gnupg && chmod 600 ~/.ssh/*
# .mbsyncrc 内含 163 邮箱授权码（敏感），恢复后注意保管
# 测试：
ssh -T git@github.com
mbsync -a
```

## 6. 恢复 doc 数据（从备份）

```bash
# 排除 heart（已是 git 仓库，避免覆盖）：
rsync -a --exclude 'heart' <备份位置>/doc/ ~/doc/
```

## 7. 恢复 Zotero 与游戏存档（从备份）

```bash
tar xzf <备份位置>/zotero.tar.gz -C ~
tar xzf <备份位置>/gamesaves.tar.gz -C ~
tar xzf <备份位置>/dos2-backup.tar.gz -C ~/tmp 2>/dev/null || true
```

## 8. 系统级配置（从备份，参考恢复）

```bash
sudo tar xzf <备份位置>/etc-configs.tar.gz -C / --strip-components=0 2>/dev/null
# fstab 与分区相关，务必人工核对后再写入！
```

## 9. 验证清单（全部通过才算恢复完成）

- [ ] `ls -la ~/.config` 中软链数量与 heart/.config 一致，无 broken 链接
- [ ] `ssh -T git@github.com` 返回欢迎信息
- [ ] `mbsync -a` 邮件拉取正常
- [ ] `opencode` 启动后 13 个自定义技能可加载（paper-translator 等）
- [ ] 核心命令存在：`which mpv zathura octave newsboat sc-im qutebrowser`
- [ ] 游戏能启动（Steam 安装后，Proton 按需启用）
- [ ] `pacman -Qqe` 数量 ≥ 314（Arch 系时）

---

## 附：原系统关键事实备忘

- 桌面：sway（Wayland），hyprland 实验过但主力是 sway；river 系多个分支在 .local/src
- 输入法：fcitx5；浏览器：qutebrowser/其他；邮件：mbsync(163) + neomutt
- 学术：octave + 统计包、Zotero、texlive；笔记：Scrivano（手写）+ Obsidian（可选）
- 原包清单含 archlinuxcn 仓库（二进制 AUR 包来源），恢复时记得启用
- 硬件：AMD CPU（amd-ucode）、TLP 电源管理、NVIDIA 需装专有驱动（XanMod 仓库提供配套）
- data 分区（NTFS，p1）：旧 Windows 数据分区，重装时务必保留不格式化
