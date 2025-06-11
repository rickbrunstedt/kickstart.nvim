-- auto-session - Recommended setting is:
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

local auto_session = {
  'rmagatti/auto-session',
  ---enables autocomplete for opts
  config = function()
    ---@module "auto-session"
    ---@type AutoSession.Config
    require('auto-session').setup {
      lazy = false,
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/', '~/.config' },
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        previewer = false,
        theme_conf = {
          border = true,
        },
      },
    }
    vim.keymap.set('n', '<Leader>wc', require('auto-session.session-lens').search_session, {
      noremap = true,
      desc = 'Change session',
    })
  end,
}

local conform = {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}

local oil = {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    -- float = {
    --   padding = 20,
    -- },
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  vim.keymap.set('n', '<leader>tf', '<CMD>Oil --float<CR>', { desc = 'Toggle Oil directory' }),
}

local comment_ts_context = {
  'JoosepAlviste/nvim-ts-context-commentstring',
  opts = {
    enable_autocmd = false,
  },
}

local comment_nvim = {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup().pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
  end,
}

require('telescope').setup {
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
  defaults = {
    mappings = {
      i = {
        ['<c-b>'] = require('telescope.actions').delete_buffer,
      },
      n = {
        ['<c-b>'] = require('telescope.actions').delete_buffer,
        ['P'] = require('telescope.actions.layout').toggle_preview,
      },
    },
  },
}

vim.api.nvim_create_user_command('TelescopeColorschemePreview', function()
  require('telescope.builtin').colorscheme { enable_preview = true }
end, {})

local theme = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 999, -- Load early
  lazy = false, -- Load immediately (important for colorscheme)
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe', -- latte, frappe, macchiato, mocha
      background = {
        light = 'latte',
        dark = 'frappe',
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        mini = {
          enabled = true,
        },
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}

vim.opt.relativenumber = true

-- Tab settings
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 4 -- Number of visual spaces per TAB
vim.o.softtabstop = 2 -- Number of spaces in tab when editing
vim.o.shiftwidth = 2 -- Number of spaces to use for autoindent

-- Write buffer to file with 'Ctrl + s'
vim.keymap.set('n', '<C-s>', ':update<CR>', { desc = 'Write buffer to file' })
vim.keymap.set('v', '<C-s>', '<C-C>:update<CR>', { desc = 'Write buffer to file' })
vim.keymap.set('i', '<C-s>', '<C-O>:update<CR>', { desc = 'Write buffer to file' })
-- Close buffer 'Ctrl + q'
vim.keymap.set('n', '<C-q>', ':bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('v', '<C-q>', '<C-C>:bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('i', '<C-q>', '<C-O>:bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>sF', function()
  require('telescope.builtin').find_files { hidden = true }
end, { desc = '[S]earch [F]iles (incl. hidden)' })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Additional LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Additional keybindings that don't conflict with kickstart
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

return {
  theme,
  oil,
  conform,
  comment_nvim,
  comment_ts_context,
  auto_session,

  -- Kickstart plugins
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
}
