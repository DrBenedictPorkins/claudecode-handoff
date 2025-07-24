# Claude Code Handoff Commands

A simple utility that adds `/handoff` and `/resume` slash commands to Claude Code for seamless project context management across sessions.

## Overview

This project provides two essential commands for Claude Code:
- `/handoff` - Capture and save current project context to `HANDOFF.md`
- `/resume` - Load previously saved project context for continuity

Perfect for maintaining context when switching between sessions, sharing project state with team members, or preserving work across different environments.

## Prerequisites

- Claude Code must be installed and working
- The `~/.claude/commands/` directory must exist (created automatically by Claude Code)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/DrBenedictPorkins/claudecode-handoff.git
   cd claudecode-handoff
   ```

2. Run the installation script:
   ```bash
   ./install_handoff.sh
   ```

The installer will:
- Check that Claude Code is properly installed
- Verify the commands directory exists and is writable
- Backup any existing handoff/resume commands (with timestamp)
- Copy the new command files to `~/.claude/commands/`

## Usage

### Creating a Handoff
In any Claude Code session, use:
```
/handoff
```
This will guide you through capturing your current project context and save it to `HANDOFF.md` in your project root.

### Resuming from a Handoff
In a new Claude Code session, use:
```
/resume
```
This will load the context from `HANDOFF.md` and restore your session state.

### Best Practices
- Create handoffs at logical stopping points in your work
- Include relevant file paths, current objectives, and any important context
- Use descriptive commit messages when handoffs involve code changes
- Regularly clean up old `HANDOFF.md` files to avoid confusion

## File Structure

```
claudecode-handoff/
├── README.md              # This file
├── install_handoff.sh     # Installation script
└── commands/
    ├── handoff.md         # /handoff command implementation
    └── resume.md          # /resume command implementation
```

## Troubleshooting

### "Claude Code not found"
Ensure Claude Code is installed and accessible via the `claude` command:
```bash
claude --version
```

### "Commands directory not found"
The `~/.claude/commands/` directory should be created automatically by Claude Code. If missing, try:
```bash
mkdir -p ~/.claude/commands
```

### "Permission denied"
Ensure you have write permissions to the `~/.claude/commands/` directory:
```bash
ls -la ~/.claude/commands
```

### Commands not appearing
After installation, restart Claude Code or refresh your session to see the new commands.

## Backup and Recovery

The installer automatically backs up existing command files with timestamps:
- `handoff_YYYYMMDD_HHMMSS.bak`
- `resume_YYYYMMDD_HHMMSS.bak`

To restore a backup:
```bash
cd ~/.claude/commands
mv handoff_20240101_120000.bak handoff.md
```

## Contributing

This is a simple utility project. Feel free to fork and customize the command implementations for your specific workflow needs.

## License

MIT License - feel free to use and modify as needed.