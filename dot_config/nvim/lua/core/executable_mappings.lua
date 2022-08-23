-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set leader
vim.g.mapleader = " "

-- map( mode : str , lhs : str , rhs : str , opts )
map("n", ";;" , ":")
map("i", "jk", "<Esc>")
map("n", "U" , "<C-r>")
map("n", "qq", "<cmd>q<cr>")
map("n", "qa", "<cmd>qa<cr>")
map("n", "qw", "<cmd>wq<cr>")
map("n", "<leader>tr", "<cmd>lua require('utils.TabRename').TabRename()<cr>")
map("n", "m", "@")
