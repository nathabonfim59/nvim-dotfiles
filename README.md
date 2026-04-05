# Neovim Configuration

> [!WARNING]
> This configuration requires **Neovim 0.12.x or above** to work properly, as it uses new Neovim APIs that are not available in older versions.

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/280c8c88-48c7-4485-8f3b-345389e3bc5f" />

 > Snippet from Cerebras Code Monitor (https://github.com/nathabonfim59/cerebras-code-monitor)


This repository contains my personal Neovim configuration, organized with lazy.nvim plugin manager (https://github.com/folke/lazy.nvim). The configuration is written in Lua and structured for maintainability and extensibility. It includes AI-powered development tools including opencode.nvim, GitHub Copilot, and 99 for intelligent code assistance.

## Getting Started

To use this configuration, clone this repository into your Neovim configuration directory. On a Unix-like system, this directory is usually `~/.config/nvim/`.

```bash
git clone https://github.com/nathabonfim59/nvim-dotfiles ~/.config/nvim/
```

After cloning, start Neovim and lazy.nvim will automatically install all plugins:

```bash
nvim
```

## Configuration Structure

The configuration is organized into the following files and directories:

- `init.lua` - Main entry point
- `lua/config/` - Core Neovim settings
  - `options.lua` - Neovim options and settings
  - `keymaps.lua` - Keybindings and shortcuts
  - `autocmds.lua` - Automatic commands
- `lua/plugins/` - Plugin configurations organized by category
  - `init.lua` - Main plugin specification file
  - `ai.lua` - AI-related plugins (opencode, copilot, 99)
  - `git.lua` - Git integration plugins (gitsigns, neogit)
  - `ui.lua` - UI enhancements (which-key, mini.nvim, undotree, flash, colorizer)
  - `telescope.lua` - Fuzzy finder configurations
  - `lsp.lua` - LSP configurations (includes nvim-dbee, conform.nvim)
  - `completion.lua` - Autocompletion plugins (blink.cmp, blink.compat, blink-cmp-avante)
  - `editing.lua` - Editing utilities (harpoon, bookmarks, kulala)
  - `treesitter.lua` - Treesitter syntax highlighting
  - `colorscheme.lua` - Color scheme plugins (jb.nvim)
  - `utilities.lua` - Various utility plugins (vim-sleuth, Comment, wakatime, vim-dbml)

## Core Settings

The following core Neovim options are configured in `lua/config/options.lua`:

- Leader key: Space
- Line numbers: enabled (both absolute and relative)
- Mouse mode: enabled
- Show mode: disabled (shown in status line)
- Clipboard: unnamedplus (sync with OS)
- Break indent: enabled
- Undo file: enabled
- Search: case-insensitive, smart case, highlight on search
- Sign column: always visible
- Split configuration: new windows open right and below
- List characters: tab and trailing spaces visible
- Tab width: 4 spaces
- Incremental command preview: enabled
- Cursor line: highlighted
- Scroll offset: 10 lines minimum
- Timeout length: 2500ms
- True color: enabled

## Keybindings

 > Note: The leader key is currently set to `<Space>`. You can change it by modifying the line `vim.g.mapleader = " "` in the `init.lua` file.

### General Navigation

| Keybinding | Description |
|------------|-------------|
| `<Esc>` (Normal mode) | Clear search highlighting |
| `<C-h>` | Move focus to the left window |
| `<C-l>` | Move focus to the right window |
| `<C-j>` | Move focus to the lower window |
| `<C-k>` | Move focus to the upper window |
| `<Esc><Esc>` (Terminal mode) | Exit terminal mode |

### Diagnostics

| Keybinding | Description |
|------------|-------------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>e` | Show diagnostic error messages |
| `<leader>qd` | Open diagnostic quickfix list |

### Quickfix Operations

| Keybinding | Description |
|------------|-------------|
| `<leader>qD` | Delete current quickfix item |
| `<leader>qd` (Visual mode) | Delete selected quickfix items |
| `dd` (quickfix window) | Delete quickfix item |
| `d` (Visual mode, quickfix window) | Delete selected quickfix items |

### Telescope (Fuzzy Finder)

| Keybinding | Description |
|------------|-------------|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sf` | Search files |
| `<leader>ss` | Search select Telescope |
| `<leader>sw` | Search current word |
| `<leader>sg` | Search by grep |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Search resume |
| `<leader>s.` | Search recent files |
| `<leader>st` | Two-step grep (select directory then search) |
| `<leader><leader>` | Find existing buffers |
| `<leader>/` | Fuzzily search in current buffer |
| `<leader>s/` | Search in open files |
| `<leader>sn` | Search Neovim configuration files |

### LSP

| Keybinding | Description |
|------------|-------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `K` | Hover documentation |
| `gD` | Go to declaration |

### Git

| Keybinding | Description |
|------------|-------------|
| `<leader>gs` | Stage current hunk |
| `<leader>gp` | Preview current hunk |
| `<leader>gr` | Reset current hunk |
| `<leader>gj` | Next hunk |
| `<leader>gk` | Previous hunk |
| `<leader>gl` | Blame line |
| `<leader>gg` | Open LazyGit |

### AI Assistant - OpenCode

| Keybinding | Description |
|------------|-------------|
| `<leader>oa` | Ask opencode |
| `<leader>oc` | Execute opencode action |
| `<leader>oo` | Toggle opencode |
| `<leader>oaa` | Add range to opencode |
| `<leader>oal` | Add line to opencode |
| `<S-C-u>` | Opencode half page up |
| `<S-C-d>` | Opencode half page down |

### AI Assistant - 99

| Keybinding | Description |
|------------|-------------|
| `<leader>9f` | Fill in function body |
| `<leader>9v` (Visual mode) | Execute on visual selection |
| `<leader>9s` (Visual mode) | Stop all requests |

### File Navigation - Harpoon

| Keybinding | Description |
|------------|-------------|
| `<leader>hh` | Toggle Harpoon menu |
| `<leader>ha` | Add file to Harpoon |
| `<leader>hj` | Navigate to next Harpoon file |
| `<leader>hk` | Navigate to previous Harpoon file |

### File Navigation - Bookmarks

| Keybinding | Description |
|------------|-------------|
| `<leader>bb` | Toggle Bookmark Tree |
| `<leader>ba` | Add Bookmark |
| `<leader>bs` | Search Bookmarks |
| `<leader>bl` | Show lists |
| `<leader>bj` | Next Bookmark in current list |
| `<leader>bk` | Previous Bookmark in current list |
| `<leader>bJ` | Next Bookmark (global) |
| `<leader>bK` | Previous Bookmark (global) |

### Code Context

| Keybinding | Description |
|------------|-------------|
| `<leader>ct` | Toggle code context display |

### Terminal

| Keybinding | Description |
|------------|-------------|
| `<leader>ti` | Open current file in jid JSON filter |
| `<leader>yp` | Copy absolute path |

### Flash Navigation

| Keybinding | Description |
|------------|-------------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `r` (Operator mode) | Remote Flash |
| `R` (Operator mode) | Treesitter Search |
| `<C-s>` (Command mode) | Toggle Flash Search |

### Copilot

| Keybinding | Description |
|------------|-------------|
| `<M-y>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<M-[>` | Previous suggestion |
| `<C-]>` | Dismiss suggestion |

### Formatting

| Keybinding | Description |
|------------|-------------|
| `<leader>f` | Format buffer |

### Database

| Keybinding | Description |
|------------|-------------|
| `<leader>db` | Open database browser |

### HTTP Requests - Kulala

| Keybinding | Description |
|------------|-------------|
| `<leader>Rs` | Send request |
| `<leader>Ra` | Send all requests |
| `<leader>Rb` | Open scratchpad |

### Other Utilities

| Keybinding | Description |
|------------|-------------|
| `<leader>H` | Toggle undotree |
| `gc` (Visual mode) | Comment (visual selection) [Comment.nvim default] |
| `gc` (Normal mode) | Comment (line) [Comment.nvim default] |

## Plugins

### AI (4 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | opencode.nvim | AI assistant for code generation and completion | https://github.com/anomalyco/opencode.nvim |
 | copilot.lua | GitHub Copilot code suggestions | https://github.com/zbirenbaum/copilot.lua |
 | 99 | AI-powered code completion | https://github.com/ThePrimeagen/99 |
 | blink-cmp-avante | Avante AI integration for completion | https://github.com/Yazeed1s/blink-cmp-avante |

### Git (3 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | gitsigns.nvim | Git signs in gutter, hunk navigation | https://github.com/lewis6991/gitsigns.nvim |
 | neogit | Git interface (Magit-like) | https://github.com/NeogitOrg/neogit |
 | diffview.nvim | Diff viewer and merge tool | https://github.com/sindrets/diffview.nvim |

### LSP and Completion (10 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | nvim-lspconfig | LSP configuration for various language servers | https://github.com/neovim/nvim-lspconfig |
 | mason.nvim | Package manager for LSPs and tools | https://github.com/williamboman/mason.nvim |
 | mason-lspconfig.nvim | Bridge between mason and lspconfig | https://github.com/williamboman/mason-lspconfig.nvim |
 | mason-tool-installer.nvim | Automatic tool installation | https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim |
 | fidget.nvim | LSP status updates | https://github.com/j-hui/fidget.nvim |
 | neodev.nvim | Lua LSP for Neovim config | https://github.com/folke/neodev.nvim |
 | nvim-dbee | Database browser integration | https://github.com/kristijanhusak/nvim-dbee |
 | conform.nvim | Code formatting | https://github.com/stevearc/conform.nvim |
 | blink.cmp | Completion engine (fast, Rust-based) | https://github.com/Saghen/blink.cmp |
 | blink.compat | Compatibility layer for blink.cmp | https://github.com/Saghen/blink.compat |

### UI (6 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | which-key.nvim | Keybinding hints and popup menus | https://github.com/folke/which-key.nvim |
 | todo-comments.nvim | Highlight TODO, FIX, NOTE comments | https://github.com/folke/todo-comments.nvim |
 | mini.nvim | Collection of plugins (ai, git, cursorword, surround, statusline) | https://github.com/echasnovski/mini.nvim |
 | undotree | Visual undo history | https://github.com/jiaoshijie/undotree |
 | nvim-colorizer.lua | Color code preview in editor | https://github.com/NvChad/nvim-colorizer.lua |
 | flash.nvim | Quick navigation with labels | https://github.com/folke/flash.nvim |

### Navigation and Search (5 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | telescope.nvim | Fuzzy finder (files, grep, LSP, etc.) | https://github.com/nvim-telescope/telescope.nvim |
 | telescope-fzf-native.nvim | FZF algorithm for faster searching | https://github.com/nvim-telescope/telescope-fzf-native.nvim |
 | telescope-ui-select.nvim | UI select integration | https://github.com/nvim-telescope/telescope-ui-select.nvim |
 | harpoon | Quick file bookmarking | https://github.com/ThePrimeagen/harpoon |
 | bookmarks.nvim | Advanced bookmark management with telescope support | https://github.com/LeonHeidelbach/trailblazer.nvim |

### Editing (1 plugin)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | kulala.nvim | HTTP/REST client for testing APIs | https://github.com/mrjones2014/kulala.nvim |

### Treesitter (2 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | nvim-treesitter | Syntax highlighting and code parsing | https://github.com/nvim-treesitter/nvim-treesitter |
 | nvim-treesitter-context | Sticky function context at top of screen | https://github.com/nvim-treesitter/nvim-treesitter-context |

### Color Scheme (2 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | jb.nvim | JetBrains-inspired colorscheme (default) | https://github.com/nathabonfim59/jb.nvim |
 | papercolor-theme | Light/dark theme option | https://github.com/NLKNguyen/papercolor-theme |

### Utilities (6 plugins)

 | Plugin | Description | Link |
 |--------|-------------|------|
 | vim-sleuth | Detect tabstop and shiftwidth automatically | https://github.com/tpope/vim-sleuth |
 | Comment.nvim | Smart commenting (gc keybindings) | https://github.com/numToStr/Comment.nvim |
 | vim-wakatime | Time tracking for coding | https://github.com/wakatime/vim-wakatime |
 | vim-dbml | DBML syntax highlighting | https://github.com/marcopolo/dbml.vim |
 | plenary.nvim | Lua utility library | https://github.com/nvim-lua/plenary.nvim |
 | snacks.nvim | Input, picker, terminal utilities (opencode dependency) | https://github.com/folke/snacks.nvim |

Total: 39 plugins

## External Dependencies

This configuration includes some optional external dependencies that enhance functionality. These tools are not required for the configuration to work, but corresponding features will be disabled if they are not installed.

### lazygit

- Purpose: Git interface
- Required for: Git operations with LazyGit
- Keybinding: `<leader>gg`
- Installation: https://github.com/jesseduffield/lazygit
- Note: Optional - the configuration will work without it, but the LazyGit keybinding will be disabled

### jid

- Purpose: JSON interactive debugger
- Required for: Filtering JSON files in terminal
- Keybinding: `<leader>ti`
- Installation: https://github.com/simeji/jid
- Note: Optional - the configuration will work without it, but the jid keybinding will be disabled

### fd

- Purpose: Fast file finder
- Required for: Two-step grep feature in Telescope
- Keybinding: `<leader>st`
- Installation: https://github.com/sharkdp/fd
- Note: Optional - the configuration will work without it, but the two-step grep feature will be disabled

### make

- Purpose: Build tool
- Required for: Building telescope-fzf-native.nvim extension
- Installation: Usually pre-installed on Unix systems
- Note: Optional - the configuration will work without it, but telescope-fzf-native.nvim may not be compiled

All external dependencies are optional and the configuration will work without them, but corresponding features will be disabled.

## Acknowledgements

I would like to express my gratitude to the creators and maintainers of all the plugins used in this configuration. Your hard work and dedication have greatly enhanced the functionality and user experience of Neovim.

 A special thanks to kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim) for providing a solid foundation for this configuration.

## License

This project is licensed under the MIT License.
