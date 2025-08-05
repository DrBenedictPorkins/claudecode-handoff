# Claude Code Commands

Slash commands for Claude Code to enhance development workflow with context management and session archival.

## TL;DR

**Commands:**
- `/handoff` - Save project context to HANDOFF.md
- `/resume` - Load context from HANDOFF.md
- `/wtf-did-we-just-do` - Generate session summary for knowledge base

**Install:** `./install_handoff.sh` or `./install_wtf.sh`

## Commands Overview

### `/handoff`
Captures current project state, progress, and context into a comprehensive HANDOFF.md file. Merges with existing handoffs and uses temporal focus (recent work gets more detail).

### `/resume` 
Loads project context from HANDOFF.md to seamlessly continue work from previous sessions. Provides task prioritization and clarifying questions.

### `/wtf-did-we-just-do`
Creates concise technical summaries for your knowledge base. Focuses on discoveries, solutions, key decisions, and "aha" moments from the current session.

## Prerequisites

- Claude Code must be installed and working
- The `~/.claude/commands/` directory must exist (created automatically by Claude Code)

## Installation

**Handoff/Resume commands:**
```bash
./install_handoff.sh
```

**WTF command:**
```bash
./install_wtf.sh
```

Both installers:
- Verify Claude Code installation and commands directory
- Backup existing files with timestamps
- Install commands to `~/.claude/commands/`

## Usage

**Save project context:**
```
/handoff
```

**Resume from saved context:**
```
/resume
```

**Generate session summary:**
```
/wtf-did-we-just-do
```

### Best Practices
- Create handoffs at logical stopping points
- Use `/wtf-did-we-just-do` after solving complex problems or making key discoveries
- Clean up old `HANDOFF.md` files regularly

## File Structure

```
handoff-commands/
├── README.md              # This file
├── install_handoff.sh     # Handoff/resume installer
├── install_wtf.sh         # WTF command installer
└── commands/
    ├── handoff.md         # /handoff command
    ├── resume.md          # /resume command
    └── wtf-did-we-just-do.md  # /wtf-did-we-just-do command
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