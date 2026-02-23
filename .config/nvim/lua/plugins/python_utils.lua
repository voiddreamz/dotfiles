-- vim:ft=lua
-- nvim/lua/config/python_utils.lua

-- 1. Jupyter Notebook 支持
-- 让 jupytext 自动将 .ipynb 转换为 python 脚本 (percent格式)
-- 这样你打开 .ipynb 时，看到的是 # %% 分隔的代码块，可以随意编辑、补全、运行
vim.g.jupytext_fmt = 'py:percent'

-- 2. 快速安装包 (类似 PyCharm Alt+Enter)
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
