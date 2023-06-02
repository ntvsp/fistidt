import django_filters
from .models import Product

class ProductFilter(django_filters.FilterSet):
    author = django_filters.NumberFilter(field_name='author', lookup_expr='exact')
    class Meta:
        model = Product
        fields = ['author']
