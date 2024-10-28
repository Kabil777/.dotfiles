return{
  "nvim-telescope/telescope.nvim",
  keys = {
    {"<leader>/", false},
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    {
      "<leader>fp",
      function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
  },
  config = function()
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,          -- Ensures the preview is always shown
        preview_height = 0.5,        -- Set the preview to take up 50% of the window height
        prompt_position = "top",     -- Moves the prompt to the top
      },
    },
    layout_strategy = "horizontal",  -- Choose "horizontal" layout to support top preview positioning
  },
}

    end
 }
