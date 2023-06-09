# Generated by Django 4.0 on 2023-06-04 16:23

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('authentication', '0002_alter_appuser_balance_alter_appuser_date_of_birth'),
        ('cart', '0002_alter_cartitem_product'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cart',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='cart', to='authentication.appuser'),
        ),
    ]
