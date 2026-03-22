-- vim:ft=lua
-- nvim/lua/plugins/markview.lua
-- @author nate zhou
-- @since 2026

local presets = require("markview.presets")

require("markview").setup({
	preview = {
		enable = true,
		filetypes = { "markdown", "typst", "latex" },
		ignore_buftypes = { "nofile" },
	},

	markdown = {
		enable = true,
		headings = presets.headings.glow,
		horizontal_rules = presets.horizontal_rules.thick,
		tables = presets.tables.rounded,
	},

	latex = {
		enable = true,
		blocks = {
			enable = true,
			hl = "MarkviewCode",
			pad_char = " ",
			pad_amount = 2,
		},
		inlines = {
			enable = true,
			padding_left = " ",
			padding_right = " ",
			hl = "MarkviewInlineCode",
		},
		symbols = {
			enable = true,
		},
		subscripts = {
			enable = true,
		},
		superscripts = {
			enable = true,
		},
		commands = {
			enable = true,
		},
	},

	typst = {
		enable = false,
	},

	html = {
		enable = true,
	},
})
