-- vim:ft=lua
-- nvim/lua/config/git.lua
-- @description Git signs configuration

require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  -- 开启行内 Blame (光标移上去显示谁写的)
  current_line_blame = true, 
  current_line_blame_opts = {
    delay = 500,
  },
}
