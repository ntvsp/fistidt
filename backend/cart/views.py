from django.shortcuts import render
from requests import Response
from rest_framework.views import APIView
from rest_framework import status
from cart.serializers import CartSerializers

from product.models import Product

# Create your views here.
class CartAddProduct(APIView):
    def post(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        data = {}
        data['owner'] = request.user.id
        data['product'] = pk
        serializer = CartSerializers(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)