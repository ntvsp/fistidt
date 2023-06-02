from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from product.filter import ProductFilter
from .models import Product
from .serializers import ProductSerializer



class ProductAPIView(APIView):
    def get(self, request):
        f = ProductFilter(request.GET, queryset=Product.objects.all())
        products = Product.objects.all()
        serializer = ProductSerializer(f.qs, many=True)
        return Response(serializer.data)
    
    @permission_classes([IsAuthenticated])
    def post(self, request):
        try:
            request.data._mutable = True
            request.data['owner'] = request.user.id
            request.data._mutable = False
            serializer = ProductSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response(str(e), status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class ProductDetailAPIView(APIView):
    def get(self,request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = ProductSerializer(product)
        return Response(serializer.data)

    def put(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = ProductSerializer(product, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        product.delete()
        return Response('deleted',status=status.HTTP_204_NO_CONTENT, )
