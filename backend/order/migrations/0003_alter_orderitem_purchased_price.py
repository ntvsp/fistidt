# Generated by Django 4.0 on 2023-06-05 03:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0002_alter_orderitem_purchased_price'),
    ]

    operations = [
        migrations.AlterField(
            model_name='orderitem',
            name='purchased_price',
            field=models.DecimalField(decimal_places=2, max_digits=10, null=True),
        ),
    ]
