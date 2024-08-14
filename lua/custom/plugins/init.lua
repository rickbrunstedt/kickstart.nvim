-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = '[Q]uit buffer' })
vim.keymap.set('n', '<leader>ww', ':w<CR>', { desc = '[w]rite file' })
vim.keymap.set('n', '<leader>wW', ':wa<CR>', { desc = '[W]rite all files' })

return {}
