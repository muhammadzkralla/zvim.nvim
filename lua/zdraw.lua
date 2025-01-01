local M = {}
local ns_id = vim.api.nvim_create_namespace("draw_namespace")
local draw_buf = nil
local draw_win = nil
local active = false
local last_pos = nil -- Tracks the last drawn position to avoid redundant marks

-- Create a highlight group for drawing
vim.cmd("highlight DrawHighlight guifg=#FF0000 gui=bold")

-- Open a transparent floating window as the drawing canvas
local function open_drawing_canvas()
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- Create a new buffer
    draw_buf = vim.api.nvim_create_buf(false, true)

    -- Set buffer options
    vim.api.nvim_buf_set_option(draw_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(draw_buf, "modifiable", true)

    -- Create a floating window
    draw_win = vim.api.nvim_open_win(draw_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = 0,
        col = 0,
        style = "minimal",
        border = "none",
        zindex = 50, -- Ensure it's on top
    })

    -- Make the floating window transparent
    vim.api.nvim_win_set_option(draw_win, "winblend", 90)
end

-- Close the drawing canvas
local function close_drawing_canvas()
    if draw_win then
        vim.api.nvim_win_close(draw_win, true)
        draw_buf = nil
        draw_win = nil
    end
end

-- Enable drawing mode
function M.start_drawing()
    if active then return end
    active = true
    open_drawing_canvas()
    vim.o.mouse = "a" -- Enable mouse support
    print("Drawing mode enabled!")

    -- Attach a mouse event listener
    vim.api.nvim_set_keymap('n', '<LeftMouse>', ':lua require("zdraw").draw()<CR>', { noremap = true, silent = true })
end

-- Disable drawing mode
function M.stop_drawing()
    if not active then return end
    active = false
    vim.o.mouse = "" -- Disable mouse support
    print("Drawing mode disabled!")
    close_drawing_canvas()
    vim.api.nvim_del_keymap('n', '<LeftMouse>')
end

-- Draw at the current cursor position
function M.draw()
    if not active or not draw_buf then return end
    local row, col = unpack(vim.api.nvim_win_get_cursor(draw_win))
    -- Avoid redundant drawings at the same position
    if last_pos and last_pos.row == row and last_pos.col == col then
        return
    end

    last_pos = { row = row, col = col }

    -- Draw in the floating buffer
    vim.api.nvim_buf_set_extmark(draw_buf, ns_id, row - 1, col, {
        virt_text = { { "█", "DrawHighlight" } },
        virt_text_pos = "overlay",
    })
end

return M
