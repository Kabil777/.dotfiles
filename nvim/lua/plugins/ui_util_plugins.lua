return {
    {
        "Bekaboo/dropbar.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        config = function()
            require "configs.dropbar_config"
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }
            require("telescope").load_extension "fzf"
            require("telescope").load_extension "ui-select"
        end,
    },
    -- sidebar module
    {
        {
            "stevearc/aerial.nvim",
            opts = {},
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    {
        "kevinhwang91/nvim-ufo",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        init = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        opts = {
            provider_selector = function(_, _, _)
                return { "treesitter", "indent" }
            end,
        },
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            -- { sign = { namespace = { "diagnostic" } } },
                            { text = { " ", builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            -- {
                            --   sign = {
                            --     name = { "GitSigns*" },
                            --     namespace = { "gitsigns" },
                            --     colwidth = 1,
                            --   },
                            --   click = "v:lua.ScSa",
                            -- },
                        },
                    }
                end,
            },
        },
    },
    {
        "folke/noice.nvim",
        lazy = false,
        event = "VeryLazy",
        opts = {
            lsp = {
                signature = {
                    enabled = false,
                },
            },
            documentation = {
                view = "hover",
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
            views = {
                cmdline_popup = {
                    border = {
                        style = "rounded", -- 🔸 options: "single", "double", "rounded", "shadow"
                        padding = { 1, 3 },
                    },
                    position = {
                        row = "90%", -- near bottom center
                        col = "95%",
                    },
                    size = {
                        width = "30%", -- relative width
                        height = "auto",
                    },
                    win_options = {
                        cursorline = true,
                        cursorlineopt = "both",
                        winhighlight = table.concat({
                            "NormalFloat:Normal",
                            "FloatBorder:FloatBorder",
                            "CursorLine:Visual",
                            "Search:None",
                        }, ","),
                    },
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        ---@module "ibl"
        ---@type ibl.config
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
                show_start = true, -- Don't highlight just the start of the scope
                show_end = true, -- Don't highlight just the end of the scope
                include = {
                    -- Add extra treesitter node types
                    node_type = {
                        -- Apply to all filetypes
                        ["*"] = {
                            -- Classes
                            "class_declaration",
                            "interface_declaration",
                            "struct_specifier",
                            "enum_declaration",

                            -- Functions and methods
                            "function_declaration",
                            "function_definition",
                            "method_declaration",
                            "constructor_declaration",
                            "function_expression",
                            "arrow_function",
                            "lambda_expression",

                            -- Blocks and compound statements
                            "block",
                            "compound_statement",

                            -- Control flow
                            "if_statement",
                            "else_clause",
                            "switch_statement",
                            "case_statement",
                            "while_statement",
                            "for_statement",
                            "do_statement",
                            "catch_clause",
                            "try_statement",
                            "finally_clause",
                            -- Modules/namespaces
                            "namespace_definition",
                            "module_declaration",
                            "import_statement",

                            -- Rust/Go special
                            "impl_item",
                            "trait_item",
                            "match_expression",
                            "match_block",
                            "loop_expression",
                            "for_in_statement",

                            -- Others
                            "assignment_expression",
                            "init_declarator",
                            "table_constructor",

                            -- JSON
                            "object",
                            "pair",
                            "array",
                        },
                    },
                },
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            view = {
                float = {
                    enable = true,
                    open_win_config = function()
                        local scr_w = vim.opt.columns:get()
                        local scr_h = vim.opt.lines:get()
                        local tree_w = 150
                        local tree_h = math.floor(tree_w * scr_h / scr_w)
                        return {
                            border = "rounded",
                            relative = "editor",
                            width = tree_w,
                            height = tree_h,
                            col = (scr_w - tree_w) / 2,
                            row = (scr_h - tree_h) / 2,
                        }
                    end,
                },
                adaptive_size = false,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        folder = true,
                        file = true,
                        git = true,
                    },
                },
            },
        },
    },

    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<m-h>", "<cmd>TmuxNavigateLeft<cr>" },
            { "<m-j>", "<cmd>TmuxNavigateDown<cr>" },
            { "<m-k>", "<cmd>TmuxNavigateUp<cr>" },
            { "<m-l>", "<cmd>TmuxNavigateRight<cr>" },
            { "<m-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "nvim-mini/mini.nvim",
        version = false,
        lazy = false,
        config = function()
            require "configs.mini"
        end,
    },
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    },
    {
        "nvzone/floaterm",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = "FloatermToggle",
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = {
                enabled = true,
                scope = {
                    enabled = false,
                },
            },
            input = { enabled = false },
            picker = { enabled = true },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            image = {
                enabled = true,
                convert = {
                    notify = false,
                },
            },
        },
    },
    {
        "mistricky/codesnap.nvim",
        build = "make build_generator",
        lazy = true,
        keys = {
            { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
            { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
        },
        opts = {
            save_path = "~/Pictures/codesnap/",
            has_breadcrumbs = true,
            bg_theme = "bamboo",
            watermark = "",
            code_font_family = "JetBrainsMono Nerd Font",
        },
        config = function(_, opts)
            require("codesnap").setup(opts)
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
    },
}
