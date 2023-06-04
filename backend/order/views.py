from django.shortcuts import render
from rest_framework.decorators import  permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from .serializers import OrderSerializers
from .models import Order, OrderItem
from product.models import Product
from cart.models import Cart, CartItem
from cart.serializers import CartSerializers
# Create your views here.
@permission_classes([IsAuthenticated])
class CreateOrder(APIView):
    def post(self, request):
        try:
            #create order
            print("order creating....")
            cart = Cart.objects.get(user=request.user)
            # map cart_items to order_items
            cart_items = cart.items.all()
            if cart_items.count() < 1:
                return Response('Cart is not empty', status=status.HTTP_400_BAD_REQUEST)
            order = Order.objects.create(user=request.user)
            for order_item in cart_items:
                order_item = OrderItem.create_from_cart_item(order_item, order)
                order_item.save()
            # delete all cartItem
            cart.items.all().delete()
            # return order
            serializer = OrderSerializers(order)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response(str(e), status=status.HTTP_404_NOT_FOUND)

@permission_classes([IsAuthenticated])
class OrderHistory(APIView): 
    def get(self, request):
        try:
            orders = Order.objects.filter(user=request.user)
            serializer = OrderSerializers(orders,many=True)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response(str(e), status=status.HTTP_404_NOT_FOUND)