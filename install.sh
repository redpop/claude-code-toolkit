#!/bin/bash

# Claude Code Slash Commands Installation Script
# Usage: curl -fsSL <url> | bash -s -- <prefix>
# Example: curl -fsSL <url> | bash -s -- mytools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to extract repository info from git URL
get_repo_info() {
    local url="$1"
    local owner=""
    local name=""
    
    # Remove trailing .git if present
    url="${url%.git}"
    
    # Handle different URL formats
    if [[ "$url" =~ ^https?://github\.com/([^/]+)/([^/]+) ]]; then
        # HTTPS GitHub URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    elif [[ "$url" =~ ^git@github\.com:([^/]+)/([^/]+) ]]; then
        # SSH GitHub URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    elif [[ "$url" =~ ^https?://gitlab\.com/([^/]+)/([^/]+) ]]; then
        # HTTPS GitLab URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    elif [[ "$url" =~ ^git@gitlab\.com:([^/]+)/([^/]+) ]]; then
        # SSH GitLab URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    elif [[ "$url" =~ ^https?://bitbucket\.org/([^/]+)/([^/]+) ]]; then
        # HTTPS Bitbucket URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    elif [[ "$url" =~ ^git@bitbucket\.org:([^/]+)/([^/]+) ]]; then
        # SSH Bitbucket URL
        owner="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
    else
        # Generic pattern for other git hosts
        # Try to extract from path-like structure
        if [[ "$url" =~ /([^/]+)/([^/]+)/?$ ]]; then
            owner="${BASH_REMATCH[1]}"
            name="${BASH_REMATCH[2]}"
        fi
    fi
    
    echo "$owner|$name"
}

# Function to get repository URL from current script location
get_script_repo_url() {
    # If we're running from a local file, try to detect git remote
    if [ -f "$0" ] && [ -d "$(dirname "$0")/.git" ]; then
        local script_dir
        script_dir="$(cd "$(dirname "$0")" && pwd)"
        cd "$script_dir"
        if git remote get-url origin 2>/dev/null; then
            return 0
        fi
    fi
    return 1
}

# Detect repository URL
if [ -n "$CLAUDE_COMMANDS_REPO_URL" ]; then
    # Use environment variable if set
    REPO_URL="$CLAUDE_COMMANDS_REPO_URL"
    REPO_SOURCE="environment variable"
elif script_url=$(get_script_repo_url); then
    # Use detected URL from script location
    REPO_URL="$script_url"
    REPO_SOURCE="script location"
else
    # Fall back to default
    REPO_URL="https://github.com/redpop/claude-code-slash-commands.git"
    REPO_SOURCE="default"
fi

# Extract repository info
REPO_INFO=$(get_repo_info "$REPO_URL")
REPO_OWNER="${REPO_INFO%|*}"
REPO_NAME="${REPO_INFO#*|}"

# Default values
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

# Function to print colored output
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Show repository information
if [ "$REPO_SOURCE" != "default" ] || [ -n "$CLAUDE_COMMANDS_REPO_URL" ]; then
    print_info "Using repository: $REPO_URL (from $REPO_SOURCE)"
fi

# Check if prefix is provided
if [ -z "$1" ]; then
    print_error "No prefix provided. Usage: $0 <prefix>"
    echo "Example: $0 mytools"
    exit 1
fi

PREFIX="$1"
INSTALL_PATH="$CLAUDE_COMMANDS_DIR/$PREFIX"

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install git first."
    exit 1
fi

# Create Claude commands directory if it doesn't exist
if [ ! -d "$CLAUDE_COMMANDS_DIR" ]; then
    print_info "Creating Claude commands directory: $CLAUDE_COMMANDS_DIR"
    mkdir -p "$CLAUDE_COMMANDS_DIR"
fi

# Check if prefix directory already exists and is a git repository
if [ -d "$INSTALL_PATH/.git" ]; then
    print_info "Updating existing installation..."
    cd "$INSTALL_PATH"
    
    # Stash any local changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        print_info "Stashing local changes..."
        git stash push -m "Auto-stash before update"
    fi
    
    # Pull latest changes
    if git pull --ff-only origin main; then
        print_success "Updated successfully!"
        
        # Check if there were stashed changes
        if git stash list | grep -q "Auto-stash before update"; then
            print_info "Reapplying local changes..."
            git stash pop || print_error "Failed to reapply local changes. Check 'git stash list'"
        fi
    else
        print_error "Failed to update. You may have local changes that conflict."
        echo "Try resolving conflicts manually in: $INSTALL_PATH"
        exit 1
    fi
elif [ -d "$INSTALL_PATH" ]; then
    # Directory exists but is not a git repository
    echo -e "${YELLOW}Warning: Directory $INSTALL_PATH exists but is not a git repository.${NC}"
    echo "This appears to be an old installation. Would you like to replace it with a git-based installation?"
    echo "This will enable easy updates with 'git pull' in the future."
    read -p "Replace with git-based installation? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Backing up existing installation..."
        mv "$INSTALL_PATH" "${INSTALL_PATH}.backup"
        print_info "Old installation backed up to: ${INSTALL_PATH}.backup"
    else
        print_info "Installation cancelled."
        exit 0
    fi
fi

# Fresh installation
if [ ! -d "$INSTALL_PATH/.git" ]; then
    print_info "Installing commands to $INSTALL_PATH..."
    
    # Clone the full repository first
    if ! git clone "$REPO_URL" "$INSTALL_PATH"; then
        print_error "Failed to clone repository"
        exit 1
    fi
    
    cd "$INSTALL_PATH"
    
    # Enable sparse checkout
    git config core.sparseCheckout true
    
    # Configure sparse checkout to track commands and agents directories
    {
        echo "commands/*"
        echo "agents/*"
    } > .git/info/sparse-checkout
    
    # Re-read the tree with sparse checkout
    git read-tree -m -u HEAD
    
    # Move commands and agents content to root and remove everything else
    if [ -d "commands" ]; then
        # Move all content from commands/ to root
        mv commands/* . 2>/dev/null || true
        mv commands/.[^.]* . 2>/dev/null || true
        
        # Remove the now-empty commands directory
        rmdir commands 2>/dev/null || true
    fi
    
    if [ -d "agents" ]; then
        # Move all content from agents/ to root
        mv agents/* . 2>/dev/null || true
        mv agents/.[^.]* . 2>/dev/null || true
        
        # Remove the now-empty agents directory
        rmdir agents 2>/dev/null || true
    fi
    
    # Remove all other files/directories that shouldn't be here
    rm -rf README.md LICENSE install.sh scripts CLAUDE.md .gitignore CHANGELOG.md docs 2>/dev/null || true
        
        # Update sparse checkout to track the new structure
        {
            echo "/*"
            echo "!README.md"
            echo "!LICENSE"
            echo "!install.sh"
            echo "!scripts"
            echo "!CLAUDE.md"
            echo "!.gitignore"
            echo "!CHANGELOG.md"
            echo "!docs"
            # Important: Track commands and agents directories to get new files on pull
            echo "commands/**"
            echo "agents/**"
        } > .git/info/sparse-checkout
        
        # Store the repository URL for hook usage
        git config claude.repo-url "$REPO_URL"
        
        # Create a custom git hook to handle updates
        cat > .git/hooks/post-merge << 'HOOKEOF'
#!/bin/bash
# Post-merge hook to handle directory structure after pull
# Hook version: 6

# Function to get list of command files from git
get_git_command_files() {
    git ls-tree -r HEAD --name-only | grep -E "^(commands|agents)/" | sed -E 's|^(commands|agents)/||' | grep -v "^$"
}

# Function to get list of local command files
get_local_command_files() {
    find . -name "*.md" -not -path "./.git/*" -not -path "./commands/*" -not -path "./agents/*" | sed 's|^\./||'
}

# Step 1: Remove local files that no longer exist in git
echo "Checking for removed commands..."
for local_file in $(get_local_command_files); do
    if ! get_git_command_files | grep -q "^${local_file}$"; then
        echo "Removing obsolete command: $local_file"
        rm -f "$local_file"
        # Remove empty directories
        dir=$(dirname "$local_file")
        if [ "$dir" != "." ] && [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
            rmdir "$dir" 2>/dev/null || true
        fi
    fi
done

# Step 2: Move new/updated files from commands/ and agents/ to root
for source_dir in commands agents; do
    if [ -d "$source_dir" ]; then
        echo "Processing new/updated files from $source_dir..."
        # Use find to handle nested directories properly
        find "$source_dir" -type f -name "*.md" | while read -r file; do
            # Get relative path from source directory
            rel_path="${file#$source_dir/}"
            target_dir=$(dirname "$rel_path")
            
            # Create target directory if needed
            if [ "$target_dir" != "." ]; then
                mkdir -p "$target_dir"
            fi
            
            # Move or update the file
            if [ -f "$rel_path" ]; then
                # File exists, check if it's newer
                if [ "$file" -nt "$rel_path" ]; then
                    echo "Updating: $rel_path"
                    mv -f "$file" "$rel_path"
                else
                    rm -f "$file"
                fi
            else
                echo "Adding new file: $rel_path"
                mv "$file" "$rel_path"
            fi
        done
        
        # Clean up empty directories
        find "$source_dir" -type d -empty -delete 2>/dev/null || true
    fi
done

# Step 3: Clean up any unwanted files
rm -rf README.md LICENSE install.sh scripts CLAUDE.md .gitignore CHANGELOG.md docs 2>/dev/null || true

# Step 4: Ensure sparse-checkout is properly configured
git sparse-checkout reapply 2>/dev/null || true

# Step 5: Check if hooks need updating
check_hook_version() {
    # Extract version from the hook file header (first 10 lines)
    local current_version=$(head -10 "$1" 2>/dev/null | grep "^# Hook version:" | sed 's/.*: //')
    local repo_file="install.sh"
    
    # Check if install.sh exists in git
    if git show HEAD:install.sh >/dev/null 2>&1; then
        # Extract hook version from repository's install.sh - look for the exact line after "Hook version:"
        local latest_version=$(git show HEAD:install.sh | grep -A1 "cat > .git/hooks/post-merge << 'HOOKEOF'" | grep -A1 "Post-merge hook" | grep "^# Hook version:" | sed 's/.*: //')
        
        if [ -n "$latest_version" ] && [ -n "$current_version" ] && [ "$latest_version" != "$current_version" ]; then
            # Get repository URL from git config or remote
            local repo_url=$(git config claude.repo-url || git config --get remote.origin.url)
            
            # Extract owner and repo name for URL construction
            local repo_info owner repo_name
            
            # Function to extract repo info (simplified version for hook)
            if [[ "$repo_url" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
                owner="${BASH_REMATCH[1]}"
                repo_name="${BASH_REMATCH[2]}"
                local raw_url="https://raw.githubusercontent.com/$owner/$repo_name/main"
            elif [[ "$repo_url" =~ gitlab\.com[:/]([^/]+)/([^/.]+) ]]; then
                owner="${BASH_REMATCH[1]}"
                repo_name="${BASH_REMATCH[2]}"
                local raw_url="https://gitlab.com/$owner/$repo_name/-/raw/main"
            elif [[ "$repo_url" =~ bitbucket\.org[:/]([^/]+)/([^/.]+) ]]; then
                owner="${BASH_REMATCH[1]}"
                repo_name="${BASH_REMATCH[2]}"
                local raw_url="https://bitbucket.org/$owner/$repo_name/raw/main"
            else
                # Fallback to simple transformation
                local raw_url=$(echo "$repo_url" | sed -e 's/\.git$//' -e 's/$/\/raw\/main/')
            fi
            
            echo ""
            echo "⚠️  Hook Update Available!"
            echo "Your git hooks are version $current_version, but version $latest_version is available."
            echo "Run the following command to update your hooks:"
            echo ""
            echo "  curl -fsSL ${raw_url}/scripts/update-hooks.sh | bash"
            echo ""
            echo "Or manually reinstall with the latest install.sh"
            echo ""
        fi
    fi
}

# Check this hook's version
check_hook_version "$0"
HOOKEOF
        chmod +x .git/hooks/post-merge
        
        # Also create post-checkout hook (git pull sometimes uses checkout instead of merge)
        cp .git/hooks/post-merge .git/hooks/post-checkout
        chmod +x .git/hooks/post-checkout
        
        print_success "Commands and agents installed successfully!"
    else
        print_error "No commands directory found in repository"
        cd ..
        rm -rf "$INSTALL_PATH"
        exit 1
    fi
fi

# Display available commands and agents
echo
print_success "Installation complete!"
echo
echo "Available commands:"
echo

# Find all .md files in the installation directory
if [ -d "$INSTALL_PATH" ]; then
    # First list commands (excluding agent files)
    while IFS= read -r -d '' file; do
        # Skip hidden directories like .git
        if [[ "$file" == *"/.git/"* ]]; then
            continue
        fi
        # Skip agent files (they have specific suffixes)
        if [[ "$file" =~ -specialist\.md$|-optimizer\.md$|-engineer\.md$|-architect\.md$|-expert\.md$ ]]; then
            continue
        fi
        # Get relative path from installation directory
        relative_path="${file#"$INSTALL_PATH/"}"
        # Remove .md extension
        command_path="${relative_path%.md}"
        # Replace / with :
        command_name="${command_path//\//:}"
        echo "  /${PREFIX}:${command_name}"
    done < <(find "$INSTALL_PATH" -name "*.md" -type f -print0 | sort -z)
    
    # Now list agents if any exist
    echo
    agent_files=$(find "$INSTALL_PATH" -name "*-specialist.md" -o -name "*-optimizer.md" -o -name "*-engineer.md" -o -name "*-architect.md" -o -name "*-expert.md" 2>/dev/null)
    if [ -n "$agent_files" ]; then
        echo "Available sub-agents:"
        echo
        echo "$agent_files" | while read -r file; do
            if [ -n "$file" ]; then
                agent_name=$(basename "$file" .md)
                echo "  - $agent_name"
            fi
        done
    fi
fi

echo
echo "To use these commands in Claude Code, type '/' followed by the command name."
echo
echo "To update in the future:"
echo "  cd $INSTALL_PATH && git pull"

# Only show curl command if we can determine the raw URL
if [ -n "$REPO_OWNER" ] && [ -n "$REPO_NAME" ]; then
    # Construct raw URL based on detected platform
    if [[ "$REPO_URL" =~ github\.com ]]; then
        RAW_BASE_URL="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main"
    elif [[ "$REPO_URL" =~ gitlab\.com ]]; then
        RAW_BASE_URL="https://gitlab.com/$REPO_OWNER/$REPO_NAME/-/raw/main"
    elif [[ "$REPO_URL" =~ bitbucket\.org ]]; then
        RAW_BASE_URL="https://bitbucket.org/$REPO_OWNER/$REPO_NAME/raw/main"
    else
        # Generic pattern - might not work for all hosts
        RAW_BASE_URL="${REPO_URL%.git}/raw/main"
    fi
    
    echo "  # or run this install script again:"
    echo "  curl -fsSL $RAW_BASE_URL/install.sh | bash -s -- $PREFIX"
fi

echo
print_success "Happy coding with Claude Code! 🚀"