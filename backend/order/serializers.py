
from rest_framework import serializers
from authentication.serializers import UserSerializer
from .models import Order, OrderItem
from product.serializers import ProductNoUserSerializer

class OrdertemSerializer(serializers.ModelSerializer):
    product = ProductNoUserSerializer()

    class Meta:
        model = OrderItem
        fields = ('quantity','product','purchased_price')

class OrderSerializers(serializers.ModelSerializer):
    order_items = OrdertemSerializer(many=True, read_only=True)
    class Meta:
        model = Order
        fields = ('order_items',)
