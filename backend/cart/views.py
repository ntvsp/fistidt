from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from cart.models import Cart, CartItem
from cart.serializers import CartSerializers,CartItemSerializer
from rest_framework.decorators import  permission_classes
from rest_framework.permissions import IsAuthenticated
from product.models import Product

@permission_classes([IsAuthenticated])
class AddToCartAPIView(APIView):
    def put(self, request, pk):
        try:
            cart = Cart.objects.filter(user=request.user).first()
            product = Product.objects.get(pk=pk)
            cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product)
            cart_item.quantity += 1
            cart_item.save()
            
            serializer = CartSerializers(cart)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response(str(e), status=status.HTTP_404_NOT_FOUND)