# Neovim Configuration

![image](https://github.com/nathabonfim59/nvim-dotfiles/assets/21281852/8b76acab-fa6a-4bbb-86e7-6c2a4d7adea9)

This repository contains my personal Neovim configuration, organized with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. The configuration is written in Lua and structured for maintainability and extensibility.

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

- `init.lua` - Main entry point that loads all configuration modules and initializes lazy.nvim
- `lua/config/` - Core Neovim settings
  - `options.lua` - Neovim options and settings
  - `keymaps.lua` - Keybindings and shortcuts
  - `autocmds.lua` - Automatic commands
- `lua/plugins/` - Plugin configurations organized by category
  - `init.lua` - Main plugin specification file that imports all other plugin configs
  - `ai.lua` - AI-related plugins (Copilot, CopilotChat)
  - `colorscheme.lua` - Color scheme plugins
  - `completion.lua` - Autocompletion plugins
  - `editing.lua` - Editing utilities and enhancements
  - `git.lua` - Git integration plugins
  - `lsp.lua` - Language Server Protocol configurations
  - `telescope.lua` - Fuzzy finder configurations
  - `treesitter.lua` - Treesitter syntax highlighting
  - `ui.lua` - UI enhancements and components
  - `utilities.lua` - Various utility plugins

## Keybindings

> **Note:** The leader key is currently set to `<Space>`. You can change it by modifying the line `vim.g.mapleader = " "` in the `init.lua` file.

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
| `[d` | Go to previous diagnostic message |
| `]d` | Go to next diagnostic message |
| `<leader>e` | Show diagnostic error messages |
| `<leader>qd` | Open diagnostic quickfix list |

### Quickfix List Management

| Keybinding | Description |
|------------|-------------|
| `<leader>qD` | Delete current quickfix item |
| `<leader>qd` (Visual mode) | Delete selected quickfix items |

### Code Context

| Keybinding | Description |
|------------|-------------|
| `<leader>ct` | Toggle code context display |

### Database

| Keybinding | Description |
|------------|-------------|
| `<leader>db` | Open database browser |

### Harpoon (File Navigation)

| Keybinding | Description |
|------------|-------------|
| `<leader>hh` | Toggle Harpoon menu |
| `<leader>ha` | Add current file to Harpoon |
| `<leader>hj` | Navigate to next Harpoon file |
| `<leader>hk` | Navigate to previous Harpoon file |

### Git Integration

| Keybinding | Description |
|------------|-------------|
| `<leader>gs` | Stage current hunk |
| `<leader>gp` | Preview current hunk |
| `<leader>gr` | Reset current hunk |
| `<leader>gj` | Go to next hunk |
| `<leader>gk` | Go to previous hunk |
| `<leader>gl` | Blame current line |
| `<leader>gg` | Open LazyGit terminal interface (requires [lazygit](https://github.com/jesseduffield/lazygit) to be installed) |

### JSON Filtering

| Keybinding | Description |
|------------|-------------|
| `<leader>ti` | Open current file in jid JSON filter (requires [jid](https://github.com/simeji/jid) to be installed) |

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

## Plugins

| Plugin | Description | Link |
|--------|-------------|------|
| vim-sleuth | Detect tabstop and shiftwidth automatically | [GitHub](https://github.com/tpope/vim-sleuth) |
| Comment.nvim | "gc" to comment visual regions/lines | [GitHub](https://github.com/numToStr/Comment.nvim) |
| gitsigns.nvim | Adds git related signs to the gutter, as well as utilities for managing changes | [GitHub](https://github.com/lewis6991/gitsigns.nvim) |
| neogit | A Magit clone for Neovim | [GitHub](https://github.com/NeogitOrg/neogit) |
| which-key.nvim | Useful plugin to show you pending keybinds | [GitHub](https://github.com/folke/which-key.nvim) |
| lazy.nvim | Plugin manager for Neovim | [GitHub](https://github.com/folke/lazy.nvim) |
| telescope.nvim | Fuzzy Finder (files, lsp, etc) | [GitHub](https://github.com/nvim-telescope/telescope.nvim) |
| nvim-lspconfig | LSP Configuration & Plugins | [GitHub](https://github.com/neovim/nvim-lspconfig) |
| conform.nvim | Autoformat | [GitHub](https://github.com/stevearc/conform.nvim) |
| nvim-cmp | Autocompletion | [GitHub](https://github.com/hrsh7th/nvim-cmp) |
| copilot.lua | Github Copilot | [GitHub](https://github.com/zbirenbaum/copilot.lua) |
| CopilotChat.nvim | Github Copilot Chat | [GitHub](https://github.com/CopilotC-Nvim/CopilotChat.nvim) |
| undotree | Undo tree | [GitHub](https://github.com/jiaoshijie/undotree) |
| monokai-pro.nvim | Monokai Pro colorscheme | [GitHub](https://github.com/loctvl842/monokai-pro.nvim) |
| todo-comments.nvim | Highlight todo, notes, etc in comments | [GitHub](https://github.com/folke/todo-comments.nvim) |
| mini.nvim | Collection of various small independent plugins/modules | [GitHub](https://github.com/echasnovski/mini.nvim) |
| nvim-treesitter | Highlight, edit, and navigate code | [GitHub](https://github.com/nvim-treesitter/nvim-treesitter) |

## Acknowledgements

I would like to express my gratitude to the creators and maintainers of all the plugins used in this configuration. Your hard work and dedication have greatly enhanced the functionality and user experience of Neovim.

A special thanks to [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) for providing a solid foundation for this configuration.

## License

This project is licensed under the MIT License.