local alpha_status_ok, alpha = pcall(require, "alpha")
local db_status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
local fortune_status_ok, fortune = pcall(require, "alpha.fortune")
if not alpha_status_ok and db_status_ok and fortune_status_ok then return end

   -- "                                                     ",
   -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
   -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
   -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
   -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
   -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
   -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
   -- "                                                     ",
-- Inspired by https://github.com/glepnir/dashboard-nvim with my own flair
	local header = {
		[[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
		[[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
		[[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
		[[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
		[[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
		[[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
		[[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
		[[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
        [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
        [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
        [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
	}

	-- Make the header a bit more fun with some color!
	local function colorize_header()
		local lines = {}

		for i, chars in pairs(header) do
			local line = {
				type = "text",
				val = chars,
				opts = {
					hl = "StartLogo" .. i,
					shrink_margin = false,
					position = "center",
				},
			}

			table.insert(lines, line)
		end

		return lines
	end

	dashboard.section.buttons.val = {
		dashboard.button("e",      "  > New file", ":ene | startinsert<cr>"),
		dashboard.button("s", "  > Nvim Setting", ":cd ~/.config/nvim | Telescope file_browser <cr>"),
		dashboard.button("q",      "  > Quit NVIM", ":qa<cr>"),
	}

	dashboard.section.footer.val = fortune()


	-- Hide all the unnecessary visual elements while on the dashboard, and add
	-- them back when leaving the dashboard.
	local group = vim.api.nvim_create_augroup("CleanDashboard", {})

	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "AlphaReady",
		callback = function()
			vim.opt.showtabline = 0
			vim.opt.showmode = false
			vim.opt.laststatus = 0
			vim.opt.showcmd = false
			vim.opt.ruler = false
		end,
	})

	vim.api.nvim_create_autocmd("BufUnload", {
		group = group,
		pattern = "<buffer>",
		callback = function()
			vim.opt.showtabline = 2
			vim.opt.showmode = true
			vim.opt.laststatus = 3
			vim.opt.showcmd = true
			vim.opt.ruler = true
		end,
	})

	alpha.setup({
		layout = {
			{ type = "padding", val = 4 },
			{ type = "group", val = colorize_header() },
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			dashboard.section.footer,
		},
		opts = { margin = 5 },
	})
-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
