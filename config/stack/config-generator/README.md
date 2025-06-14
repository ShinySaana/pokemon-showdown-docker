# config-generator

Last Config Sync: Never

Generates Pokemon Showdown configuration files using templates in `./templates` and values in `../config.yml`.

**Each configuration file generated is starting point; review the generated config carefully.**

---

Some "logical" configuration values are duplicated between files and projects, and should be kept in sync. This is why this part of `psim-dc` exist. Furthermore, a lot of boilerplate must be taken care of to make sure the Showdown stack works (with or without Docker).

**There is a strong caveat to this approach**: Templates are copied from a config example file at a given point in time. This is extremely susceptible to bitrot and desyncs between the main Pokemon Showdown projects and the templates.

Before using this; ensure that the examples files and the templates are not desynced.

This is far from ideal, but generating the config from one place is better than nothing. If anything, this is a terrible but existing documentation of the interoperating parts of the Showdown stack.

TODO: Add a config-diff command to `psim-dc`, to compare the config files in `./templates` with their upstream counterpart. Not ideal, but should help identify when config files are desynced (maybe in an automated way through Github Actions?) 
