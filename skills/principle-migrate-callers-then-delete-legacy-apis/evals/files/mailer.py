import smtplib
from email.message import EmailMessage

SMTP_HOST = "localhost"
FROM_ADDR = "noreply@example.com"


def send_email(to, subject, body):
    """Send a plain-text email. Used by signup and billing."""
    msg = EmailMessage()
    msg["From"] = FROM_ADDR
    msg["To"] = to
    msg["Subject"] = subject
    msg.set_content(body)
    with smtplib.SMTP(SMTP_HOST) as smtp:
        smtp.send_message(msg)
