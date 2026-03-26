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
                        style = "rounded",
                        padding = { 1, 3 },
                    },
                    position = {
                        row = "90%",
                        col = "95%",
                    },
                    size = {
                        width = "30%",
                        height = "auto",
                    },
                    win_options = {
                        cursorline = false,
                        winhighlight = table.concat({
                            "Normal:Normal",
                            "NormalFloat:Normal",
                            "FloatBorder:FloatBorder",
                            "FloatTitle:Title",
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
        lazy = true,
        cmd = { "CodeSnapSafeSave", "CodeSnapSafeCopy", "CodeSnap", "CodeSnapSave" },
        keys = {
            { "<leader>cc", "<cmd>CodeSnapSafeCopy<cr>", mode = "x", desc = "Copy selected code snapshot (safe mode)" },
            { "<leader>cs", "<cmd>CodeSnapSafeSave<cr>", mode = "x", desc = "Save selected code snapshot (safe mode)" },
        },
        opts = {
            show_line_number = false,
            show_workspace = false,
            snapshot_config = {
                window = {
                    mac_window_bar = false,
                    margin = { x = 30, y = 30 },
                    shadow = vim.NIL,
                },
                code_config = {
                    font_family = "JetBrainsMono Nerd Font",
                    breadcrumbs = {
                        enable = false,
                    },
                },
                watermark = {
                    content = "",
                },
            },
        },
        config = function(_, opts)
            require("codesnap").setup(opts)

            local function selected_line_count()
                local start_line = vim.fn.line "'<"
                local end_line = vim.fn.line "'>"
                if start_line == 0 or end_line == 0 then
                    return 0
                end
                return math.abs(end_line - start_line) + 1
            end

            local function target_path()
                local dir = vim.fn.expand "~/Pictures/codesnap"
                vim.fn.mkdir(dir, "p")
                return string.format("%s/%s.png", dir, os.date "%Y%m%d-%H%M%S")
            end

            local function save_snapshot(path)
                local generator = require("codesnap.module").load_generator()
                local config = require("codesnap.config").get_config()
                generator.save(path, config)
            end

            local function copy_with_external_tool(path)
                if vim.fn.executable "wl-copy" == 1 then
                    vim.system({ "sh", "-lc", string.format("wl-copy < %q", path) }, { detach = true })
                    return true
                end
                if vim.fn.executable "xclip" == 1 then
                    vim.system(
                        { "sh", "-lc", string.format("xclip -selection clipboard -t image/png -i %q", path) },
                        { detach = true }
                    )
                    return true
                end
                if vim.fn.executable "xsel" == 1 then
                    vim.system({ "sh", "-lc", string.format("xsel --clipboard --input < %q", path) }, { detach = true })
                    return true
                end
                return false
            end

            local function run_safe(mode)
                local max_lines = 350
                local lines = selected_line_count()
                if lines > max_lines then
                    vim.notify(
                        string.format("CodeSnap skipped: selection has %d lines (limit %d).", lines, max_lines),
                        vim.log.levels.WARN
                    )
                    return
                end

                local path = target_path()
                local ok, err = pcall(save_snapshot, path)
                if not ok then
                    vim.notify("CodeSnap failed: " .. tostring(err), vim.log.levels.ERROR)
                    return
                end

                if mode == "save" then
                    vim.notify("CodeSnap saved to " .. path)
                    return
                end

                if copy_with_external_tool(path) then
                    vim.notify "CodeSnap copied to clipboard (safe mode)"
                else
                    vim.notify("Snapshot saved to " .. path .. " (no clipboard tool found)", vim.log.levels.WARN)
                end
            end

            vim.api.nvim_create_user_command("CodeSnapSafeSave", function()
                run_safe "save"
            end, { range = true })

            vim.api.nvim_create_user_command("CodeSnapSafeCopy", function()
                run_safe "copy"
            end, { range = true })
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
    },
}
