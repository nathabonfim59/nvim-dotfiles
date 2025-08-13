# Neovim Configuration Test Suite
# Tests plugin installation, configuration loading, and functionality

NVIM := nvim
TEST_DIR := $(shell pwd)
CONFIG_DIR := $(shell dirname $(TEST_DIR))

# Colors for output
RED := $(shell printf "\033[0;31m")
GREEN := $(shell printf "\033[0;32m")
YELLOW := $(shell printf "\033[1;33m")
BLUE := $(shell printf "\033[0;34m")
NC := $(shell printf "\033[0m") # No Color

# Icon mapper (using nerdfont icons by default)
USE_NERDFONT := 1
SUCCESS_ICON := $(if $(USE_NERDFONT),✔,✅)
FAILURE_ICON := $(if $(USE_NERDFONT),✗,❌)
TEST_ICON := $(if $(USE_NERDFONT),,🧪)
INSTALL_ICON := $(if $(USE_NERDFONT),⬇,🔧)
CLEAN_ICON := $(if $(USE_NERDFONT),,🧹)
REFRESH_ICON := $(if $(USE_NERDFONT),,🔄)
HEALTH_ICON := $(if $(USE_NERDFONT),✚,🏥)

.PHONY: all test install-plugins test-config test-plugins test-telescope test-avante clean help

# Default target
all: test

# Run all tests
test: install-plugins test-config test-plugins test-telescope test-avante
	@echo "$(GREEN)$(SUCCESS_ICON) All tests completed successfully!$(NC)"

# Install/update plugins using Lazy.nvim
install-plugins:
	@echo "$(BLUE)$(INSTALL_ICON) Installing/updating plugins...$(NC)"
	@$(NVIM) --headless -c "lua require('lazy').sync({ wait = true })" -c "quit" 2>/dev/null || \
		(echo "$(RED)$(FAILURE_ICON) Plugin installation failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Plugins installed successfully$(NC)"

# Test basic configuration loading
test-config:
	@echo "$(BLUE)$(TEST_ICON) Testing configuration loading...$(NC)"
	@$(NVIM) --headless -c "lua print('$(SUCCESS_ICON) Configuration loaded')" -c "quit" 2>/dev/null || \
		(echo "$(RED)$(FAILURE_ICON) Configuration loading failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Configuration loads without errors$(NC)"

# Test plugin loading
test-plugins:
	@echo "$(BLUE)$(TEST_ICON) Testing plugin loading...$(NC)"
	@$(NVIM) --headless -S $(TEST_DIR)/test_plugins.lua -c "quit" || \
		(echo "$(RED)$(FAILURE_ICON) Plugin loading tests failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) All plugins load correctly$(NC)"

# Test telescope integration
test-telescope:
	@echo "$(BLUE)$(TEST_ICON) Testing telescope integration...$(NC)"
	@$(NVIM) --headless -S $(TEST_DIR)/test_telescope.lua -c "quit" || \
		(echo "$(RED)$(FAILURE_ICON) Telescope integration tests failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Telescope integration works correctly$(NC)"

# Test Avante functionality
test-avante:
	@echo "$(BLUE)$(TEST_ICON) Testing Avante functionality...$(NC)"
	@$(NVIM) --headless -S $(TEST_DIR)/test_avante.lua -c "quit" || \
		(echo "$(RED)$(FAILURE_ICON) Avante functionality tests failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Avante functionality works correctly$(NC)"

# Clean test artifacts
clean:
	@echo "$(YELLOW)$(CLEAN_ICON) Cleaning test artifacts...$(NC)"
	@rm -f $(TEST_DIR)/*.log
	@echo "$(GREEN)$(SUCCESS_ICON) Test artifacts cleaned$(NC)"

# Force plugin reinstall
reinstall-plugins: clean
	@echo "$(YELLOW)$(REFRESH_ICON) Force reinstalling plugins...$(NC)"
	@$(NVIM) --headless -c "lua require('lazy').clear(); require('lazy').sync({ wait = true })" -c "quit" 2>/dev/null || \
		(echo "$(RED)$(FAILURE_ICON) Plugin reinstallation failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Plugins reinstalled successfully$(NC)"

# Quick test (config + basic plugin loading)
quick-test: test-config
	@echo "$(BLUE)$(TEST_ICON) Quick plugin loading test...$(NC)"
	@$(NVIM) --headless -c "lua require('lazy').load('avante.nvim'); require('lazy').load('telescope.nvim'); print('$(SUCCESS_ICON) Key plugins loaded')" -c "quit" 2>/dev/null || \
		(echo "$(RED)$(FAILURE_ICON) Quick plugin test failed$(NC)" && exit 1)
	@echo "$(GREEN)$(SUCCESS_ICON) Quick test passed$(NC)"

# Verbose test with detailed output
verbose-test:
	@echo "$(BLUE)$(TEST_ICON) Running verbose tests...$(NC)"
	@$(NVIM) --headless -S $(TEST_DIR)/test_verbose.lua -c "quit"

# Check configuration health
health-check:
	@echo "$(BLUE)$(HEALTH_ICON) Running health checks...$(NC)"
	@$(NVIM) --headless -c "checkhealth lazy" -c "quit" 2>/dev/null | tee health_check.log
	@$(NVIM) --headless -c "checkhealth telescope" -c "quit" 2>/dev/null | tee -a health_check.log
	@echo "$(GREEN)$(SUCCESS_ICON) Health check completed, see health_check.log$(NC)"

# Help target
help:
	@echo "$(BLUE)Neovim Configuration Test Suite$(NC)"
	@echo ""
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo "  $(GREEN)test$(NC)              - Run all tests (default)"
	@echo "  $(GREEN)install-plugins$(NC)   - Install/update plugins"
	@echo "  $(GREEN)test-config$(NC)       - Test configuration loading"
	@echo "  $(GREEN)test-plugins$(NC)      - Test plugin loading"
	@echo "  $(GREEN)test-telescope$(NC)    - Test telescope integration"
	@echo "  $(GREEN)test-avante$(NC)       - Test Avante functionality"
	@echo "  $(GREEN)quick-test$(NC)        - Quick configuration test"
	@echo "  $(GREEN)verbose-test$(NC)      - Verbose test with detailed output"
	@echo "  $(GREEN)health-check$(NC)      - Run neovim health checks"
	@echo "  $(GREEN)reinstall-plugins$(NC) - Force reinstall all plugins"
	@echo "  $(GREEN)clean$(NC)             - Clean test artifacts"
	@echo "  $(GREEN)help$(NC)              - Show this help message"
	@echo ""
	@echo "$(YELLOW)Examples:$(NC)"
	@echo "  make test              # Run full test suite"
	@echo "  make quick-test        # Quick configuration check"
	@echo "  make install-plugins   # Update plugins only"
	@echo "  make verbose-test      # Detailed test output"
