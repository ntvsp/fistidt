import django_filters
from .models import Product

class ProductFilter(django_filters.FilterSet):
    owner = django_filters.NumberFilter(field_name='owner', lookup_expr='exact')
    class Meta:
        model = Product
        fields = ['owner']
