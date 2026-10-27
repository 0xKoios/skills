"""Daily revenue report: one row per order with the amount paid.

Run: python3 report.py
"""
import sqlite3

ORDERS = [(1001, "2026-10-01", "north"), (1002, "2026-10-01", "south"),
          (1003, "2026-10-01", "north"), (1004, "2026-10-01", "east")]

# Card payments arrive from the gateway export; the newer export prefixes ids.
PAYMENTS = [("1001", 40.0), ("1002", 25.5), ("ORD-1003", 60.0), ("ORD-1004", 12.0)]


def load(conn):
    conn.execute("CREATE TABLE orders (id INTEGER, order_date TEXT, region TEXT)")
    conn.execute("CREATE TABLE payments (order_id TEXT, amount REAL)")
    conn.executemany("INSERT INTO orders VALUES (?, ?, ?)", ORDERS)
    conn.executemany("INSERT INTO payments VALUES (?, ?)", PAYMENTS)


def report(conn):
    return conn.execute(
        """
        SELECT o.id, o.region, SUM(p.amount) AS total
        FROM orders o
        LEFT JOIN payments p ON p.order_id = CAST(o.id AS TEXT)
        GROUP BY o.id, o.region
        ORDER BY o.id
        """
    ).fetchall()


if __name__ == "__main__":
    conn = sqlite3.connect(":memory:")
    load(conn)
    for row in report(conn):
        print(row)
