# Sublime Text package for [Reason](https://github.com/facebook/reason)

## Installation (Sublime Text 3)

To install this plugin:

- Go to Command Palette (cmd-shift-p)
- Search `Package Control: Add Repository`
- Add `https://github.com/reasonml-editor/sublime-reason.git`

Other prerequisites:

- Install [SublimeLinter](http://www.sublimelinter.com/en/latest/)
- Install [LSP](https://github.com/tomv564/LSP)
- Install [ocaml-language-server](https://github.com/freebroccolo/ocaml-language-server) master, like so:

```sh
git clone https://github.com/freebroccolo/ocaml-language-server.git
cd ocaml-language-server
npm install
npm install -g .
```

Then, go to Command Palette again, and go to `Preferences: LSP Settings` and paste the following:

```json
{
  "clients": {
    "reason": {
      "command": ["ocaml-language-server", "--stdio"],
      "scopes": ["source.reason", "source.ocaml"],
      "syntaxes": ["Packages/sublime-reason/Reason.tmLanguage"],
      "languageId": "reason"
    }
  }
}
```

And you should be ready to go! These installs are admittingly slightly manual right now; we'll automate a bit more of them in the future.

## Configuration

**This plugin has the right defaults**. You don't need to touch them unless you know what you're doing.

In your Sublime Text preferences (`Cmd+,` on Mac) you can add

```json
"path_to_refmt": "/path/to/refmt",
"reason_max_width": 100,
```
