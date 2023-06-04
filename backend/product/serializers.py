from rest_framework import serializers

from authentication.serializers import UserSerializer
from .models import Product

class GetProductSerializer(serializers.ModelSerializer):
    owner = UserSerializer()

    class Meta:
        model = Product
        fields = '__all__'

class ProductNoUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = Product
        fields = ('id','name')

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'
        