CREATE FUNCTION pg_defaults(version text)
RETURNS TABLE (version text, name text, setting text) AS 'MODULE_PATHNAME', 'pg_defaults'
LANGUAGE C STRICT STABLE;
