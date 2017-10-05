
CREATE OR REPLACE FUNCTION ver_get_versioned_tables()
RETURNS TABLE(
    schema_name NAME,
    table_name  NAME,
    key_column  VARCHAR(64)
) AS $$
    SELECT
        schema_name,
        table_name,
        key_column
    FROM 
        @extschema@.versioned_tables
    WHERE
        versioned = TRUE AND
        @extschema@.ver_is_table_versioned(schema_name, table_name);
$$ LANGUAGE sql;

/**
* Get the versioned table key
*
* @return       The versioned table key
*/
CREATE OR REPLACE FUNCTION ver_get_versioned_table_key(
    p_schema_name NAME,
    p_table_name  NAME
)
RETURNS VARCHAR(64)
AS $$
    SELECT
        key_column
    FROM 
        @extschema@.versioned_tables
    WHERE
        versioned = TRUE AND
        schema_name = $1 AND
        table_name = $2 AND
        @extschema@.ver_is_table_versioned(schema_name, table_name);
$$ LANGUAGE sql;


