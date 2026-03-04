-- vim:ft=lua
-- nvim/lua/config/markdown_setup.lua
-- @author nate zhou
-- @since 2026

----------------------------------------------------------------------
-- Markdown Preview (iamcco/markdown-preview.nvim)
----------------------------------------------------------------------

-- 设置为 0，只有按快捷键才开启预览
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0

-- [关键] 指定使用 qutebrowser
vim.g.mkdp_browser = 'qutebrowser'

-- 开启 LaTeX 数学公式支持
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {}, -- 启用 katex 渲染公式
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1
}

----------------------------------------------------------------------
-- Typst Preview (chomosuke/typst-preview.nvim)
----------------------------------------------------------------------

-- [关键] 指定打开命令为 qutebrowser
-- %s 会被替换为预览服务器的 URL (例如 http://127.0.0.1:xxx)
-- vim.g.typst_preview_open_cmd = 'qutebrowser %s'
require 'typst-preview'.setup {
  -- 你的其他配置...
  open_cmd = 'qutebrowser %s'
}

-- 禁用默认的打开行为，完全由 open_cmd 控制
-- (有些版本可能叫 typst_preview_browser，但在 v0.3+ 通常用 open_cmd)
