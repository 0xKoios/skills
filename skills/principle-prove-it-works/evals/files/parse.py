"""Parse durations like "1h30m", "45s" or "2h" into seconds."""
import re

UNITS = {"h": 3600, "m": 60, "s": 1}
PART = re.compile(r"(\d+)([hms])")


def parse_duration(text):
    text = text.strip().lower()
    parts = PART.findall(text)
    if not parts:
        raise ValueError(f"not a duration: {text!r}")
    return sum(int(n) * UNITS[u] for n, u in parts)


if __name__ == "__main__":
    import sys

    for arg in sys.argv[1:]:
        print(arg, parse_duration(arg))
