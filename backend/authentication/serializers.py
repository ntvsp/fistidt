
from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from authentication.models import AppUser
from argon2 import PasswordHasher
from cart.models import Cart
class UserSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(write_only=True)

    class Meta:
        model = AppUser
        fields = ('username', 'email', 'first_name','last_name' ,'password2' , 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        # validated_data['password'] = make_password(validated_data['password'])
        validated_data['password'] = PasswordHasher().hash(validated_data['password'])
        user = AppUser.objects.create(**validated_data)
        Cart.objects.create(user=user)
        return user

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didnt match."})
        password2 = attrs.pop('password2', None)
        return attrs
