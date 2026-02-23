-- vim:ft=lua
-- nvim/lua/config/autopairs_setup.lua

require('nvim-autopairs').setup({
    check_ts = true, -- 使用 treesitter 检查（不在注释/字符串里乱补全）
    ts_config = {
        lua = {'string'}, -- lua 语言在 string 节点不补全
        javascript = {'template_string'}, -- js 在模板字符串不补全
        java = false, -- java 不使用 treesitter 检查
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = '<M-e>', -- Alt+e 快速包裹单词
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
    },
})
