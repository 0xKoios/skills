from mailer import send_email


def welcome(user):
    send_email(user["email"], "Welcome!", f"Hi {user['name']}, thanks for signing up.")
