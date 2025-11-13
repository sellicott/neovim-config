-- Barebones Neovim configuration
-- Author: Samuel Ellicott
-- Creation Date: Sat Nov  8 12:46:19 PM EST 2025
--
-- I got tired my neovim configuration breaking sometimes and needing fixed;
-- so I am switching to a very barebones configration completely from scratch.

-- Reference taken from https://www.youtube.com/watch?v=skW3clVG5Fo

-- theme and transparancy
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Visual Settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = { "81", "101" }
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = true
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- File Handling
local undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = false
vim.opt.autowrite = false

-- Behavior Settings
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Keymapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line"})

-- Center screeen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)"})
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)"})
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Next search result (centered)"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Next search result (centered)"})

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Splitting and resizing
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", {
    desc = "Split window vertically" })
vim.keymap.set("n", "<leader>hs", ":split<CR>", {
    desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", {
    desc = "Increase window size vertically"})
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", {
    desc = "Decrease window size vertically"})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {
    desc = "Decrease window size horizontally"})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {
    desc = "Increase window size horizontally"})

-- Better window navigation
vim.keymap.set("n", "<leader><C-h>", "<C-w>h", { desc = "Move to left window"})
vim.keymap.set("n", "<leader><C-j>", "<C-w>", { desc = "Move to bottom window"})
vim.keymap.set("n", "<leader><C-k>", "<C-w>", { desc = "Move to top window"})
vim.keymap.set("n", "<leader><C-l>", "<C-w>l", { desc = "Move to right window"})

-- Move lines up/down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down"})
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up"})
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down"})
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up"})

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent left and reselect" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- yank file path
vim.keymap.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Performance Improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it dosen't exist
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- ============================================================================
-- Floating Terminal 
-- ============================================================================  

-- Based on TJ DeVries "Floating toggle-able terminal in Neovim" video
-- Refererence: https://www.youtube.com/watch?v=5PIiKDES_wc

-- terminal
local terminal_state = {
    buf = -1,
    win = -1
}

local function create_floating_window(opts)
    opts = opts or {}

    -- calculate window dimensions
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    }

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- create floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    -- set window transparency
    vim.api.nvim_win_set_option(win, 'winblend', 0)

    -- Set transparent background
    vim.api.nvim_win_set_option(win, 'winhighlight', 
        'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

    -- Define highligh groups for transparency
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    return { buf = buf, win = win }
end

-- Toggle terminal visability
local function toggle_terminal()
    if not vim.api.nvim_win_is_valid(terminal_state.win) then
        terminal_state = create_floating_window {
            buf = terminal_state.buf
        }
        if vim.bo[terminal_state.buf].buftype ~= "terminal" then
            vim.cmd.term()
        end
    else
        vim.api.nvim_win_hide(terminal_state.win)
    end
end

vim.api.nvim_create_user_command("Floatterm", toggle_terminal, {
    desc = "Toggle a floating terminal" })

-- Key mapping for the terminal
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, {
    noremap = true, desc = "Toggle floating terminal"})
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
    noremap = true, desc = "Escape terminal mode"})

