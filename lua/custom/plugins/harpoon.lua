return {
  'ThePrimeagen/harpoon',
  config = function()
    require('which-key').register {
      ['<leader>1'] = { name = 'which_key_ignore' },
      ['<leader>2'] = { name = 'which_key_ignore' },
      ['<leader>3'] = { name = 'which_key_ignore' },
      ['<leader>4'] = { name = 'which_key_ignore' },
      ['<leader>a'] = { name = '[A]dd harpoon mark', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon menu', _ = 'which_key_ignore' },
    }

    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu)

    vim.keymap.set('n', '<leader>1', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', '<leader>2', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', '<leader>3', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', '<leader>4', function()
      ui.nav_file(4)
    end)
  end,
}
