
from rest_framework import serializers
from authentication.serializers import UserSerializer
from product.serializers import ProductSerializer
from cart.models import Cart,CartItem

class CartItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer()

    class Meta:
        model = CartItem
        fields = ('quantity','product')

class CartSerializers(serializers.ModelSerializer):
    items = CartItemSerializer(many=True, read_only=True)
    user = UserSerializer()
    class Meta:
        model = Cart
        fields = '__all__'
