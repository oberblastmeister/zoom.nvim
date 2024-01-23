# zoom

*zoom.nvim* adds a feature to vim that can zoom windows just like tmux. Using tabs instead of sessions makes this zoom really fast.

## Features

- faster than plugins like dhruvasagar/vim-zoom which use sessions to restore windows
- simple, one command
- fits with the vim philosophy that tabs are more like workspaces

## Installation

### vim-plug

```vim
Plug 'oberblastmeister/zoom.nvim'

" After plug#end()
lua require'zoom'.setup()
```

### packer.nvim

```lua
use {
  'oberblastmeister/zoom.nvim',
  config = function() require('zoom').setup() end
}
```
