import re

EMAIL = re.compile(r"^[^@\s]+@[^@\s]+\.[^@\s]+$")
db = {}


def handle_signup(body):
    """HTTP handler for POST /signup. body is the parsed JSON dict."""
    user = create_user(body.get("email"), body.get("age"))
    send_welcome(user)
    return 201, user


def create_user(email, age):
    if not isinstance(email, str) or not EMAIL.match(email):
        raise ValueError("invalid email")
    if not isinstance(age, int) or age < 13:
        raise ValueError("invalid age")
    user = {"email": email.lower(), "age": age}
    save_user(user)
    return user


def save_user(user):
    if not isinstance(user.get("email"), str) or not EMAIL.match(user["email"]):
        raise ValueError("invalid email")
    if not isinstance(user.get("age"), int) or user["age"] < 13:
        raise ValueError("invalid age")
    db[user["email"]] = user


def send_welcome(user):
    if not isinstance(user.get("email"), str) or not EMAIL.match(user["email"]):
        raise ValueError("invalid email")
    return f"Welcome, {user['email']}"
