return {
  'ThePrimeagen/harpoon',
  config = function()
    require('which-key').add {
      { "<leader>1", group = "which_key_ignore" },
      { "<leader>2", group = "which_key_ignore" },
      { "<leader>3", group = "which_key_ignore" },
      { "<leader>4", group = "which_key_ignore" },
      { "<leader>a", group = "[A]dd harpoon mark" },
      { "<leader>a_", hidden = true },
      { "<leader>h", group = "[H]arpoon menu" },
      { "<leader>h_", hidden = true },
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
