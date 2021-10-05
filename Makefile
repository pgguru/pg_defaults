EXTENSION = pg_defaults
DATA = pg_defaults--base.sql sql/*.sql
PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
