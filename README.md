# Sublime Text package for [Reason](https://github.com/facebook/reason)

## Installation (Sublime Text 3)

Soft prerequisite: for the inline error reporting system, you'll need [SublimeLinter](http://www.sublimelinter.com/en/latest/).

We're currently working with https://github.com/cynddl/sublime-text-merlin to
see whether our repos can be merged. In the meantime, you can do `Package
Control: Add Repository` in Sublime's command palette and add `https://github.com/reasonml-editor/sublime-reason.git`.

## Configuration

In your Sublime Text preferences (`Cmd+,` on Mac) you can add

```json
"path_to_refmt": "/Users/your_name/.opam/4.02.3/bin/refmt",
"reason_max_width": 80,
```

## Contribution

The files are written in the JSON format supported by the Sublime Text package
[AAAPackageDev](https://github.com/SublimeText/AAAPackageDev), because the
format is much easier to read / edit than the xml based plist format.

So install that package and then work on the .JSON-* files. There is a build
system that comes with that package, so if everything is set up right, you
should just be able to trigger the build (F7) and get the corresponding
.tmLanguage / .tmPreferences files. It will also display errors if you have not
formatted the file correctly.

One impact of using this indirect format is that you usually have to double
escape anything in the match patterns, i.e., "\\(" has to be "\\\\(" as otherwise
it will try to interpret '\\(' as a JSON escape code (which doesn't exist).

## Credits

This repo was forked from the MIT licensed [sublime-rust](https://github.com/jhasse/sublime-rust).

Created 2012 by [Daniel Patterson](mailto:dbp@riseup.net), as a near complete
from scratch rewrite of a package by [Felix
Martini](https://github.com/fmartini).

Derived primarily from the Vim syntax file, maintained by [Patrick
Walton](https://github.com/pcwalton) and [Ben Blum](https://github.com/bblum)

With a little help from the (now very outdated) TextMate rust mode written by
[Tom Ellis](https://github.com/tomgrohl).

## License

This package is licensed under the MIT License.
