# Michael's Dotfiles Repository

This is a personal dotfiles repository managed with **chezmoi**. This file provides context and guidelines for working in this environment.

## Environment Overview

### System Details
- **Shell**: Fish shell (fish)
- **Dotfiles Manager**: chezmoi
- **Package Manager**: mise (primary), with fallbacks to homebrew (macOS), apt, pacman (Linux)
- **Python Package Manager**: uv (DO NOT use pipx or pip directly)
- **Container Runtime**: Orbstack/Docker on macOS, plain Docker on Linux distros
- **Editors**:
  - helix/hx for terminal editing
  - Visual Studio Code for heavyweight editing

### Multi-Platform Usage
This dotfiles configuration is used across:
- macOS (main laptop)
- Multiple Linux distributions (remote machines)

**IMPORTANT**: Always check the OS/distro context before running platform-specific commands!

## Repository Structure

### Key Directories
- `dot_config/` - Configuration files (managed by chezmoi)
  - `dot_config/mise/` - mise tool version configurations
  - `dot_config/private_fish/` - Fish shell functions and config
  - `dot_config/helix/` - Helix editor configuration
- `.chezmoidata/` - chezmoi template data (e.g., packages.yaml)
- `~/Developer/` - **All cloned repositories go here** (create if missing)

### Important Files
- `AGENTS.md` - System notes and preferences
- `run_onchange_install-packages.sh.tmpl` - Package installation template
- `k3d-cluster.yaml` - k3d cluster configuration

## Development Guidelines

### Tool Preferences

#### Package Installation
1. **First choice**: mise (for most tools)
2. **Fallback**: OS-specific package managers only when mise doesn't have the tool
   - macOS: homebrew
   - Linux: apt, pacman, etc.

#### Python Development
- **Always use uv** for Python package management
- Do NOT use pipx or pip directly

#### Container/Kubernetes Operations
- **CRITICAL**: For any potentially destructive kubectl/helm/k8s commands, **ASK FOR APPROVAL FIRST**
- Reason: Need to verify correct kubecontext is active

### File Organization
- Clone all repositories to `~/Developer/`
- Create the directory if it doesn't exist before cloning

### Chezmoi Workflow
When modifying dotfiles:
1. Edit files in the chezmoi source directory (this repo)
2. Use `chezmoi apply` to deploy changes
3. Template files use `.tmpl` extension and can access `.chezmoi` variables

## Platform-Specific Notes

### macOS
- Uses Orbstack for containers
- Package installation via homebrew (when mise unavailable)
- Packages defined in `.chezmoidata/packages.yaml`

### Linux
- Uses standard Docker
- Package managers: apt (Debian/Ubuntu), pacman (Arch), etc.

## Common Operations

### Adding New Tools
1. Check if available in mise: `mise ls-remote <tool>`
2. If yes: Add to `dot_config/mise/config.toml`
3. If no: Add to platform-specific package list in `.chezmoidata/packages.yaml`

### Managing Fish Functions
- Custom fish functions are in `dot_config/private_fish/functions/`
- Config file: `dot_config/private_fish/config.fish`

### Editor Configuration
- Helix: `dot_config/helix/`
- Language-specific settings: `dot_config/helix/languages.toml`

## Safety Guidelines

### Destructive Operations
- **Kubernetes**: Always confirm context before destructive operations
- **Git**: Standard safety practices apply
- **System packages**: Verify OS before installation commands

### Testing Changes
- Use `chezmoi diff` to preview changes before applying
- Test on non-production systems first when possible

## Quick Reference

```bash
# Apply dotfiles changes
chezmoi apply

# Edit a dotfile
chezmoi edit ~/.config/fish/config.fish

# Add a new file to chezmoi
chezmoi add ~/.config/newfile

# See what would change
chezmoi diff

# Verify mise tools
mise list

# Python package management
uv pip install <package>
uv venv
```

## Additional Context

See `AGENTS.md` for more detailed system notes and preferences.
