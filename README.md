Testing some tweaks. Ignore

## Install

- Clone repo locally, switch to this branch
- Cmd-shift-p -> Preferences: Browse Packages
- In terminal, `ln -s /path/to/your/cloned/repo ./`

## Config

- Cmd-shift-p -> UI: Select Color Scheme. Use Mariana for best effects. Or try another one and tell me
- Open this repo's `Default.sublime-settings`, put in the absolute path to the formatter exe in formatterLocation

To format: cmd-shift-r

## Test Syntax

Docs at https://www.sublimetext.com/docs/3/syntax.html and https://www.sublimetext.com/docs/3/scope_naming.html

Tldr (documented in first link):

- Change `Reason.sublime-syntax`
- Open `syntax_test.ml`
- Cmd-shift-p -> Build With: Syntax Tests
