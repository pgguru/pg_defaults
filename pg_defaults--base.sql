CREATE TABLE pg_defaults_versions (
    version text primary key
);

CREATE TABLE pg_defaults_gucs (
    name text,
    context text,
    "group" text,
    vartype text,
    reset_val text,
    min_val text,
    max_val text,
    description text,
    min_vers text,
    max_vers text
);

CREATE FUNCTION normalize_version(in_version text)
RETURNS int AS $EOF$
  SELECT 10000 * split_part(in_version,'.',1)::int +
         100 * split_part(in_version,'.',2)::int +
         case when split_part(in_version,'.',3) = ''
              then 0
              else split_part(in_version,'.',3)::int
         end
$EOF$
LANGUAGE SQL;

CREATE INDEX pg_default_gucs_min_version_idx ON pg_defaults_gucs (min_vers);
CREATE INDEX pg_default_gucs_max_version_idx ON pg_defaults_gucs (max_vers);

CREATE FUNCTION pg_defaults(in_version text)
RETURNS setof pg_defaults_gucs AS $EOF$
SELECT pg_defaults_gucs.* FROM pg_defaults_gucs JOIN pg_defaults_versions v ON in_version = v.version
WHERE
    normalize_version(in_version) <= normalize_version(max_vers) and
    normalize_version(in_version) >= normalize_version(min_vers)
$EOF$
LANGUAGE SQL;

CREATE FUNCTION versions_range(in_min_vers text, in_max_vers text)
RETURNS setof text AS $EOF$
    SELECT version FROM pg_defaults_versions WHERE 
    normalize_version(version) <= normalize_version(in_max_vers) AND
    normalize_version(version) >= normalize_version(in_min_vers)
$EOF$
LANGUAGE SQL;

CREATE FUNCTION versions_with_guc (in_name text) RETURNS setof text AS
$EOF$
    SELECT version FROM (
        SELECT versions_range(min_vers, max_vers) AS version
        FROM pg_defaults_gucs where name = in_name) v
    ORDER BY normalize_version(version)
$EOF$
LANGUAGE SQL;
