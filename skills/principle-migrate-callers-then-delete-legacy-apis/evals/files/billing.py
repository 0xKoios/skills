from mailer import send_email


def send_invoice(customer, invoice):
    send_email(
        customer["email"],
        f"Invoice {invoice['number']}",
        f"Your invoice for {invoice['amount']:.2f} is due on {invoice['due']}.",
    )


def send_receipt(customer, payment):
    send_email(customer["email"], "Payment received", f"We received {payment['amount']:.2f}. Thank you.")
