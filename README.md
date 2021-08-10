# pg_defaults

Extension exposing current and historic GUCs and default values in queryable form.

## Usage

```console
$ git clone git@github.com:pgguru/pg_defaults.git
$ cd pg_defaults
$ make PG_CONFIG=path/to/pg_config && make install PG_CONFIG=path/to/pg_config
$ psql -c 'CREATE EXTENSION pg_defaults'
```
