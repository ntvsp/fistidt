from django.db import models

class Product(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    price = models.DecimalField(max_digits=8, decimal_places=2)
    author = models.ForeignKey('auth.User', related_name='movies', on_delete=models.CASCADE)

    def __str__(self):
        return self.name