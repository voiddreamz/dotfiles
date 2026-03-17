-- vim:ft=lua
-- nvim/lua/plugins/init.lua
-- @author nate zhou
-- @since 2025,2026

-- enables the experimental lua module loader, see `:h loader`
vim.loader.enable()

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('norcalli/nvim-colorizer.lua')

Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'main' })

Plug('nvim-treesitter/nvim-treesitter-context')

Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

Plug('lukas-reineke/indent-blankline.nvim')

Plug('OXY2DEV/markview.nvim')

Plug('tpope/vim-fugitive')

Plug('voldikss/vim-floaterm')
Plug('ptzz/lf.vim')

Plug('h-hg/fcitx.nvim')
-- Self Plug:
-- Markdown Preview
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && pnpm install', ['for'] = {'markdown', 'vim-plug'} })

-- [新增] Typst 预览支持
Plug('chomosuke/typst-preview.nvim', { ['branch'] = 'master', ['do'] = ':TypstPreviewUpdate' })

-- [多光标] 类似 VS Code Ctrl+D
Plug('mg979/vim-visual-multi', {['branch'] = 'master'})

-- [快速注释] 类似 VS Code Ctrl+/
Plug('numToStr/Comment.nvim')
-- 自动括号补全
Plug('windwp/nvim-autopairs')
-- [Git 集成]
Plug('tpope/vim-fugitive')       -- Git 命令包装 (:G)
Plug('lewis6991/gitsigns.nvim')  -- 左侧显示增删改竖线




-- [状态栏] 美观且高性能
Plug('nvim-lualine/lualine.nvim')
-- [图标支持] 状态栏需要图标 (如果你装了 Nerd Fonts)
Plug('nvim-tree/nvim-web-devicons')

vim.call('plug#end')

require('plugins.nvim-colorizer')
require('plugins.nvim-treesitter')
require('plugins.nvim-treesitter-context')
require('plugins.indent-blankline')
require('plugins.markview')
require('plugins.vim-floaterm')
require('plugins.lf')
require('plugins.markdown_setup')
