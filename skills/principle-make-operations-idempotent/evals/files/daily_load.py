"""Load one day of sales from the orders API into the warehouse table daily_sales.

Run by the scheduler every morning for yesterday, and by hand for backfills:
    python daily_load.py 2026-10-01
"""
import sqlite3
import sys

import orders_api  # returns a list of dicts for one date


def run(run_date, db_path="warehouse.db"):
    rows = orders_api.fetch_orders(run_date)
    conn = sqlite3.connect(db_path)
    conn.execute(
        "CREATE TABLE IF NOT EXISTS daily_sales "
        "(sale_date TEXT, order_id TEXT, store TEXT, amount REAL)"
    )
    conn.executemany(
        "INSERT INTO daily_sales (sale_date, order_id, store, amount) VALUES (?, ?, ?, ?)",
        [(run_date, r["order_id"], r["store"], r["amount"]) for r in rows],
    )
    conn.commit()
    conn.close()
    print(f"loaded {len(rows)} rows for {run_date}")


if __name__ == "__main__":
    run(sys.argv[1])
