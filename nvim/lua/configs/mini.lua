return {
    require("mini.animate").setup(),
    require("mini.ai").setup(),
    require("mini.surround").setup(),
    require("mini.splitjoin").setup(),
    require("mini.files").setup {
        content = {
            filter = function(fs_entry)
                fs_entry.name = " " .. fs_entry.name -- adds left padding
                return true
            end,
        },
        windows = {
            preview = true,
            width_focus = 35,
            width_nofocus = 30,
            width_preview = 60,
            border = "rounded", -- other options: "single", "double", "shadow", "none"
        },
    },
    -- require("mini.icons").setup(),
    require("mini.indentscope").setup {
        draw = {
            delay = 100,
        },
        options = {
            indent_at_cursor = true,
            try_as_border = true,
        },
        symbol = "│",
    },
    require("mini.pick").setup {
        mappings = {
            move_down = "<C-j>",
            move_up = "<C-k>",
        },
        window = {
            prompt_prefix = "   ",
            prompt_caret = "| ",
        },
    }, -- === Sources ===
    preview = {
        border = "rounded",
        width = 0.45, -- percent or number
    },
}
