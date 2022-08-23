local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local function TabRename() 
    local input = Input({
        position = "50%",
        size = {
            width = 20,
        },
        border = {
            style = "rounded",
            text = {
                top = "[Rename Tab]",
                top_align = "left",
          },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = " ",
        on_submit = function(value)
            vim.cmd("TabRename %s" .. value)
        end,
        on_change = function(value)
            vim.cmd("TabRename %s" .. value)
        end,
    })
    
    -- mount/open the component
    input:mount()
    
    -- unmount component when cursor leaves buffer
    input:on(event.BufLeave, function()
      input:unmount()
    end)
    
    input:map("n", "<Esc>", function()
      input:unmount()
    end, { noremap = true })
end

return {
    TabRename = TabRename
}
