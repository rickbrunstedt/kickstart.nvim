return {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    opts = {
        on_save_enabled = true, -- If `true`, automatically enables on save sorting.
        trim_spaces = true,     -- If `true`, trim any extra spaces after sorting.
    }
}
