vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("sign define DiagnosticSignError text=⨂ texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn  text=⚠ texthl=DiagnosticSignWarn  linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo  text=ℹ texthl=DiagnosticSignInfo  linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint  text=⚐ texthl=DiagnosticSignHint  linehl= numhl=")

vim.keymap.set('n', '<Leader>l', '<C-w>l')
vim.keymap.set('n', '<Leader>h', '<C-w>h')
vim.keymap.set('n', '<Leader>j', '<C-w>j')
vim.keymap.set('n', '<Leader>k', '<C-w>k')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    local fzf_present, fzf = pcall(require, "fzf-lua")
    local opts = { buffer = ev.buf, }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, 'g<CR>', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader><CR>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    if fzf_present then
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
        vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)
    end

    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
