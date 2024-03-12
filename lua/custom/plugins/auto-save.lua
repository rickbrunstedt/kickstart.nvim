local autoSaveOn = false

local function toggleAutoSave()
  if autoSaveOn then
    autoSaveOn = false
    print 'Auto save is OFF'
  else
    autoSaveOn = true
    print 'Auto save is ON'
  end
end

local function saveAll()
  if autoSaveOn then
    vim.cmd 'wa'
    print 'Saved all files'
    -- vim.cmd 'w'
    -- vim.cmd 'silent! wa'
  end
end

-- Optional events to listen to:
-- CompleteDone
-- DiffUpdated
-- FocusGained
-- FocusLost
-- InsertLeave

vim.api.nvim_create_autocmd({ 'FocusLost' }, {
  callback = function()
    saveAll()
  end,
  desc = 'Auto save file',
})

vim.keymap.set('n', '<leader>wa', toggleAutoSave, {
  desc = 'Toggle [A]uto save',
})

-- Having this as a test havent done anything yet..
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'AutoSave',
--   callback = function()
--     print 'My Plugin Works!'
--   end,
-- })

return {}
