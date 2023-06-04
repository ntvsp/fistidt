from django.db import models
from product.models import Product
from cart.models import CartItem

class Order(models.Model):
    user = models.ForeignKey('authentication.AppUser', related_name='orders', on_delete=models.CASCADE,)

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    purchased_price = models.DecimalField(max_digits=10, decimal_places=2)

    @classmethod #this is factory contructor
    def create_from_cart_item(cls, cartItem : CartItem, order:Order):
        return cls(product=cartItem.product, purchased_price=cartItem.product.price,quantity=cartItem.quantity, order=order )
