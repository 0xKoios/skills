from decimal import Decimal, ROUND_HALF_UP

TAX_RATE = Decimal("0.07")


def line_total(unit_price: Decimal, qty: int) -> Decimal:
    return unit_price * qty


def order_subtotal(lines: list[tuple[Decimal, int]]) -> Decimal:
    return sum((line_total(p, q) for p, q in lines), Decimal("0"))


def order_total(lines: list[tuple[Decimal, int]]) -> Decimal:
    subtotal = order_subtotal(lines)
    total = subtotal + subtotal * TAX_RATE
    return total.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)


def format_price(amount: Decimal) -> str:
    return f"${amount:,.2f}"
