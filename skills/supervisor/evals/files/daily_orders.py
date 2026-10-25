"""Load one day of orders from the raw export into the warehouse orders table."""
import sqlite3
import sys

DB_PATH = "warehouse.db"


def load_day(conn, run_date, rows):
    conn.execute(
        "CREATE TABLE IF NOT EXISTS orders ("
        "order_id TEXT, order_date TEXT, customer_id TEXT, amount REAL)"
    )
    conn.executemany(
        "INSERT INTO orders (order_id, order_date, customer_id, amount) VALUES (?, ?, ?, ?)",
        [(r["order_id"], run_date, r["customer_id"], r["amount"]) for r in rows],
    )
    conn.commit()


def read_export(run_date):
    # Stand-in for the raw export: three orders per day.
    return [
        {"order_id": f"{run_date}-1", "customer_id": "c1", "amount": 10.0},
        {"order_id": f"{run_date}-2", "customer_id": "c2", "amount": 25.5},
        {"order_id": f"{run_date}-3", "customer_id": "c1", "amount": 7.25},
    ]


def main(run_date):
    conn = sqlite3.connect(DB_PATH)
    load_day(conn, run_date, read_export(run_date))
    count = conn.execute(
        "SELECT COUNT(*) FROM orders WHERE order_date = ?", (run_date,)
    ).fetchone()[0]
    print(f"{run_date}: {count} rows")
    conn.close()


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "2026-10-23")
