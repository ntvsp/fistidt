from django.shortcuts import render
from requests import Response
from rest_framework.views import APIView
from rest_framework import status
from cart.models import Cart, CartItem
from cart.serializers import CartSerializers,CartItemSerializer
from rest_framework.decorators import  permission_classes
from rest_framework.permissions import IsAuthenticated
from product.models import Product

@permission_classes([IsAuthenticated])
class AddToCartAPIView(APIView):
    def post(self, request, pk):
        try:
            # print(request.user)
            # cart = Cart.objects.filter(user=request.user.id)
            # #  nếu không tìm thấy cart thì tạo mới cart, gắn user= request.user
            # if(not cart.exists()):
            #     serializer = CartSerializers(data={"user":request.user.id})
            #     if serializer.is_valid():
            #         serializer.save()
            #         cart = serializer.data
            #     pass
            # # product = Product.objects.get(pk=pk)
            
            # # # Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng hay chưa
            # # cart_item = CartItem.objects.filter(cart=cart, product=product).first()
            
            # # if cart_item:
            # #     # Nếu sản phẩm đã tồn tại trong giỏ hàng, tăng số lượng lên 1
            # #     cart_item.quantity += 1
            # #     cart_item.save()
            # # else:
            # #     # Nếu sản phẩm chưa tồn tại trong giỏ hàng, tạo một mục mới
            # #     cart_item = CartItem.objects.create(cart=cart, product=product, quantity=1)
            
            # # serializer = CartItemSerializer(cart_item)
            return Response("cart", status=status.HTTP_201_CREATED)
        except  Exception as e:
            return Response(str(e),status=status.HTTP_404_NOT_FOUND)