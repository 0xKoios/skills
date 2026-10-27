import os
import csv


def load_invoices(path):
    """Read invoices.csv into a list of dicts with a numeric amount."""
    rows = []
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            ammount = float(row["amount"])
            rows.append({"id": row["id"], "amount": ammount})
    return rows


def total(rows):
    return sum(r["amount"] for r in rows)
