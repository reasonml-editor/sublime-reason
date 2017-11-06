# Sublime Text package for [Reason](https://github.com/facebook/reason)

## Features

This plugin simply uses our [language server](https://github.com/freebroccolo/ocaml-language-server#server-capabilities). Every feature is supported. Additionally, we provide the basics: snippets and syntax highlighting.

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

**Nothing**. Sublime's LSP above has built-in OCaml/Reason support. But you might want to set up some shorcuts for common actions. See them [here](https://lsp.readthedocs.io/en/latest/#features).
