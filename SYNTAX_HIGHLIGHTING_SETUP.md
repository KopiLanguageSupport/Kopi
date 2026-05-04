# Kopi Syntax Highlighting Setup

The Kopi language support extension has been installed. To activate it:

## Quick Fix

1. **Reload VS Code Window**
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Developer: Reload Window"
   - Press Enter

2. **Or manually restart VS Code**
   - Close VS Code completely
   - Reopen it

## What you should see:
- `.kopi` files have a golden **"K"** icon
- Keywords (`let`, `def`, `if`, `while`, etc.) are **blue** and bold
- Strings are **orange**
- Comments (starting with `#`) are **green** and italic
- Built-in functions (`print`, `read`, `len`, etc.) are **yellow**
- Numbers are **light green**

## Verify it's working:
1. Open any `.kopi` file (like `examples/basics.kopi`)
2. Look at the tab - you should see the "K" icon next to the filename
3. Keywords and strings should be colored

If it's still not working after reloading:
- Check VS Code's Extensions panel (sidebar)
- Look for "Kopi Language Support" - it should be enabled
- If not listed, try installing from `.vscode-ext/kopi-language-support` folder
