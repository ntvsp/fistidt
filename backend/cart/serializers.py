
from rest_framework import serializers
from authentication.models import AppUser
from cart.models import Cart,CartItem

class CartSerializers(serializers.ModelSerializer):

    class Meta:
        model = Cart
        fields = '__all__'

class CartItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItem
        fields = '__all__'