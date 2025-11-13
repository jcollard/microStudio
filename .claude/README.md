# Claude Configuration

This directory contains Claude Code configuration and hooks.

## UserPromptSubmit Hook

The `UserPromptSubmit` hook automatically adds context from `OnPromptSubmit.md` to every user prompt.

### Files

- **config.json** - Hook configuration
- **hooks/add-prompt-context.py** - Python script that reads and injects context
- **OnPromptSubmit.md** - Context file (edit this to change what context is added)

### Usage

Simply edit `OnPromptSubmit.md` to add or update the context you want included with every prompt. The hook will automatically read this file and inject its contents.

### Temporarily Disable

To temporarily disable the hook, you can:
1. Rename `OnPromptSubmit.md` to `OnPromptSubmit.md.disabled`
2. Or empty the file contents
3. Or comment out the hook in `config.json`

### Testing

Test the hook manually:
```bash
python .claude/hooks/add-prompt-context.py
```
