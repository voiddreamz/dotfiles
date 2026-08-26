# 系统恢复指南（给新系统上的 AI 读）

> 原系统状态快照：2026-08-26
> 本文件位于 dotfiles 仓库（heart）根目录，远端：`github.com/voiddreamz/dotfiles` 与 `codeberg.org/voiddreamz/dotfiles`（双远端，内容一致）。
> 你的任务：按本文件逐步操作，把新系统恢复到与原系统等价的可用状态。

## 0. 总览：什么东西在哪里

| 内容 | 位置 | 说明 |
|---|---|---|
| dotfiles / 配置 / 技能 / 包清单 / 源码清单 / patch / 本指南 | **本仓库** | ✅ 双远端，clone 即得，无需其他备份 |
| 密钥与凭据（`.ssh` `.gnupg` `.mbsyncrc` `.gitconfig`） | **`data/linux/`**（NTFS 分区 p1） | 原样复制，重装后从该目录拷回 |
| `doc/` 数据 | 用户已移到 **`data/linux/`** | 不需要恢复流程 |
| 游戏存档 / Zotero / `/etc` 配置 | 不需要 | 用户明确放弃，忽略 |

原系统为 EndeavourOS（Arch 系）。新系统若选择 Debian，包恢复方式见第 4 节。

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

**注意**：`~/.config` 必须是真实目录，stow 会把 heart/.config 下每个子目录链进去。验证：`ls -la ~/.config | grep '^l'`。

### opencode 插件依赖
```bash
cd ~/.config/opencode && npm install
# 重新登录（API 密钥不进 git）：
opencode auth login
```

## 3. 恢复密钥与凭据（从 data/linux/）

```bash
# 挂载 data 分区后：
cp -a /mnt/.../data/linux/.ssh    ~/       # 或直接 rsync -a
cp -a /mnt/.../data/linux/.gnupg  ~/
cp /mnt/.../data/linux/.mbsyncrc  ~/
cp /mnt/.../data/linux/.gitconfig ~/

# NTFS 拷回的权限可能不对，必须重置：
chmod 700 ~/.ssh ~/.gnupg
chmod 600 ~/.ssh/id_ed25519 ~/.ssh/config ~/.ssh/known_hosts
chmod 644 ~/.ssh/id_ed25519.pub

# 测试：
ssh -T git@github.com
mbsync -a
```
注意：`.ssh/agent/` 目录是 ssh-agent 运行期 socket，直接忽略即可。`.mbsyncrc` 含 163 邮箱授权码，注意保管。

## 4. 恢复系统包

### 若新系统是 Arch 系（EndeavourOS / CachyOS / Arch）
```bash
sudo pacman -S --needed - < ~/doc/heart/pkglist.txt    # 314 个叶子包
yay -S --needed - < ~/doc/heart/aurlist.txt            # 23 个 AUR 叶子包
# 缺失项对照 pkglist-full.txt (433) / aurlist-full.txt (26) 补装
```

### 若新系统是 Debian 13
包清单是 Arch 格式，不能直接 apt 装。做法：
1. 对照 `pkglist-full.txt` 按需找 Debian 对应包（大部分同名或近名：`octave`、`mpv`、`newsboat`、`zathura`、`fcitx5` 等）
2. 常用闭源应用走官方 deb / AppImage（微信、QQ、VS Code、Scrivano）
3. 游戏性能内核可选 XanMod（官方 Debian 仓库：`linux-xanmod-lts-x64v3`），保留原厂内核做 GRUB 回退
4. 用户态尽量不引入 Flatpak（偏好：官方 deb + AppImage）

## 5. 恢复自建源码（~/.local/src）

按 `~/doc/heart/src-manifest.md` 逐项重建：
```bash
# 有远端的项目（18 个）：
git clone <远端> <项目名> && cd <项目名> && git checkout <提交哈希>
# 有本地改动的项目（dam/river/river-classic/riverdeck/scrivano）先应用 patch：
git apply ~/doc/heart/patches/<项目名>.patch
# 然后按构建方式编译：make / zig build / makepkg / npm install
```
- `anich/`、`qq/`：下载的应用，非源码构建，按清单说明重新获取即可
- `~/.local/bin/*` 的 149 个软链指向 `../../doc/heart/.local/bin/`，随 heart 自动恢复

## 6. 验证清单（全部通过才算恢复完成）

- [ ] `ls -la ~/.config` 软链与 heart/.config 一致，无 broken 链接
- [ ] `ssh -T git@github.com` 正常
- [ ] `mbsync -a` 邮件拉取正常
- [ ] `opencode` 启动后 13 个自定义技能可加载（paper-translator 等）
- [ ] 核心命令存在：`which mpv zathura octave newsboat qutebrowser`
- [ ] `~/.local/src` 关键项目可构建（dam / river 等）
- [ ] `pacman -Qqe` 数量 ≥ 314（Arch 系时）

---

## 附：原系统关键事实备忘

- 桌面：sway（Wayland）；hyprland 实验过但主力是 sway；river 系多个分支在 .local/src
- 输入法：fcitx5；浏览器：qutebrowser 等；邮件：mbsync(163) + neomutt（`.mbsyncrc` 在 data/linux/）
- 学术：octave + 统计包、texlive；笔记：Scrivano（手写）
- 原包清单含 archlinuxcn 仓库（二进制 AUR 包来源），Arch 系恢复时记得启用
- 硬件：AMD CPU（amd-ucode）、TLP 电源管理、NVIDIA 需装专有驱动
- 新系统若用 Debian：参考对话结论，XanMod 内核 + 官方 deb/AppImage 替代 AUR，避免 Flatpak
