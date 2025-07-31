return{
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
    lazy = false,
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
              fillchar = " ",
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, "  " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
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
      views = {
        cmdline_popup = {
          border = {
            style = "single",
            padding = { 1, 3 },
          },
          position = {
            row = "90%",
            col = "50%",
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
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
    lazy = false,
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
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
            local tree_w = 80
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
  }
}

