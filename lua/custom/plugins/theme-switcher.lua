-- local Telescope = require 'nvim-telescope/telescope.nvim'
-- local themes = Teescope.themes = require('telescope.themes')
--
--
-- local themes = require('telescope.themes'),
-- print(themes)
--
-- local theme = Telescope.tokyonight.tokynight
-- local dark = Telescope.tokyonight.tokynight.default
-- local light = Telescope.tokyonight.tokynight.day
--
-- print(theme)
-- print(dark)
-- print(light)

local dark_theme = 'catppuccin-frappe'
local light_theme = 'catppuccin-latte'
Is_light_theme = false

local function setTheme(light)
  if light then
    Is_light_theme = true
    vim.cmd.colorscheme(light_theme)
  else
    Is_light_theme = false
    vim.cmd.colorscheme(dark_theme)
  end
end

local function setLightTheme()
  setTheme(true)
end

local function setDarkTheme()
  setTheme(false)
end

local function toggleTheme()
  local newValue = not Is_light_theme
  setTheme(newValue)
end

local function themeSwitcher()
  vim.cmd 'Telescope colorscheme'
end

vim.keymap.set('n', '<leader>wtl', setLightTheme, { desc = '[L]ight theme' })
vim.keymap.set('n', '<leader>wtd', setDarkTheme, { desc = '[D]ark theme' })
vim.keymap.set('n', '<leader>wtt', toggleTheme, { desc = '[T]oggle theme' })
vim.keymap.set('n', '<leader>wts', themeSwitcher, { desc = '[S]witch theme' })

require('which-key').add {
  { "<leader>wt", group = "[T]themes" },
  { "<leader>wt_", hidden = true },
}

return {
  'catppuccin/nvim',
  'rmehri01/onenord.nvim',
  name = 'catppuccin',
  priority = 1000,
}
