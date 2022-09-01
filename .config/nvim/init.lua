require('user.plugins') -- Installs all of the plugins from packer
require('user.autocmds') -- Setup all autocmds

-- Gruvbox
vim.g.gruvbox_contrast_dark = "hard"

-- Functional wrapper for mapping custom keybindings
-- See :h map-arguments
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "-"
vim.g.pymode_python = "python3" -- Using python3

-- Setting options
vim.opt.number = true -- show number instead of 0 line number
vim.opt.relativenumber = true -- use relative line numbers
vim.opt.tabstop = 4 -- tabs to use 4 spaces
vim.opt.softtabstop = 4 -- tabs to use 4 spaces
vim.opt.shiftwidth = 4 -- > to use 4 spaces
vim.opt.expandtab = true -- expand tabs to spaces

vim.opt.cursorline = true -- show cursorline for which line currently on

vim.opt.lazyredraw = true -- don't redraw screen when executing things like macros
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.ignorecase = true
vim.opt.smartcase = true -- only care about case if searching with at least one upper
vim.opt.showmatch = true

vim.opt.splitbelow = true -- Splits to the bottom by default on horizontal splits
vim.opt.splitright = true -- Splits to the right by default on vertical splits

vim.opt.mouse = "a" -- allow mouse usage

vim.opt.clipboard = "unnamedplus" -- connect windows and linux clipboards

vim.opt.autoread = true -- auto update if file is changed outside of nvim

vim.opt.magic = true -- magic search

vim.opt.path:append("**")

vim.opt.smartindent = true -- smart indent when already on new line

vim.opt.list = true -- show tabs, nbsp, and trailing spaces
vim.opt.listchars = "trail:~,extends:>,tab:>-" -- Show trailing spaces as specific chars

vim.opt.scrolloff = 5 -- set option to give 5 lines of buffer above and below for scrolling
vim.opt.gdefault = true -- auto add g flag to substitute all matches on line rather than just first
vim.opt.wrap = false -- don't wrap long text
vim.opt.laststatus = 3

vim.opt.foldmethod = "indent" -- Fold on indents
vim.opt.foldenable = false -- Don't start with folds when first open

vim.opt.termguicolors = true -- Set true for correct highlighting for bufferline

-- colorscheme gruvbox
-- let g:onedark_color_overrides = {"background": {"gui": "#000000", "cterm": "0", "cterm16": "0" }}
-- colorscheme onedark
vim.cmd([[
colorscheme gruvbox
]])

-- Netrw for browser
vim.g.netrw_browsex_viewer = "cmd.exe /C start" -- can now press 'gx' on link and will open in windows browser tab, for wsl

