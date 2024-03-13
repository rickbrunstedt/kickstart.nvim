-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd({ 'QuitPre' }, {
  callback = function()
    vim.cmd 'NvimTreeClose'
  end,
})

return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      -- Default options
      -- on_attach = 'default',
      -- hijack_cursor = false,
      -- auto_reload_on_write = true,
      -- disable_netrw = false,
      -- hijack_netrw = true,
      -- hijack_unnamed_buffer_when_opening = false,
      -- root_dirs = {},
      -- prefer_startup_root = false,
      -- sync_root_with_cwd = false,
      -- reload_on_bufenter = false,
      -- respect_buf_cwd = false,
      -- select_prompts = false,
      -- Default options ends

      -- respect_buf_cwd = true,
      -- sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }

    vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { desc = 'Toggle [N]vimTree' })
  end,
}
