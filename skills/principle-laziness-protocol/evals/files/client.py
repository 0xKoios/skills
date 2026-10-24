import json
import urllib.request

BASE_URL = "https://api.example.com"


def fetch(path, timeout=10):
    """GET a JSON resource from the API."""
    with urllib.request.urlopen(f"{BASE_URL}{path}", timeout=timeout) as resp:
        return json.loads(resp.read().decode("utf-8"))


def get_user(user_id):
    return fetch(f"/users/{user_id}")
