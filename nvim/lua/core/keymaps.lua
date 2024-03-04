local map = function(modes, lhs, rhs, opts)
    local options = { silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    if type(modes) == "string" then
        modes = { modes }
    end
    for _, mode in ipairs(modes) do
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

-- netrw
map("n", "<F2>", "<Plug>NetrwBrowseResize", { desc = "Shrink/expand a netrw/explore window", buffer = true })

-- CheatSheet
-- map("n", ":cs", ":Cheatsheet", { desc = "Open cheatsheet", remap = true })
-- map("n", ":cs!", ":Cheatsheet!", { desc = "Open cheatsheet in floating window", remap = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", ":resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
map("n", "<S-h>", ":BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", ":BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", ":BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", ":BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", ":e #<cr>", { desc = "Switch to Other buffer" })
map("n", "<leader>`", ":e #<cr>", { desc = "Switch to Other buffer" })

-- lazy
map("n", "<leader>l", ":Lazy<cr>", { desc = "Lazy" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<leader>fr", ":Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
map("n", "<leader>fs", ":Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<leader>fc", ":Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
map("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "Find buffers" })

-- Telescope Frecency
map("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>", { desc = "Telescope Frecency" })

--keywordprg
map("n", "<leader>K", ":norm! K<cr>", { desc = "Keywordprg" })

-- Clear search with <esc>
map("n", "<esc>", ":noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- quit
map("n", "<leader>qq", ":qa<cr>", { desc = "Quit all" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", ":tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", ":tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", ":tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", ":tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", ":tabprevious<cr>", { desc = "Previous Tab" })

-- Code/LSP
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>cl", ":LspInfo<cr>", { desc = "LSP Info" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
end, { desc = "Goto Definition" })
map("n", "gr", ":Telescope lsp_references<cr>", { desc = "Goto References" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
end, { desc = "Goto Implementation" })
map("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
end, { desc = "Goto Type Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Goto-Preview
map("n", "gpd", function()
    require("goto-preview").goto_preview_definition()
end, { desc = "Goto Preview Definition" })
map("n", "gpt", function()
    require("goto-preview").goto_preview_type_definition()
end, { desc = "Goto Preview Type Definition" })
map("n", "gpi", function()
    require("goto-preview").goto_preview_implementation()
end, { desc = "Goto Preview Implementation" })
map("n", "gpD", function()
    require("goto-preview").goto_preview_declaration()
end, { desc = "Goto Preview Declaration" })
map("n", "gP", function()
    require("goto-preview").close_all_win()
end, { desc = "close all win" })
map("n", "gpr", function()
    require("goto-preview").goto_preview_references()
end, { desc = "Goto Preview References" })

-- Neovide specific
if vim.g.neovide then
    map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard" })
    map({ "n", "v" }, "<C-x>", '"+x', { desc = "Cut to clipboard" })
    map({ "n", "v" }, "<C-v>", '"+gP', { desc = "Paste from clipboard" })
    map({ "i", "t" }, "<C-v>", '<esc>"+gP', { desc = "Paste from clipboard" })
end

--yaml
map("n", "<leader>yv", ":YAMLView<cr>", { desc = "YAML View", remap = true })
map("n", "<leader>yy", ":YAMLYank", { desc = "YAML Yank [register]", remap = true })
map("n", "<leader>yyk", ":YAMLYankKey", { desc = "YAML Yank Key [register]", remap = true })
map("n", "<leader>yyv", ":YAMLYankValue", { desc = "YAML Yank Value [register]", remap = true })
map("n", "<leader>yq", ":YAMLQuickfix<cr>", { desc = "YAML Quickfix", remap = true })
map("n", "<leader>yt", ":YAMLTelescope<cr>", { desc = "YAML Telescope", remap = true })

-- Python-semshi
--map("n", "<leader>sh", "<Plug>SemshiHighlight", { desc = "SemshiHighlight" })
--map("n", "<leader>sn", "<Plug>SemshiNext", { desc = "SemshiNext" })
--map("n", "<leader>sp", "<Plug>SemshiPrev", { desc = "SemshiPrev" })
--map("n", "<leader>sr", "<Plug>SemshiRename", { desc = "SemshiRename" })
--map("n", "<leader>sd", "<Plug>SemshiShowDocumentation", { desc = "SemshiShowDocumentation" })

--nmap <silent> <leader>rr :Semshi rename<CR>
--nmap <silent> <Tab> :Semshi goto name next<CR>
--nmap <silent> <S-Tab> :Semshi goto name prev<CR>
--nmap <silent> <leader>c :Semshi goto class next<CR>
--nmap <silent> <leader>C :Semshi goto class prev<CR>
--nmap <silent> <leader>f :Semshi goto function next<CR>
--nmap <silent> <leader>F :Semshi goto function prev<CR>
--nmap <silent> <leader>gu :Semshi goto unresolved first<CR>
--nmap <silent> <leader>gp :Semshi goto parameterUnused first<CR>
--nmap <silent> <leader>ee :Semshi error<CR>
--nmap <silent> <leader>ge :Semshi goto error<CR>
