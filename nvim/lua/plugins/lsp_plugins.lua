return {
  -- require "configs.nvim-lint",
  {
    "williamboman/mason.nvim",
    version = "v2.0.1",
    config = true,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- blink cmp
  { import = "nvchad.blink.lazyspec" },
  {
    "Saghen/blink.cmp",
    version = "*",
    event = { "LspAttach" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<TAB>"] = { "select_next", "fallback" },
        ["<S-TAB>"] = { "select_prev", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          cmdline = {
            min_keyword_length = 2,
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "single",
        },
      },
      completion = {
        menu = {
          min_width = 25,
          max_height = 10,
          border = "single",
          scrolloff = 1,
          scrollbar = false,
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show_delay_ms = 0,
          auto_show = true,
          window = {
            border = "single",
            scrollbar = false,
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = false,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        --- @param variable Variable
        --- @param stackframe dap.StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, buf, stackframe, node, options)
          -- by default, strip out new line characters
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. " = " .. variable.value:gsub("%s+", " ")
          end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol",
        -- experimental features:
        all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = 80, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    end,
  },
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end,
  },

  -- Using autocmd launch (default)
  -- Default uses jars from mason or ~/.vscode/extensions/vmware.vscode-spring-boot-x.x.x
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = {
      "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
      "ibhagwan/fzf-lua", -- optional, for UI features like symbol picking. Other pickers (e.g., telescope.nvim) can also be used.
    },
    ---@type bootls.Config
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}
