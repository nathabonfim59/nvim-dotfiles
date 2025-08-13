# Neovim Configuration Test Suite

A comprehensive test suite for validating neovim configuration, plugin installation, and functionality.

## Features

- ✅ **Plugin Installation Testing** - Automatically install/update plugins using Lazy.nvim
- ✅ **Configuration Loading** - Verify neovim configuration loads without errors
- ✅ **Module Loading Tests** - Test that critical plugins and modules load correctly
- ✅ **Telescope Integration** - Validate telescope picker functionality
- ✅ **Avante AI Integration** - Test Avante API and functionality
- ✅ **Headless Mode Support** - All tests run in headless mode for CI/automation
- ✅ **Colorized Output** - Clear, colorized test results

## Quick Start

```bash
# Run all tests
make test

# Quick configuration check
make quick-test

# Install/update plugins only
make install-plugins

# Detailed test output
make verbose-test
```

## Test Targets

| Target | Description |
|--------|-------------|
| `test` | Run complete test suite (default) |
| `install-plugins` | Install/update all plugins via Lazy.nvim |
| `test-config` | Test basic configuration loading |
| `test-plugins` | Test plugin module loading |
| `test-telescope` | Test telescope integration |
| `test-avante` | Test Avante functionality |
| `quick-test` | Quick configuration and key plugin test |
| `verbose-test` | Detailed test output with environment info |
| `health-check` | Run neovim health checks |
| `reinstall-plugins` | Force reinstall all plugins |
| `clean` | Clean test artifacts |

## Test Output

The test suite provides colorized output with clear success/failure indicators:

- 🔧 Plugin installation
- 🧪 Test execution
- ✅ Success indicators
- ❌ Failure indicators
- 📊 Summary statistics

## Example Output

```
🔧 Installing/updating plugins...
✅ Plugins installed successfully
🧪 Testing configuration loading...
✅ Configuration loads without errors
🧪 Testing plugin loading...
✅ All plugins load correctly
🧪 Testing telescope integration...
✅ Telescope integration works correctly
🧪 Testing Avante functionality...
✅ Avante functionality works correctly
✅ All tests completed successfully!
```

## Test Files

- `Makefile` - Main test runner with colored output
- `test_plugins.lua` - Plugin loading validation
- `test_telescope.lua` - Telescope integration tests
- `test_avante.lua` - Avante functionality tests
- `test_verbose.lua` - Detailed diagnostic output

## Requirements

- Neovim 0.10+ 
- Git (for plugin installation)
- Make (for running test targets)

## CI/Automation

All tests run in headless mode and return appropriate exit codes for automation:

```bash
# In CI/automation scripts
make test || exit 1
```

## Troubleshooting

### Plugin Loading Issues
```bash
make verbose-test  # Shows detailed plugin status
make health-check  # Runs neovim health checks
```

### Force Plugin Reinstall
```bash
make reinstall-plugins
```

### Clean Test Environment
```bash
make clean
```