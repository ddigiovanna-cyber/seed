import psycopg2
from datetime import date, timedelta

T_BASE = 14.0
GDD_ALERT_THRESHOLD = 500.0

conn = psycopg2.connect("dbname=agri_iot user=admin password=secret host=localhost")
cur = conn.cursor()
yesterday = date.today() - timedelta(days=1)

cur.execute("""
    SELECT node_id, MIN(temperature_c), MAX(temperature_c)
    FROM sensor_telemetry WHERE time::date = %s GROUP BY node_id;
""", (yesterday,))

for node_id, t_min, t_max in cur.fetchall():
    gdd_today = max(0.0, ((t_max + t_min) / 2.0) - T_BASE)
    cur.execute("SELECT COALESCE(gdd_cumulative, 0.0) FROM daily_gdd WHERE node_id = %s AND date = %s;", 
                (node_id, yesterday - timedelta(days=1)))
    prev_cum = cur.fetchone()
    gdd_cum = (prev_cum[0] if prev_cum else 0.0) + gdd_today
    
    cur.execute("""
        INSERT INTO daily_gdd (date, node_id, t_min, t_max, gdd_daily, gdd_cumulative)
        VALUES (%s, %s, %s, %s, %s, %s)
        ON CONFLICT (date, node_id) DO UPDATE 
        SET gdd_daily = EXCLUDED.gdd_daily, gdd_cumulative = EXCLUDED.gdd_cumulative;
    """, (yesterday, node_id, t_min, t_max, gdd_today, gdd_cum))

conn.commit()
cur.close()
conn.close()
