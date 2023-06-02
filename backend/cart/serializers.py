
from rest_framework import serializers
from authentication.models import AppUser
from cart.models import Cart

class CartSerializers(serializers.ModelSerializer):

    class Meta:
        model = Cart
        fields = '__all__'

    def create(self, validated_data):
        cart = Cart.objects.create(**validated_data)
        cart.save
        return cart