for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
local warnings_enabled = true

vim.keymap.set("n", "<leader>tw", function()
	if warnings_enabled then
		-- Disable warnings
		vim.diagnostic.config({
			virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			signs = { severity = { min = vim.diagnostic.severity.ERROR } },
			underline = { severity = { min = vim.diagnostic.severity.ERROR } },
		})
		warnings_enabled = false
	else
		-- Enable warnings
		vim.diagnostic.config({
			virtual_text = { severity = vim.diagnostic.severity.WARN },
			signs = { severity = vim.diagnostic.severity.WARN },
			underline = { severity = vim.diagnostic.severity.WARN },
		})
		warnings_enabled = true
	end
end, { desc = "Toggle Warnings" })

vim.api.nvim_create_user_command("JavaNewProject", function()
	local project = vim.fn.input("Project name: ")
	local group = vim.fn.input("Group ID (com.example): ")

	local cmd = string.format(
		"mvn archetype:generate -DgroupId=%s -DartifactId=%s -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false",
		group,
		project
	)

	vim.cmd("!mkdir -p " .. project)
	vim.cmd("!" .. string.format("cd %s && %s", project, cmd))
	vim.cmd("cd " .. project)
	vim.cmd("edit " .. project)
end, {})

vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Quick Code Action" })

vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":ShowkeysToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sy", ":SymbolsOutline<CR>", { noremap = true, silent = true })
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.env.JAVA_HOME = "/home/kabil/.sdkman/candidates/java/21.0.2-open"
vim.g.java_debug_delegate_enabled = false

-- Make sure you've required nvim-dap somewhere
local dap = require("dap")

-- Set a keymap to toggle breakpoints
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle DAP Breakpoint" })

-- You can also bind other useful DAP actions like these:
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
