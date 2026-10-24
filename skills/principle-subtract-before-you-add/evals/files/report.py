import xml.etree.ElementTree as ET  # left over from the dropped XML export
from datetime import date


def build_rows(orders):
    return [
        {"id": o["id"], "customer": o["customer"], "total": o["total"]}
        for o in orders
    ]


def to_text(rows):
    lines = [f"Report for {date.today().isoformat()}"]
    for r in rows:
        lines.append(f"{r['id']:>6}  {r['customer']:<20}  {r['total']:>10.2f}")
    return "\n".join(lines)


def to_html_legacy(rows):
    # Old HTML export. Nothing calls this since the dashboard moved.
    out = "<table>"
    for r in rows:
        out += f"<tr><td>{r['id']}</td><td>{r['customer']}</td></tr>"
    return out + "</table>"


def _format_total_v1(total):
    # Superseded by the format spec in to_text. No callers.
    return "%.2f" % total


# def to_xml(rows):
#     root = ET.Element("report")
#     raise NotImplementedError


def main(orders):
    print(to_text(build_rows(orders)))
