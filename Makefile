EXTENSION = pg_defaults
MODULE_big = pg_defaults
DATA = pg_defaults--base.sql pg_defaults--base--0.0.1.sql
OBJS = pg_defaults.o 
PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
