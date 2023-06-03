from django.db import models
from product.models import Product

class Cart(models.Model):
    user = models.ForeignKey('authentication.AppUser', related_name='user', on_delete=models.CASCADE,)

class CartItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)