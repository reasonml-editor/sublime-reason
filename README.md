# Sublime Text package for [Reason](https://github.com/facebook/reason)

## Installation (Sublime Text 3)

To install this plugin:

- Go to Command Palette (cmd-shift-p)
- Search `Package Control: Add Repository`
- Add `https://github.com/reasonml-editor/sublime-reason.git`
- Then do the normal `Package Control: Install Package` and install sublime-reason.

Other prerequisites:

- Install [LSP](https://github.com/tomv564/LSP)
- Install [ocaml-language-server](https://github.com/freebroccolo/ocaml-language-server) through `npm install -g ocaml-language-server`

## Configuration

**This plugin has the right defaults**. You don't need to touch them unless you know what you're doing.

In your Sublime Text preferences (`Cmd+,` on Mac) you can add

```json
"path_to_refmt": "/path/to/refmt",
"reason_max_width": 100,
```
