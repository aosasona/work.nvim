![Screenshot](./screenshot.png)

This config does not have a lot of stuff you may want but it is functional for me. I work directly on a remote server at work which means I cannot install all willy-nilly things like Ripgrep and similar, so I had to craft this config from scratch after work because I did not want to work with Jetbrains' remote development thingy anymore when I could just work directly off the server.

# Highlights
- Telescope with "find file" only (no ripgrep sadly)
- Some LSP features like rename symbol, code actions, goto definition, show hover documentation etc
- Diagnostics (+ Trouble support)
- No file tree (by choice; I find `telescope` and `egrep` enough)
- Tabs and panes support
- Session auto-save and auto-restore (saves panes, tabs and cursor positions based on git branches; this is SUPER useful)
- Autoformatting is disabled by default (for... reasons)
- Chooses DOS format first before trying Unix for file formats (to maintain consistency, again, due to certain things we use or don't use)
- Which-key, comment (`<leader>/`) and treesitter

It has just enough to be usable for me day-to-day for the things I do which is fine, the keymaps almost mirror my personal setup [here](https://github.com/aosasona/astronvim) but you may want to extend this setup significantly to make it usable for your own workflow.
