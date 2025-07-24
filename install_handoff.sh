#!/bin/bash

# Claude Code Handoff Commands Installer
# Installs /handoff and /resume commands for Claude Code

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

# Create backup of existing files
backup_existing_files() {
    local commands_dir="$HOME/.claude/commands"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_created=false
    
    for file in "handoff.md" "resume.md"; do
        local target_file="$commands_dir/$file"
        if [ -f "$target_file" ]; then
            local backup_file="${commands_dir}/${file%.*}_${timestamp}.bak"
            
            if [ "$backup_created" = false ]; then
                print_warning "Existing command files found"
                echo -e "The following files will be backed up:"
                for check_file in "handoff.md" "resume.md"; do
                    [ -f "$commands_dir/$check_file" ] && echo "  - $check_file"
                done
                echo
                read -p "Continue with backup and installation? (y/N): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Installation cancelled by user"
                    exit 0
                fi
                backup_created=true
            fi
            
            cp "$target_file" "$backup_file"
            print_success "Backed up $file to ${file%.*}_${timestamp}.bak"
        fi
    done
}

# Copy command files
install_commands() {
    local commands_dir="$HOME/.claude/commands"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_info "Installing command files..."
    
    for file in "handoff.md" "resume.md"; do
        local source_file="$script_dir/commands/$file"
        local target_file="$commands_dir/$file"
        
        if [ ! -f "$source_file" ]; then
            print_error "Source file not found: $source_file"
            print_error "Please ensure you're running this script from the handoff-commands directory and that the commands/ subdirectory exists"
            exit 1
        fi
        
        cp "$source_file" "$target_file"
        print_success "Installed $file"
    done
}

# Main installation process
main() {
    echo "======================================"
    echo "Claude Code Handoff Commands Installer"
    echo "======================================"
    echo
    
    check_claude_code
    check_commands_directory
    backup_existing_files
    install_commands
    
    echo
    print_success "Installation completed successfully!"
    echo
    print_info "You can now use the following commands in Claude Code:"
    echo "  /handoff - Create project context snapshot"
    echo "  /resume  - Load project context from snapshot"
    echo
    print_info "You may need to restart Claude Code to see the new commands"
    
    if ls "$HOME/.claude/commands"/*_*.bak 1> /dev/null 2>&1; then
        echo
        print_info "Backup files created in $HOME/.claude/commands/"
        print_info "To restore a backup: mv backup_file.bak original_name.md"
    fi
}

# Run main function
main "$@"