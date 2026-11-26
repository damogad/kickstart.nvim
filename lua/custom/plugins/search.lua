-- grug-far.nvim: project-wide search and replace with live preview (ripgrep)
-- https://github.com/MagicDuck/grug-far.nvim
--
-- Fill in the fields at the top (Search, Replace, Files Filter, Flags, Paths);
-- results update as you type. Inside the panel (<localleader> is <Space>):
--   <localleader>r   replace all matches
--   <localleader>s   sync manual edits of result lines back to the files
--   <localleader>q   send results to the quickfix list
--   <Enter>          go to the match under the cursor
--   g?               show all grug-far keymaps

vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }

require('grug-far').setup {}

-- Normal mode: search the word under the cursor. Visual mode: search the selection.
vim.keymap.set('n', '<leader>sR', function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end, { desc = '[S]earch and [R]eplace in project' })
vim.keymap.set('x', '<leader>sR', ':GrugFar<CR>', { desc = '[S]earch and [R]eplace selection in project' })
