local indent = require("ibl")
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#9aa5ce" })
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "tokyonight",
	callback = function()
		local colors = require("tokyonight.colors").setup()
		vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = colors.fg })
	end,
})
local opts = {
	indent = {
		char = "│",
	},
	scope = {
		enabled = true,
		show_start = false, -- Don't highlight just the start of the scope
		show_end = false, -- Don't highlight just the end of the scope
		highlight = "IndentBlanklineContextChar",
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
}
indent.setup(opts)
