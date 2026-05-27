-- Alpha dashboard for startup menu
local plugins = {
  'https://github.com/goolord/alpha-nvim',
}

if vim.g.have_nerd_font then table.insert(plugins, 'https://github.com/nvim-mini/mini.nvim') end

vim.pack.add(plugins)

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- Set header
dashboard.section.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('f', '󰮗  Find file', ':Telescope find_files<CR>'),
  dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
  dashboard.button('g', '󰊄  Find text', ':Telescope live_grep<CR>'),
  dashboard.button('c', '  Config', ':e $MYVIMRC<CR>'),
  dashboard.button('q', '󰈆  Quit', ':qa<CR>'),
}

-- Set footer
local function footer()
  -- Count loaded packages using vim.api
  local loaded_plugins = vim.api.nvim_get_runtime_file('plugin/**/*.lua', true)
  local plugin_count = #loaded_plugins
  return string.format('Little boy, big dreams\n   Loaded %d plugins', plugin_count)
end

dashboard.section.footer.val = footer()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
