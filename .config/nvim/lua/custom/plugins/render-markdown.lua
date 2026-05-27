local plugins = {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

if vim.g.have_nerd_font then table.insert(plugins, 'https://github.com/nvim-mini/mini.nvim') end

vim.pack.add(plugins)

require('render-markdown').setup {}
