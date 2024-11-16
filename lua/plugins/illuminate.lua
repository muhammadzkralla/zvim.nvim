return {
    "RRethy/vim-illuminate",
    config = function()
        require('illuminate').configure({
            delay = 100,                                                         -- Optional: adjust the delay before highlighting
            filetypes_denylist = { 'NvimTree', 'TelescopePrompt', "dashboard" }, -- Optional: filetypes to ignore
        })

        -- Key mappings for navigating similar words
        local illuminate = require("illuminate")

        -- not working
        vim.keymap.set('n', '<leader>n', function() illuminate.next_reference { wrap = true } end, {
            desc = "Next occurrence", noremap = true, silent = true
        })

        vim.keymap.set('n', '<leader>p', function() illuminate.next_reference { reverse = true, wrap = true } end, {
            desc = "Previous occurrence", noremap = true, silent = true
        })
    end
}
