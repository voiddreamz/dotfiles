-- vim:ft=lua
-- nvim/lua/config/python_utils.lua-- 2. 快速安装包 (类似 PyCharm Alt+Enter)
-- 获取光标下的包名，调用 pip install
local function pip_install()
    local package = vim.fn.expand('<cword>')
    local confirm = vim.fn.input('Install package "' .. package .. '"? (y/n) ')
    
    if confirm == 'y' or confirm == '' then
        print("\nInstalling " .. package .. "...")
        vim.cmd('botright 10split | term pip install ' .. package)
    end
end

-- 导出函数供 keymap 调用
return {
    pip_install = pip_install
}
