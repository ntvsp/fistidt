
from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.

class AppUser(AbstractUser):
    balance = models.IntegerField(default=0)
    date_of_birth = models.DateField(null=True)
    def __str__(self):
        return self.username