-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = '[Q]uit buffer' })
vim.keymap.set('n', '<leader>ww', ':w<CR>', { desc = '[w]rite file' })
vim.keymap.set('n', '<leader>wW', ':wa<CR>', { desc = '[W]rite all files' })

local function show_error()
  -- vim.lsp.diagnostic.show_line_diagnostics()
  vim.diagnostic.open_float()
end

vim.keymap.set('n', '<leader>e', show_error, {
  desc = 'Show [e]rrors',
})

require('telescope').setup {
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
}

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
