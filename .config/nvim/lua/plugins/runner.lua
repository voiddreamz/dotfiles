-- vim:ft=lua
-- nvim/lua/config/runner.lua
-- @description One-key compile and run system

local M = {}

function M.compile_and_run()
    vim.cmd('w') -- 先保存文件
    
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%')
    local output_name = vim.fn.expand('%:r') -- 无后缀文件名
    
    local cmd = ""
    
    if filetype == 'c' then
        cmd = 'gcc "' .. filename .. '" -o "' .. output_name .. '" && "./' .. output_name .. '"'
    elseif filetype == 'cpp' then
        -- 使用 C++17 标准
        cmd = 'g++ -std=c++17 "' .. filename .. '" -o "' .. output_name .. '" && "./' .. output_name .. '"'
    elseif filetype == 'python' then
        cmd = 'python "' .. filename .. '"'
    elseif filetype == 'lua' then
        cmd = 'lua "' .. filename .. '"'
    elseif filetype == 'sh' then
        cmd = 'bash "' .. filename .. '"'
    elseif filetype == 'markdown' then
        vim.cmd('MarkdownPreviewToggle')
        return
    elseif filetype == 'typst' then
        vim.cmd('TypstPreview')
        return
    else
        print("Run: No command defined for " .. filetype)
        return
    end

    -- 在下方打开一个小终端运行命令
    vim.cmd('botright 15split | term ' .. cmd)
    -- 如果你想用 float window，可以改用 Floaterm
end

return M
