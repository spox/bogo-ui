# v0.4.0
* Update internal path layout

# v0.1.28
* Add custom exception type for declined confirmations

# v0.1.26
* Load io/console for noecho (#5)

# v0.1.24
* Fix type bug when checking default value on `Ui#ask` (#4)

# v0.1.22
* Support masking default answers via :hide_default option

# v0.1.20
* Include newline output when reading input with no echo

# v0.1.18
* Add `:no_echo` option to `Ui#ask_question` to disable STDIN echo

# v0.1.16
* Remove debug artifact

# v0.1.14
* Update how previously printed table content is tracked

# v0.1.12
* Allow `Ui#auto_confirm` and `Ui#auto_default` to be modified

# v0.1.10
* Update `Ui#ask_question` to properly handle non-string values

# v0.1.8
* Add `Ui#debug` output method
* Add `Ui#verbose` output method

# v0.1.6
* Include `Ui#fatal` output method
* Add helper into `Ui` directly for building new tables
* Provide optional validation for answers provided to `Ui#question`
* Add `Ui#confirm` method
* Allow optional support for auto confirm and auto default

# v0.1.4
* Add compat alias `#ask_question` -> `#ask`
* Allow passing instance to `Ui::Table` to proxy method calls

# v0.1.2
* Fix table generation
* Add test coverage

# v0.1.0
* Initial release
