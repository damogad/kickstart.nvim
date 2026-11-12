-- diffview.nvim: project-wide git diff view and file history
-- https://github.com/sindrets/diffview.nvim
--
-- Inside a diffview tab:
--   <Tab> / <S-Tab>  next / previous changed file
--   -                stage / unstage the file under the cursor (file panel)
--   g?               show all diffview keymaps

vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

-- Diffview remaps the fold keys (zo, zR, ...) in diff panels so they act on both
-- panels at once, but labels them "diffview_ignore", which which-key then shows.
-- Re-register them with readable descriptions.
local fold_descs = {
  za = 'Toggle fold',
  zA = 'Toggle fold recursively',
  ze = 'Scroll right so cursor is at screen end',
  zE = 'Delete all folds',
  zo = 'Open fold',
  zO = 'Open fold recursively',
  zc = 'Close fold',
  zC = 'Close fold recursively',
  zr = 'Open one more fold level',
  zm = 'Close one more fold level',
  zR = 'Open all folds',
  zM = 'Close all folds',
  zv = 'Show cursor line',
  zx = 'Update folds',
  zX = 'Update folds (keep manual changes)',
  zn = 'Disable folding (show everything)',
  zN = 'Re-enable folding',
  zi = 'Toggle folding on/off',
}
local fold_keymaps = {}
for _, map in ipairs(require('diffview.actions').compat.fold_cmds) do
  local key = map[2]
  table.insert(fold_keymaps, { map[1], key, map[3], { desc = (fold_descs[key] or key) .. ' (both panels)' } })
end

require('diffview').setup {
  keymaps = { view = fold_keymaps },
}

-- Open the diff view, or close it if the current tab is already one.
local function toggle_diffview()
  if require('diffview.lib').get_current_view() then
    vim.cmd 'DiffviewClose'
  else
    vim.cmd 'DiffviewOpen'
  end
end

vim.keymap.set('n', '<leader>gd', toggle_diffview, { desc = '[G]it [D]iff view (toggle)' })
vim.keymap.set('n', '<leader>gh', '<Cmd>DiffviewFileHistory %<CR>', { desc = '[G]it [H]istory of current file' })
vim.keymap.set('n', '<leader>gH', '<Cmd>DiffviewFileHistory<CR>', { desc = '[G]it [H]istory of whole repo' })

require('which-key').add { { '<leader>g', group = '[G]it' } }
