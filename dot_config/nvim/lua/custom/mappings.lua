-- local function termcodes(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

local M = {}

M.disable = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape"},
  },

  n = {
    ["<leader>n"] = { "<cmd> nohl <cr>" , "no highlight"},
  }
}

return M
