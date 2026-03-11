-- vim:ft=lua
-- nvim/init.lua
-- @author nate zhou
-- @since 2025

require('config.colors')
require('config.options')
require('config.autocmd')
require('config.bindings')
require('plugins.init')
-- require('plugins.coc-plugs')
require('plugins.comment_setup') -- 我们稍后创建这个
-- require('spectre').setup() -- 加载替换插件
require('plugins.autopairs_setup')
require('plugins.git')
require('plugins.runner')
require('plugins.python_utils')
require('plugins.lualine_setup')
