from asyncio import AbstractServer
from django.db import models

# Create your models here.

class AppUser(AbstractServer):
    balance = models.IntegerField()
    date_of_birth = models.DateField()
    def __str__(self):
        return self.username