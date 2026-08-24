-- NetBird: create the additional databases used by the activity and embedded IdP stores.
-- The main 'netbird' database is created automatically via POSTGRES_DB.
-- This script only runs on first initialization of an empty data volume.
CREATE DATABASE netbird_activity;
CREATE DATABASE netbird_idp;
