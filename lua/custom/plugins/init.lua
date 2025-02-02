local lazygit = {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>wl', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
}

local auto_session = {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
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

local rayx_go = {
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup()
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

local comment_nvim = {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup().pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
  end,
}

local codecompanion = {
  'olimorris/codecompanion.nvim',
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          -- adapter = 'openai',
          adapter = 'ollama',
        },
        inline = {
          -- adapter = 'openai',
          adapter = 'ollama',
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = os.getenv 'OPEN_API_KEY',
            },
            schema = {
              model = {
                default = 'gpt-4',
                -- default = 'gpt-4o',
              },
            },
          })
        end,
        deepseek = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'deepseek-coder', -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = 'deepseek-coder:latest',
              },
            },
          })
        end,
        ollama = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {},
          })
        end,
      },
    }
    -- vim.api.nvim_set_keymap({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
    vim.api.nvim_set_keymap('n', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
  end,
}

local toggleterm = {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    direction = 'float',
  },
  vim.keymap.set('n', '<leader>tt', ':ToggleTerm<cr>', { desc = 'Toggle Terminal' }),
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

local colorscheme = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}

vim.opt.relativenumber = true
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

return {
  colorscheme,
  lazygit,
  auto_session,
  conform,
  comment_ts_context,
  rayx_go,
  comment_nvim,
  toggleterm,
  codecompanion,
  oil,
}
