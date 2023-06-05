from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .pagination import CustomPagination
from product.filter import ProductFilter
from .models import Product
from .serializers import GetProductSerializer, ProductSerializer
from drf_yasg.utils import swagger_auto_schema
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required 
from drf_yasg import openapi

class ProductAPIView(APIView):
    def get(self, request):
        products = ProductFilter(request.GET, queryset=Product.objects.all())
        paginator = CustomPagination()
        paginated_products = paginator.paginate_queryset(products.qs, request)
        serializer = GetProductSerializer(paginated_products, many=True)
        return paginator.get_paginated_response(serializer.data)
    
    @swagger_auto_schema( 
        request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING),
            'price': openapi.Schema(type=openapi.TYPE_STRING),
            'description': openapi.Schema(type=openapi.TYPE_STRING),
            'image': openapi.Schema(type=openapi.TYPE_FILE),
        },
        required=['name'],
    ),
    responses={
        201: 'Created',
        400: 'Bad Request',
    },)
    @method_decorator(permission_classes([IsAuthenticated]))
    def post(self, request):
        if  request.user.is_authenticated:
            try:
                mutable_data = request.data.copy()
                mutable_data['owner'] = request.user.id
                serializer = ProductSerializer(data=mutable_data)
                if serializer.is_valid():
                    serializer.save()
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            except Exception as e:
                return Response(str(e), status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        return Response('Unauthorized',status=status.HTTP_401_UNAUTHORIZED)

@permission_classes([IsAuthenticated])
class ProductDetailAPIView(APIView):
    def get(self,request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = ProductSerializer(product)
        return Response(serializer.data)

    @swagger_auto_schema( 
        request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING),
            'price': openapi.Schema(type=openapi.TYPE_STRING),
            'description': openapi.Schema(type=openapi.TYPE_STRING),
            'image': openapi.Schema(type=openapi.TYPE_FILE),
        },
        required=['name'],
    ),
    responses={
        200: 'ok',
        400: 'Bad Request',
    },)
    def put(self, request, pk):
        try:
            product = Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = ProductSerializer(product, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            product = Product.objects.get(pk=pk, owen = request.user)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        product.delete()
        return Response('deleted',status=status.HTTP_204_NO_CONTENT,)