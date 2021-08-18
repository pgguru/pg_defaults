# pg_defaults

Extension exposing current and historic GUCs and default values in queryable form.

## Installation

```console
$ git clone git@github.com:pgguru/pg_defaults.git
$ cd pg_defaults
$ export PG_CONFIG=path/to/pg_config
$ make install
$ psql -c 'CREATE EXTENSION pg_defaults'
```

## Available Functions

- `pg_defaults(version text)` :: returns the compiled-in defaults for the target version of PostgreSQL

- `versions_with_guc(guc text)` :: returns the version list of all PostgreSQL versions that contained a GUC with the given name

## Semi-internal functions

These functions are used internally for support, but may be handy for other usage.

- `versions_range(in_min_vers text, in_max_vers text)` :: returns the range of released PostgreSQL versions that the extension knows about between two inclusive endpoints.

- `normalize_version(version text)` :: returns an int-based representation of a PostgreSQL version number that will sort in ranges.  Expects 2 or 3 digit sequences separated by dots, like "8.2.10" or "13.3".  Returns an int like 80210 or 130300, for these examples.

## Tables

- `pg_defaults_versions` :: contains all of the version numbers this extension knows about.

- `pg_defaults_gucs` :: contains all of the known GUCs with version ranges for a given unique GUC row.  If something in the `--describe-config` output changed, there will be a different row for the changed values.

## Version support

Data was gathered back to PostgreSQL 8.2.0, using default compilation settings built using `pgenv` on a Fedora 33 machine.  Older versions could be added in the future if this is determined to be useful, but `pgenv` ran into issues with compilations in 8.1.x and below, so for now those are the versions this extension knows about.
