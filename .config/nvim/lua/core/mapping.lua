-- Var
local keymap_utils = require("utils.keymap_utils")
local nnoremap = keymap_utils.nnoremap
local inoremap = keymap_utils.inoremap
local vnoremap = keymap_utils.vnoremap
local nvnoremap = keymap_utils.nvnoremap
local xnoremap = keymap_utils.xnoremap

-- Spacebar to nothing
nnoremap("<Space>", "<Nop>")

-- Save
nnoremap("<C-s>", ":w<CR>")
inoremap("<C-s>", "<Esc>:w<Cr>a")

-- Visual indent
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- Better enter insert mode on blank line
nnoremap("i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil
      and vim.bo.filetype ~= "toggleterm"
      and vim.bo.filetype ~= "TelescopePrompt"
      and "cc"
    or "i"
end, { expr = true })

-- delete a character without yank into register
nvnoremap("x", '"_x')
nvnoremap("X", '"_X')

-- Don't yank on visual paste
vnoremap("p", '"_dP')

-- paste
xnoremap("<leader>p", '"_dP')

-- Yank to system clipboard
nvnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')

-- delete blank line without yank into register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end

nnoremap("dd", smart_dd, { expr = true })
-- delete without yank
nvnoremap("<leader>d", '"_d')

-- Delete buffer
nnoremap("<C-q>", vim.cmd.bd)

-- Increment/Decrement
nnoremap("+", "<C-a>")
nnoremap("-", "<C-x>")

-- next block
nnoremap("<down>", "}")
nnoremap("<up>", "{")

-- Ctrl-W to Alt
nnoremap("<A-o>", "<C-w>o")
nnoremap("<A-w>", "<C-w>w")

-- Split
nnoremap("\\", ":split<cr><C-w>w")
nnoremap("|", ":vsplit<cr><C-w>w")

-- Tab
nnoremap("<leader>te", ":tabedit<cr>")
nnoremap("<leader>tq", ":tabclose<cr>")

-- Undo break points
inoremap(",", ",<C-g>u")
inoremap(".", ".<C-g>u")
inoremap("!", "!<C-g>u")
inoremap("?", "?<C-g>u")

-- Moving text
nnoremap("<leader>j", ":m .+1<cr>==")
nnoremap("<leader>k", ":m .-2<cr>==")
inoremap("<C-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<C-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Better up down
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Newline without exit normal
nnoremap("go", "<cmd>call append(line('.'), repeat([''], v:count1))<cr>")
nnoremap("gO", "<cmd>call append(line('.')-1, repeat([''], v:count1))<cr>")

-- Select All Text
nnoremap("<leader>a", ":keepjumps normal! ggVG<cr>")

-- No Q
nnoremap("Q", "<nop>")

-- Quit
nnoremap("<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Subtitute current word
nnoremap("<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- chmod in vim
nnoremap("<leader>x", ":!chmod +x %<cr>")

-- Coderunner
nnoremap("<leader>r", vim.cmd.Run)
nnoremap("<leader>R", vim.cmd.RunUpdate)

-- LSP line
-- nnoremap("<Leader>l", "<cmd> lua require('lsp_lines').toggle<cr>")
