# AGENTS.md

This is a personal Neovim configuration written in Lua, managed by lazy.nvim. Originally based on kickstart.nvim.

## Repository Structure

```
init.lua                    # Entry point: loads config modules, bootstraps lazy.nvim
lua/config/
  options.lua               # vim.opt settings (leader, numbers, tabs, etc.)
  keymaps.lua               # Global keymaps (diagnostics, telescope, harpoon, etc.)
  autocmds.lua              # Autocommands (yank highlight, quickfix, blink-copilot integration)
lua/plugins/
  init.lua                  # Plugin imports, vim-sleuth, Comment.nvim, wakatime, papercolor-theme
  ai.lua                    # AI plugins: opencode, copilot, 99 (avante commented out)
  git.lua                   # Git: gitsigns, neogit, diffview
  ui.lua                    # UI: which-key, mini.nvim, undotree, flash, colorizer, todo-comments
  telescope.lua             # Fuzzy finder: telescope, fff.nvim
  lsp.lua                   # LSP: nvim-lspconfig, mason, conform (autoformatter), dbee
  completion.lua            # Completion: blink.cmp, blink.compat, friendly-snippets, blink-cmp-avante
  editing.lua               # Editing: harpoon, bookmarks, kulala (HTTP client)
  treesitter.lua            # Treesitter parsers and context
  colorscheme.lua           # Colorscheme: jb.nvim (JetBrains-inspired)
  utilities.lua             # Misc: vim-dbml (plus commented-out love2d, smear-cursor)
tests/
  Makefile                  # Test runner
  test_plugins.lua          # Plugin loading validation
  test_telescope.lua        # Telescope integration tests
  test_avante.lua           # Avante functionality tests
  test_verbose.lua          # Detailed diagnostic output
  test_icons.lua            # Shared icon library for tests
```

## Build/Lint/Test Commands

### Tests (run from `tests/` directory)

```bash
# Run full test suite (installs plugins, tests config, plugins, telescope, avante)
make test

# Run individual test targets
make test-config          # Test basic configuration loading only
make test-plugins         # Test plugin module loading only
make test-telescope       # Test telescope integration only
make test-avante          # Test Avante functionality only

# Run a single test file directly
nvim --headless -S tests/test_plugins.lua -c "quit"
nvim --headless -S tests/test_telescope.lua -c "quit"

# Quick sanity check
make quick-test

# Verbose output with environment info
make verbose-test

# Health checks
make health-check

# Clean test artifacts
make clean

# Force reinstall all plugins
make reinstall-plugins
```

### Formatting

```bash
# Lua files are auto-formatted with stylua via conform.nvim on save
# Manual format in neovim: <leader>f

# Format from CLI
stylua lua/ init.lua
```

### Linting

```bash
# Lua diagnostics via lua_ls LSP (configured in lsp.lua)
# No standalone lint command - diagnostics appear in-editor
# Mason auto-installs stylua for formatting
```

### Plugin Management

```bash
# Sync/update plugins (headless)
nvim --headless -c "lua require('lazy').sync({ wait = true })" -c "quit"

# In Neovim: :Lazy, :Lazy sync, :Lazy update
```

## Code Style Guidelines

### Language

All configuration is written in Lua (specifically Lua 5.1 / LuaJIT as used by Neovim).

### Formatting and Indentation

- **Tab width**: 4 (set in options.lua: `tabstop = 4`, `shiftwidth = 4`)
- **Indentation style**: Tabs by default (no `expandtab` set globally; modeline at end of init.lua: `ts=2 sts=2 sw=2 et` for that file only)
- **Formatter**: stylua (configured via conform.nvim in `lua/plugins/lsp.lua`)
- **Auto-format on save**: Enabled for Lua files via conform.nvim
- vim-sleuth auto-detects indentation for non-config files

### Naming Conventions

- **Files**: `snake_case.lua`
- **Variables**: `snake_case` (e.g., `lazyrepo`, `lazypath`, `ensure_installed`)
- **Functions**: `snake_case` (e.g., `delete_quickfix_items`, `jump_in_cwd`)
- **Constants/Module tables**: `PascalCase` or `snake_case` depending on context
- **Plugin spec files**: Named by category (`ai.lua`, `git.lua`, `lsp.lua`, etc.)

### Module Pattern

- Plugin files `return { ... }` a lazy.nvim plugin spec table
- Config modules use top-level statements (no return, loaded via `require`)
- Helper functions defined as `local function` before use
- Modules export tables: `local M = {}` pattern (see `tests/test_icons.lua`)

### Imports / Requires

- Use `require("module.path")` with dot notation (no `.lua` extension)
- Config modules: `require("config.options")`, `require("config.keymaps")`
- Plugin specs imported via `{ import = "plugins.category" }` in `init.lua`
- Lazy-load requires inside callbacks/functions (not at module top-level for plugin specs)
- Use `pcall(require, ...)` for optional dependencies (see telescope.lua)

### Plugin Specification Pattern

Follow the lazy.nvim spec format:

```lua
return {
  {
    "author/plugin-name",
    dependencies = { ... },
    event = "VimEnter",        -- or keys, cmd, ft for lazy loading
    config = function()
      require("plugin").setup({ ... })
    end,
    -- OR use opts = {} for simple setup (equivalent to require("plugin").setup({}))
    opts = {},
    keys = {
      { "<leader>x", function() ... end, desc = "Description" },
    },
  },
}
```

### Keymaps

- Always include `desc` field with descriptive text using `[B]racket` notation for mnemonic hints
- Example: `{ desc = "[S]earch [F]iles" }`, `{ desc = "[G]it - Stage hunk" }`
- Leader key is `<Space>` (set in `options.lua`)
- Global keymaps in `lua/config/keymaps.lua`, plugin-specific keymaps in plugin files

### Autocommands

- Use `vim.api.nvim_create_autocmd()` with `vim.api.nvim_create_augroup()` for grouping
- Prefer Lua callbacks over VimScript commands
- Include `desc` field for documentation

### Error Handling

- Use `pcall()` for safe module loading, especially for optional extensions
- Use `if handle == nil then return end` for IO operations (see keymaps.lua)
- Use `vim.notify()` for user-facing messages
- Use `print()` for simple console output in tests and utility functions

### Comments

- Use `--` for single-line comments
- Use `--[[ ]]` for multi-line comments
- Section headers use: `-- [[ Section Title ]]`
- Plugin files include brief description comments at the top

### Types and Annotations

- Use `---@type` and `---@module` annotations where applicable (see ai.lua, completion.lua, ui.lua)
- Use `---@diagnostic disable-next-line` to suppress specific warnings when needed
- lazydev.nvim provides Neovim API type annotations (replaces legacy neodev.nvim)

## Important Notes

- **Leader key**: `<Space>` (must be set before plugins load)
- **Local leader**: `<Space>` (same as leader)
- **Nerd Font**: Expected to be installed (`vim.g.have_nerd_font = true`)
- **Clipboard**: Synced with OS (`unnamedplus`)
- **Format on save**: Enabled via conform.nvim, disabled for C/C++, Vue, PHP, SQL, CSS, SCSS, CTP, JS/TS, conf
- **Mason**: Auto-installs LSP servers and tools (stylua is auto-installed)
- **No separate lint command**: Linting is handled in-editor via LSP diagnostics
