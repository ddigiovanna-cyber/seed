CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE sensor_telemetry (
    time TIMESTAMPTZ NOT NULL,
    node_id VARCHAR(32) NOT NULL,
    temperature_c DOUBLE PRECISION,
    humidity_percent DOUBLE PRECISION,
    leaf_wetness_percent INTEGER,
    alien_pest_count INTEGER,
    battery_v DOUBLE PRECISION
);

SELECT create_hypertable('sensor_telemetry', 'time');

CREATE TABLE daily_gdd (
    date DATE NOT NULL,
    node_id VARCHAR(32) NOT NULL,
    t_min DOUBLE PRECISION,
    t_max DOUBLE PRECISION,
    gdd_daily DOUBLE PRECISION,
    gdd_cumulative DOUBLE PRECISION,
    PRIMARY KEY (date, node_id)
);
