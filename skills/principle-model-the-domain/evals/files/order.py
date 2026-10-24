class Order:
    def __init__(self, order_id):
        self.order_id = order_id
        self.is_placed = True
        self.is_paid = False
        self.is_shipped = False
        self.is_delivered = False
        self.is_cancelled = False

    def pay(self):
        if self.is_cancelled or self.is_paid:
            raise ValueError("cannot pay")
        self.is_paid = True

    def ship(self):
        if not self.is_paid or self.is_cancelled or self.is_shipped:
            raise ValueError("cannot ship")
        self.is_shipped = True

    def deliver(self):
        if not self.is_shipped or self.is_delivered:
            raise ValueError("cannot deliver")
        self.is_delivered = True

    def cancel(self):
        if self.is_shipped or self.is_delivered:
            raise ValueError("cannot cancel")
        self.is_cancelled = True
        self.is_placed = False

    def label(self):
        if self.is_cancelled:
            return "cancelled"
        if self.is_delivered:
            return "delivered"
        if self.is_shipped:
            return "shipped"
        if self.is_paid:
            return "paid"
        return "placed"
