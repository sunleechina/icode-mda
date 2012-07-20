ALTER TABLE location DROP COLUMN geometry_object;
SELECT AddGeometryColumn( 'location', 'geometry_object', 4326, 'POINT', 2 );
CREATE INDEX location_geometry_object_idx ON location USING GIST ( geometry_object GIST_GEOMETRY_OPS );

VACUUM ANALYZE;

