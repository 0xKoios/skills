class Cart:
    """A shopping cart. Orders of 100.00 or more get 10% off."""

    def __init__(self):
        self._lines = []

    def add(self, sku, price, qty=1):
        if qty < 1:
            raise ValueError("qty must be at least 1")
        self._lines.append((sku, price, qty))

    def _subtotal(self):
        return sum(price * qty for _, price, qty in self._lines)

    def _discount(self, subtotal):
        return subtotal * 0.10 if subtotal >= 100 else 0

    def total(self):
        subtotal = self._subtotal()
        return round(subtotal - self._discount(subtotal), 2)
