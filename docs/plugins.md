# Plugins

[Return Home>](/jlenv/)

## Page Contents

* [Plugins](#plugins)
  * [<a href="#approved-plugins"></a>Approved plugins](#approved-plugins)
  * [<a href="#community-plugins"></a>Community plugins](#community-plugins)

See [Authoring Plugins](/jlenv/authoring-plugins.md) for instructions on how to write 
new commands for jlenv or hook into its functionality.

A plugin can be installed by dropping it in as a sub-directory of 
`$JLENV_ROOT/plugins`, or it can be located elsewhere on the system as long as 
`jlenv-*` executables are placed in the `$PATH` and hooks are installed 
accordingly somewhere in `$JLENV_HOOK_PATH`.

## Approved plugins

These plugins are endorsed by jlenv maintainers.

* [julia-installer](https://github.com/jlenv/jlenv-installer) - **install, update and diagnose jlenv**.
    Provides the `jlenv doctor` command.
* [julia-build](https://github.com/jlenv/julia-build) - compile and **install Julia**.
    Provides the `jlenv install` command.
* [vars](https://github.com/jlenv/jlenv-vars) - safely set global and per-project **environment variables**.
* [each](https://github.com/jlenv/jlenv-each) - execute the same command **with each** installed Julia
* [update](https://github.com/jlenv/jlenv-update) - **update jlenv** and installed plugins

<!--
* [ctags](https://github.com/jlenv/jlenv-ctags) - automatically **generate ctags** for jlenv Julia stdlibs
* [whatis](https://github.com/jlenv/jlenv-whatis) - **resolve abbreviations** to full Julia identifiers (useful for other plugins)
* [aliases](https://github.com/jlenv/jlenv-aliases) - **create aliases** for Julia versions -->

## Community plugins

Please add your plugin here.
