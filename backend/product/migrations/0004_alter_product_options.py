# Generated by Django 4.0 on 2023-06-04 16:23

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0003_rename_author_product_owner'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='product',
            options={'ordering': ['-id']},
        ),
    ]
