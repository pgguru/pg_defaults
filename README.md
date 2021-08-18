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

## Examples

```
postgres=# select * from pg_defaults('13.3') limit 10;
          name           |  context   |                               group                               | vartype | reset_val | min_val |  max_val   |                                        description                                        | min_vers | max_vers
-------------------------+------------+-------------------------------------------------------------------+---------+-----------+---------+------------+-------------------------------------------------------------------------------------------+----------+----------
 DateStyle               | user       | Client Connection Defaults / Locale and Formatting                | STRING  | ISO, MDY  |         |            | Sets the display format for date and time values.                                         | 8.2.0    | 13.4
 IntervalStyle           | user       | Client Connection Defaults / Locale and Formatting                | ENUM    | postgres  |         |            | Sets the display format for interval values.                                              | 8.4.0    | 13.4
 TimeZone                | user       | Client Connection Defaults / Locale and Formatting                | STRING  | GMT       |         |            | Sets the time zone for displaying and interpreting time stamps.                           | 9.2.0    | 13.4
 archive_cleanup_command | sighup     | Write-Ahead Log / Archive Recovery                                | STRING  |           |         |            | Sets the shell command that will be executed at every restart point.                      | 12.0     | 13.4
 archive_command         | sighup     | Write-Ahead Log / Archiving                                       | STRING  |           |         |            | Sets the shell command that will be called to archive a WAL file.                         | 9.0.0    | 13.4
 archive_mode            | postmaster | Write-Ahead Log / Archiving                                       | ENUM    | off       |         |            | Allows archiving of WAL files using archive_command.                                      | 9.5.11   | 13.4
 archive_timeout         | sighup     | Write-Ahead Log / Archiving                                       | INTEGER | 0         | 0       | 1073741823 | Forces a switch to the next WAL file if a new file has not been started within N seconds. | 10.2     | 13.4
 array_nulls             | user       | Version and Platform Compatibility / Previous PostgreSQL Versions | BOOLEAN | FALSE     |         |            | Enable input of NULL elements in arrays.                                                  | 8.3.0    | 13.4
 authentication_timeout  | sighup     | Connections and Authentication / Authentication                   | INTEGER | 0         | 1       | 600        | Sets the maximum allowed time to complete client authentication.                          | 11.0     | 13.4
 autovacuum              | sighup     | Autovacuum                                                        | BOOLEAN | FALSE     |         |            | Starts the autovacuum subprocess.                                                         | 8.2.0    | 13.4
(10 rows)
```
