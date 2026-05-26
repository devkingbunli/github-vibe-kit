#!/bin/bash
# GitHub Vibe Kit — Setup Script (Linux / macOS)
# Run: bash setup.sh [target-project-path]

set -e

TARGET="${1:-.}"
TARGET=$(realpath "$TARGET")
SCRIPT_DIR=$(dirname "$(realpath "$0")")

echo ""
echo "================================"
echo "   GitHub Vibe Kit — Setup      "
echo "================================"
echo ""

# Step 1: Copy .github/ to project
echo "[1/3] Copying .github/ to $TARGET ..."
cp -r "$SCRIPT_DIR/.github" "$TARGET/"
echo "      Done."

# Step 2: Copy .agent/ engine
echo "[2/3] Copying .agent/ engine to $TARGET ..."
cp -r "$SCRIPT_DIR/.agent" "$TARGET/"
echo "      Done."

# Step 3: Done
echo ""
echo "[3/3] Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open $TARGET in VS Code"
echo "  2. Edit .github/copilot-instructions.md → update the 'YOUR PROJECT' section"
echo "  3. Reload VS Code window (Ctrl+Shift+P → 'Reload Window')"
echo "  4. Use 📎 → Prompt... in Copilot Chat to activate workflows and agents"
echo ""
