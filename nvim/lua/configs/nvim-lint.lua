require("lint").linters_by_ft = {
    lua = { "luacheck" },
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescriptreact = { "biomejs" },
    sh = { "shellcheck" },
    groovy = { "npm-groovy-lint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
