# 系统重建清单

生成时间: 2026-08-26
用途: 重装系统后，靠这份清单 + 本目录（heart）重建整个系统环境。

## 一、包列表

| 文件 | 数量 | 内容 | 恢复命令 |
|---|---|---|---|
| `pkglist.txt` | 314 | 官方源**叶子包**（显式安装且不被其他显式包依赖） | `sudo pacman -S --needed - < pkglist.txt` |
| `pkglist-full.txt` | 433 | 官方源全部显式包（完整参考） | — |
| `aurlist.txt` | 23 | AUR 叶子包 | `yay -S --needed - < aurlist.txt` |
| `aurlist-full.txt` | 26 | AUR 全部显式包（完整参考） | — |

**叶子包说明**: 从显式安装的包中去掉了 119 个"下属包"（本身显式、但被其他显式包依赖的，如 `git`、`octave`、`wine`、`zsh`、`tlp`、三套内核、`grub`、`sudo` 等）。恢复时 `--needed` 会自动把它们作为依赖装回来，所以叶子清单足够重建。若发现恢复后缺少某个包，对照 `pkglist-full.txt` 补装即可。

## 二、自建源码清单（.local/src，3.6G）

### 有 git 远端，可直接重建（18 个）

| 项目 | 大小 | 远端 | 最近提交 | 构建 |
|---|---|---|---|---|
| abduco | 1.2M | codeberg.org/unixchad/abduco.git | 0a4861f (2025-12-09) | make |
| dam | 1.1M | codeberg.org/unixchad/dam.git | 31ceb87 (2026-02-02) | make |
| dmenu | 880K | codeberg.org/unixchad/dmenu.git | 25e7e78 (2026-02-11) | make |
| dvtm | 2.2M | codeberg.org/unixchad/dvtm.git | c89160f (2026-03-23) | make |
| dwm | 3.5M | codeberg.org/unixchad/dwm.git | 78410cf (2026-03-19) | make |
| fcitx5-theme-jade | 360K | codeberg.org/unixchad/fcitx5-theme-jade.git | 32d8e06 (2026-03-16) | make |
| kwm | 263M | codeberg.org/unixchad/kwm.git | 80ed55d (2026-04-23) | zig |
| mew | 1.3M | codeberg.org/unixchad/mew.git | 76bdb91 (2026-04-15) | make |
| nsxiv | 7.0M | codeberg.org/unixchad/nsxiv.git | 6c62de5 (2026-06-01) | make |
| opentypeless | 260M | github.com/tover0314-w/opentypeless.git | b0062ac (2026-07-25) | npm |
| river | 624M | codeberg.org/unixchad/river.git | a27abdc (2026-04-30) | zig |
| rivercarro | 43M | git.sr.ht/~novakane/rivercarro | 793aa4c (2025-09-25) | zig |
| river-classic | 787M | codeberg.org/unixchad/river-classic.git | 04ceb05 (2026-04-01) | zig |
| riverdeck | 116M | github.com/gnuunixchad/riverdeck.git | dcdba6e (2026-02-15) | zig |
| river-shifttags | 348K | codeberg.org/unixchad/river-shifttags.git | 6cf29f9 (2026-02-06) | make |
| scrivano | 733M | aur.archlinux.org/scrivano.git | b9da04e (2025-12-13) | makepkg |
| st | 2.1M | codeberg.org/unixchad/st | 8b3e683 (2026-06-15) | make |
| yv_class_autoplay | 612K | github.com:voiddreamz/yv_class_autoplay.git | 39042c2 (2026-03-26) | python |

重建流程:

```bash
git clone <远端> <项目名> && cd <项目名> && git checkout <提交>
# 若该项目有本地改动（见下节），先应用 patch：
#   git apply ../../doc/heart/patches/<项目名>.patch
# 然后按构建方式编译安装（make / zig build / makepkg / npm install）
```

### 有本地改动（patch 已存 doc/heart/patches/）

| 项目 | 改动内容 | patch |
|---|---|---|
| dam | `config.def.h` 自定义修改 + 删除了部分 patches 文件 | dam.patch (127 行) |
| river | 删除 `.forgejo` issue 模板 | river.patch (42 行) |
| river-classic | `river/main.zig` 修改 | river-classic.patch (16 行) |
| riverdeck | `src/main.zig` 修改 | riverdeck.patch (216 行) |
| scrivano | `PKGBUILD` 修改 | scrivano.patch (22 行) |
| kwm | 无代码改动（仅 untracked 构建依赖 `zig-fcft-v2.0.0/`，可忽略） | 无 |

**注意**: `patches/` 目录是这些本地改动的唯一副本，已随 heart 上云，务必保留。

### 非源码构建（可重新下载，无需重建）

| 路径 | 内容 | 处置 |
|---|---|---|
| anich/ | 下载版应用（`anich-linux-*.zip` + `data/`） | 重新下载 zip；若 `data/` 含个人数据需纳入备份 |
| qq/ | 下载的应用（NapCatQQ / qq-tui / Stapxs-QQ-Lite-2.0） | 全部可从 GitHub 重新获取 |
| config.zon | kwm 的配置文件（散落文件，非项目） | 与 heart/.config/kwm 对照确认 |

## 三、重建注意事项

1. 重装后先恢复 `doc/heart`（git clone codeberg/github 的 dotfiles 仓库），再 `stow -d doc -t ~ heart`
2. 按第一节恢复包，按第二节重建源码
3. 游戏存档 / Zotero / 密钥（.ssh/.gnupg/.mbsyncrc）不在此清单内，见备份脚本
