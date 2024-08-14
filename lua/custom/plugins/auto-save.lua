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
    vim.cmd 'w'
    -- print 'Saved all files'
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

return {}
