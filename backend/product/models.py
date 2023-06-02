from django.db import models

class Product(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)
    price = models.DecimalField(max_digits=8, decimal_places=2, null=True)
    author = models.ForeignKey('authentication.AppUser', related_name='prod', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='product_images/', null=True)

    def __str__(self):
        return self.name