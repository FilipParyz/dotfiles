require('lazy').setup({
  'tpope/vim-sleuth',

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  -- require 'kickstart/plugins/lspconfig',
  --
  -- require 'kickstart/plugins/conform',
  --
  -- require 'kickstart/plugins/cmp',
  --
  -- require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  require 'custom/sort',

  require 'custom/snacks',

  require 'custom/theme',

  require 'custom/hardtime',

  -- require 'custom/image',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
