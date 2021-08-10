#include "postgres.h"
#include "fmgr.h"
#include "funcapi.h"
#include "miscadmin.h"

PG_MODULE_MAGIC;

void _PG_init(void);
void _PG_fini(void);

Datum pg_defaults(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(pg_defaults);

void _PG_init(void)
{
	/* ... C code here at time of extension loading ... */
}

void _PG_fini(void)
{
	/* ... C code here at time of extension unloading ... */
}

Datum pg_defaults(PG_FUNCTION_ARGS)
{
	PG_RETURN_NULL();
}
