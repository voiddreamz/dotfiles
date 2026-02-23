-- vim:ft=lua
-- nvim/lua/config/comment_setup.lua

require('Comment').setup({
    -- 开启各种映射
    toggler = {
        line = 'gcc', -- 默认：gcc 注释当前行
        block = 'gbc', -- 默认：gbc 块注释
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
})

-- 映射 Ctrl+/ 为切换注释
-- 注意：在大多数终端，Ctrl+/ 发送的是 <C-_>
vim.keymap.set({'n', 'i'}, '<C-_>', function()
    -- 如果在插入模式，先切回普通模式再注释
    if vim.fn.mode() == 'i' then
        vim.cmd('stopinsert')
    end
    -- 调用 API 注释当前行
    require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment line' })

-- 可视模式下的 Ctrl+/ (选中多行注释)
vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle comment selection' })

-- 备用：如果你的终端能正确识别 <C-/>，加上这个保险
vim.keymap.set({'n', 'i', 'v'}, '<C-/>', '<C-_>', { remap = true })
