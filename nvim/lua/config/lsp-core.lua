-- lua/lsp_config.lua

local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

-- Configure Mason UI and automatic installation.
-- Loading nvim-java before jdtls configuration
require("java").setup({
	notifications = {
		dap = false,
	},
	jdtls = {
		version = "v1.43.0",
	},

	lombok = {
		version = "nightly",
	},
	java_debug_adapter = {
		enable = true,
		version = "0.58.1",
	},
})
--Common on_attach function for all servers.
--

local on_attach = function(client, bufnr)
	--Document folding
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
	if client.server_capabilities and client.server_capabilities.foldingRange == nil then
		client.server_capabilities.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end
end

--Special setup for Java (nvim-java + nvim-jdtls)

-- local function setup_java()
-- 	local jdtls = require("jdtls")
--
-- 	local home = os.getenv("HOME")
-- 	local workspace_dir = home .. "/.workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--
-- 	local config = {
-- 		cmd = { "jdtls", "-data", workspace_dir },
-- 		root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 	}
--
-- 	jdtls.start_or_attach(config)
-- end

nvim_lsp.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
nvim_lsp.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Recognize `vim` as a global
			},
			hint = {
				enable = true, -- necessary
			},
		},
	},
})
nvim_lsp.helm_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,

	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})
nvim_lsp.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		yaml = {
			schemaStore = {
				enable = true,
				url = "",
			},
			schemas = {
				kubernetes = "*.yaml",
				["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*.catalog*",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
				["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
				["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
				["https://json.schemastore.org/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
				["https://json.schemastore.org/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
				["https://json.schemastore.org/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
			},
			format = { enable = true },
		},
	},
})

nvim_lsp.jdtls.setup({

	capabilities = capabilities,
	on_attach = on_attach,
	handlers = {
		["$/progress"] = function(_, result, ctx) end,
	},
	settings = {
		java = {
			signatureHelp = {
				enabled = false,
			},
			contentProvider = { preferred = "fernflower" },
			inlayHints = {
				parameterNames = {
					enabled = true,
					exclusions = { "this" },
				},
			},
		},
	},
	on_init = function(client)
		if client.config.settings then
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
	end,
})
--
nvim_lsp.lemminx.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

nvim_lsp.hyprls.setup({

	capabilities = capabilities,
	on_attach = on_attach,
})
require("fzf-lua").setup({
	"hide",
})

require("yaml-companion").setup({
	schema_store = {
		enable = true,
	},
})
return {
	on_attach = on_attach,
}
