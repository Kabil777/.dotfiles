vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require("config.lazy")
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
require('config.lsp') -- Load LSP after cmp
require('config.lsp-core')
require('config.cmp') -- Now that plugins are loaded, load cmp
require('config.null-ls-config')


vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
        severity = vim.diagnostic.severity.ERROR, -- Only show errors
    },
    signs = {
        severity = vim.diagnostic.severity.ERROR,
    },
})
vim.opt.fillchars = { eob = ' ' }
vim.o.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.g.some_setting = true
