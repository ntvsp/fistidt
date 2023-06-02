from django.db import models

class Cart(models.Model):
    user = models.ForeignKey('authentication.AppUser', related_name='user', on_delete=models.CASCADE)
    products = models.ForeignKey('product.Product', related_name='prod', on_delete=models.CASCADE)