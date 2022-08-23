local status_ok, ntree = pcall(require, "nvim-tree")
if not status_ok then return end

ntree.setup({
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
        indent_markers = {
            enable = true,
            icons = {
                corner = "╰",
                edge = "│",
                item = "│",
                none = " ",
            },
        },
    },
    filters = {
        dotfiles = true,
    },
})
