#!/bin/bash

# Claude Code WTF Command Installer
# Installs /wtf-did-we-just-do command for Claude Code

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Claude Code is installed
check_claude_code() {
    print_info "Checking Claude Code installation..."
    if ! command -v claude &> /dev/null; then
        print_error "Claude Code is not installed or not in PATH"
        print_error "Please install Claude Code first: https://docs.anthropic.com/en/docs/claude-code"
        exit 1
    fi
    
    claude_version=$(claude --version 2>/dev/null || echo "unknown")
    print_success "Claude Code found: $claude_version"
}

# Check if commands directory exists and is writable
check_commands_directory() {
    local commands_dir="$HOME/.claude/commands"
    
    print_info "Checking commands directory: $commands_dir"
    
    if [ ! -d "$commands_dir" ]; then
        print_error "Commands directory does not exist: $commands_dir"
        print_error "This directory should be created automatically by Claude Code"
        print_error "Please run Claude Code at least once to initialize the configuration"
        exit 1
    fi
    
    if [ ! -w "$commands_dir" ]; then
        print_error "Commands directory is not writable: $commands_dir"
        print_error "Please check permissions: ls -la $commands_dir"
        exit 1
    fi
    
    print_success "Commands directory is accessible and writable"
}

# Create backup of existing file
backup_existing_file() {
    local commands_dir="$HOME/.claude/commands"
    local target_file="$commands_dir/wtf-did-we-just-do.md"
    
    if [ -f "$target_file" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local backup_file="${commands_dir}/wtf-did-we-just-do_${timestamp}.bak"
        
        print_warning "Existing wtf-did-we-just-do.md command found"
        echo
        read -p "Continue with backup and installation? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled by user"
            exit 0
        fi
        
        cp "$target_file" "$backup_file"
        print_success "Backed up wtf-did-we-just-do.md to wtf-did-we-just-do_${timestamp}.bak"
    fi
}

# Copy command file
install_command() {
    local commands_dir="$HOME/.claude/commands"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local source_file="$script_dir/commands/wtf-did-we-just-do.md"
    local target_file="$commands_dir/wtf-did-we-just-do.md"
    
    print_info "Installing wtf-did-we-just-do command..."
    
    if [ ! -f "$source_file" ]; then
        print_error "Source file not found: $source_file"
        print_error "Please ensure you're running this script from the handoff-commands directory and that the commands/ subdirectory exists"
        exit 1
    fi
    
    cp "$source_file" "$target_file"
    print_success "Installed wtf-did-we-just-do.md"
}

# Main installation process
main() {
    echo "======================================"
    echo "Claude Code WTF Command Installer"
    echo "======================================"
    echo
    
    check_claude_code
    check_commands_directory
    backup_existing_file
    install_command
    
    echo
    print_success "Installation completed successfully!"
    echo
    print_info "You can now use the following command in Claude Code:"
    echo "  /wtf-did-we-just-do - Generate session summary for knowledge base"
    echo
    print_info "You may need to restart Claude Code to see the new command"
    
    if ls "$HOME/.claude/commands"/wtf-did-we-just-do_*.bak 1> /dev/null 2>&1; then
        echo
        print_info "Backup file created in $HOME/.claude/commands/"
        print_info "To restore backup: mv backup_file.bak wtf-did-we-just-do.md"
    fi
}

# Run main function
main "$@"