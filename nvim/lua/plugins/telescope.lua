local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match "[^/]+$"

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s -> %s", filename, stripped_path)
end

local function find_java_sources()
  require("telescope.builtin").find_files {
    prompt_title = "Java Source Files",
    cwd = "src/main/java/com",
    find_command = { "fd", "--type", "f", "--extension", "java" },
  }
end

local function find_java_tests()
  require("telescope.builtin").find_files {
    prompt_title = "Java Test Files",
    cwd = "src/test/java/com",
    find_command = { "fd", "--type", "f", "--extension", "java", "--glob", "*Test.java" },
  }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- specify the formatter here
        path_display = path_display,
      },
    },
    keys = {
      { "<leader>fs", find_java_sources, desc = "Find Java Source Files" },
      { "<leader>ft", find_java_tests, desc = "Find Java Test Files" },
    },
  },
}