-- Mappings
map("i", "jk", "<esc>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "Q", "<NOP>") -- Don't need Ex mode
map("n", "H", "<cmd>BufferLineCyclePrev<CR>") -- Easier switching between buffers
map("n", "L", "<cmd>BufferLineCycleNext<CR>") -- Easier switching between buffers
map("n", "<leader>bd", "<cmd>bdelete<CR>") -- Easy delete buffer
map("n", "<leader>>", "<cmd>BufferLineMoveNext<CR>", {silent=true}) -- Easy move buffer
map("n", "<leader><", "<cmd>BufferLineMovePrev<CR>", {silent=true}) -- Easy move buffer
map("n", "<leader>h", "<cmd>noh<CR>") -- Quick noh
map("n", "<leader>zz", "ZZ") -- Quick save and close
map("", "<C-h>", "<C-w>h")
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")
map({"n", "v"}, "<A-j>", "<C-d>") -- Movement commands
map({"n", "v"}, "<A-k>", "<C-u>")
map({"n", "v"}, "<A-h>", "<cmd>norm! H<CR>") -- Reset to alt since using H and L for buffer changes
map({"n", "v"}, "<A-m>", "<cmd>norm! M<CR>")
map({"n", "v"}, "<A-l>", "<cmd>norm! L<CR>")

-- Vimrc settings
map("n", "<leader>vv", "<cmd>split $MYVIMRC<CR>", {silent = true})
map("n", "<leader>vo", "<cmd>edit $MYVIMRC<CR>", {silent = true})
map("n", "<leader>vp", "<cmd>split ~/.config/nvim/lua/user/plugins.lua<CR>", {silent = true})
map("n", "<leader>va", "<cmd>split ~/.config/nvim/lua/user/autocmds.lua<CR>", {silent = true})
map("n", "<leader>vs", "<cmd>PackerSync<CR>", {silent = true})
map("n", "<leader>vc", "<cmd>PackerClean<CR>", {silent = true})

-- Telescope
map("n", "<leader>ff", require'telescope.builtin'.find_files, {silent = true})
map("n", "<leader>fb", require'telescope.builtin'.buffers, {silent=true})
map("n", "<leader>e", require'telescope'.extensions.file_browser.file_browser,
    {silent = true})
map("n", "<leader>fg", require'telescope.builtin'.live_grep, {silent = true})
map("n", "<leader>fh", require'telescope.builtin'.help_tags, {silent = true})
map("n", "<leader>fr", require'telescope.builtin'.registers, {silent = true})
map("n", "<leader>fm", require'telescope.builtin'.marks, {silent = true})
map("n", "<leader>fk", require'telescope.builtin'.keymaps, {silent = true})
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", {silent = true})
-- map("n", "<leader>fq", require'telescope.builtin'.quickfix, {silent = true})
-- map("n", "<leader>ft", require'telescope.builtin'.treesitter, {silent = true})
map("n", "<leader>fd", require'telescope.builtin'.diagnostics, {silent = true})
map("n", "<leader>fgs", require'telescope.builtin'.git_status, {silent = true})
map("n", "<leader>fgc", require'telescope.builtin'.git_commits, {silent = true})
map("n", "<leader>fgb", require'telescope.builtin'.git_branches, {silent = true})

-- Fugitive
map("n", "<leader>gp", "<cmd>Git push<CR>", {silent = true})
map("n", "<leader>gg", "<cmd>Git<CR>", {silent = true})
map("n", "<leader>gs", "<cmd>Git<CR>", {silent = true})
map("n", "<leader>gc", "<cmd>startinsert<CR><cmd>Git commit<CR>",
    {silent = true})
map("n", "<leader>gcc", "<cmd>startinsert<CR><cmd>Git commit<CR>",
    {silent = true})
map("n", "<leader>gca", "<cmd>Git commit --amend<CR>", {silent = true})
map("n", "<leader>gf", "<cmd>Git fetch --prune<CR>", {silent = true})
map("n", "<leader>gr", ":Git reset --hard")
map("n", "<leader>go", ":Git checkout<space>")
map("n", "<leader>ga", ":Git add<space>")

-- Projectionist
map("n", "<leader>a", "<cmd>A<CR>", {silent = true})

-- Which key
require("which-key").register({
    f = {
        name = "file",
        f = "Find File",
        b = "Find Buffers",
        g = "Find with Grep",
        h = "Find Help Tags",
        q = "Find Quickfix",
        k = "Find Keymaps",
        r = "Find Registers"
    },
    s = {
        name = "session",
        s = "Save Session",
        c = "Save and Close Session",
        d = "Delete Session"
    },
    t = {name = "terminal", t = "Toggle terminal", n = "Create new terminal"},
    h = {
        name = "harpoon",
        a = "Add harpoon mark",
        h = "Toggle harpoon quick menu",
        t = "Toggle harpoon quick menu"
    },
    g = {
        name = "Git",
        p = "Git push",
        g = "Git status",
        s = "Git status",
        f = "Git fetch",
        r = "Git reset --hard",
        o = "Git checkout",
        a = "Git add",
        c = {name = "commit", a = "Git commit --amend", c = "Git commit"},
    },
    r = "rename",
    e = "explorer",
    c = {name = "create", s = "create snippet"},
    m = "open markdown preview",
    d = {
        d = "Dispatch run default",
        r = "Dispatch run",
        t = "Dispatch test",
        i = "Dispatch install",
        b = "Toggle debug point",
        [" "] = "Custom Dispatch"
    },
    w = {name = "write file", q = "save and quit"},
    q = "quit file",
    b = {d = "delete buffer"},
    v = {
        name = "vim config",
        v = "open init.lua in split",
        o = "open init.lua in curr window"
    },
    [";"] = "sneak next",
    [","] = "sneak prev"
}, {prefix = "<leader>"})

-- Harpoon
map("n", "<leader>ha", require('harpoon.mark').add_file)
map("n", "<leader>hh", require('harpoon.ui').toggle_quick_menu, {silent = true})
map("n", "<leader>ht", require('harpoon.ui').toggle_quick_menu, {silent = true})
map("n", "<tab>", require('harpoon.ui').nav_next, {silent = true})
map("n", "<S-tab>", require('harpoon.ui').nav_prev, {silent = true})

-- Refactoring
-- TODO: add into whichkey
map("n", "<leader>pp", require('refactoring.debug').printf)
map("n", "<leader>pv", function() require('refactoring.debug').print_var({normal = true}) end)
-- map("v", "<leader>p", require('refactoring.debug').print_var) -- TODO: issue not updating after first time
map("n", "<leader>pc", require('refactoring.debug').cleanup)

-- FTerm
map("n", "<leader>t", require("FTerm").toggle, {silent = true})
map("t", "<esc>", require("FTerm").toggle, {silent = true})

-- Tagbar
map("n", "<F8>", "<cmd>TagbarToggle fjc<CR>")

-- Cheat sheet
map("n", "<leader>cc", "<cmd>Cheat<CR>")
map("n", "<leader>cj", "<cmd>Cheat javascript <CR>")
map("n", "<leader>cp", "<cmd>Cheat python <CR>")
map("n", "<leader>cl", "<cmd>Cheat lua <CR>")
-- map("n", "<leader>cl", "<cmd>CheatList<CR>")

-- Coc markdown preview
map("n", "<leader>m",
    "<cmd>CocCommand markdown-preview-enhanced.openPreview<CR>")

-- mini.sessions
map("n", "<leader>ss", require('mini.sessions').write)
map("n", "<leader>sn", ":lua MiniSessions.write(\"\")<left><left>")
map("n", "<leader>so", require('mini.sessions').select)
map("n", "<leader>sc", require('mini.starter').open)
map("n", "<leader>sd",
    ":lua require('mini.sessions').delete(, {force=true})<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>")

-- TODO: Comment at current indent
-- TODO: gca and gcA
map("n", "gco",
    "o<C-o>m[<C-o>m]<cmd>lua MiniComment.operator('normal')<CR><esc>A<space>")
map("n", "gcO",
    "O<C-o>m[<C-o>m]<cmd>lua MiniComment.operator('normal')<CR><esc>A<space>")

-- Dispatch
local run_dispatch_with_goal = function(goal)
    return function()
        vim.b.dispatch = vim.b.dispatch_commands[goal]
        vim.cmd("Dispatch")
    end
end
map("n", "<leader>d<space>", ":Dispatch<space>")
map("n", "<leader>dr", run_dispatch_with_goal("run"))
map("n", "<leader>dt", run_dispatch_with_goal("test"))
map("n", "<leader>di", run_dispatch_with_goal("install"))
map("n", "<leader>dd", run_dispatch_with_goal("test"))

-- DAP - Debugger
local dap = require('dap')
map("n", "<leader>db", dap.toggle_breakpoint, {silent = true})
map("n", "<F1>", dap.continue, {silent = true})
map("n", "<F2>", dap.step_out, {silent = true})
map("n", "<F3>", dap.step_over, {silent = true})
map("n", "<F4>", dap.step_into, {silent = true})
map("n", "<F5>", require('dapui').toggle, {silent = true})

-- Autosave
-- map("n", "<leader>st", "<cmd>ASToggle<CR>")

-- LSP Setup
local lsp_keymappings = function(client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", '<leader>dk', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- client.server_capabilities.documentFormattingProvider = false
    client.resolved_capabilities.document_formatting = false
    -- client.server_capabilities.documentRangeFormattingProvider = false
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {'sumneko_lua', 'gopls', 'pyright', 'tsserver'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = lsp_keymappings,
        capabilities = capabilities
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
}

-- Uses friendly-snippets for luasnip
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_lua').lazy_load({
    paths = "~/.config/nvim/snippets/"
})
map('n', "<leader>cs", require("luasnip.loaders").edit_snippet_files)
