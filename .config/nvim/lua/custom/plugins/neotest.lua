-- [[ Neotest — test runner ]]
-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest-python

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-neotest/nvim-nio',
  gh 'nvim-neotest/neotest',
  gh 'nvim-neotest/neotest-python',
}

require('neotest').setup {
  adapters = {
    require 'neotest-python' {
      -- The test runner to use. Options: 'pytest' (default) | 'unittest' | 'django'
      runner = 'pytest',
      -- Uncomment and set to your virtualenv python if needed:
      -- python = '.venv/bin/python',
    },
  },
}

local nt = require 'neotest'

vim.keymap.set('n', '<leader>tr', function() nt.run.run() end,                    { desc = '[T]est [R]un nearest' })
vim.keymap.set('n', '<leader>tf', function() nt.run.run(vim.fn.expand '%') end,   { desc = '[T]est run [F]ile' })
vim.keymap.set('n', '<leader>ts', function() nt.run.stop() end,                   { desc = '[T]est [S]top' })
vim.keymap.set('n', '<leader>to', function() nt.output.open { enter = true } end, { desc = '[T]est [O]utput' })
vim.keymap.set('n', '<leader>tp', function() nt.output_panel.toggle() end,        { desc = '[T]est output [P]anel' })
vim.keymap.set('n', '<leader>tS', function() nt.summary.toggle() end,             { desc = '[T]est [S]ummary' })
vim.keymap.set('n', ']t', function() nt.jump.next { status = 'failed' } end,      { desc = 'Next failed test' })
vim.keymap.set('n', '[t', function() nt.jump.prev { status = 'failed' } end,      { desc = 'Prev failed test' })
