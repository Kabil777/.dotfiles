-- Function to run current Java file in a floating terminal
local function run_java_in_popup()
  local filename = vim.fn.expand("%:t")    -- Get current file name
  local classname = vim.fn.expand("%:t:r") -- Remove extension
  local filepath = vim.fn.expand("%:p:h")  -- File's directory

  -- Create popup window
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Save file and run in terminal buffer
  vim.cmd("write") -- Save current file
  local cmd = string.format("cd '%s' && javac %s && java %s", filepath, filename, classname)

  vim.fn.termopen(cmd, {
    on_exit = function()
      print("Java file execution finished.")
    end
  })
end

-- Map to a key (e.g., <leader>r)
vim.keymap.set("n", "<leader>rj", run_java_in_popup, { noremap = true, silent = true, desc = "Run Java in popup" })
