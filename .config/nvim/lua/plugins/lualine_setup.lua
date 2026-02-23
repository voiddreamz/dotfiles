-- vim:ft=lua
-- nvim/lua/config/lualine_setup.lua

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- 自动跟随你的配色方案
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'}, -- 这里会显示 Git 和 错误/警告
    lualine_c = {
      {
        'filename',
        -- 0: 只有文件名
        -- 1: 相对路径 (src/main.c)
        -- 2: 绝对路径 (/home/user/src/main.c) -> 你的需求
        path = 2, 
        
        -- 当文件只读或修改时显示的符号
        symbols = {
          modified = ' [+]',
          readonly = ' [RO]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'}, -- 非激活窗口只显示文件名
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'fugitive', 'quickfix'}
}
