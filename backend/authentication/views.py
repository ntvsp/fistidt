# authentication/views.py

from argon2 import PasswordHasher
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from authentication.models import AppUser
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .serializers import UserSerializer
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi



class RegisterView(APIView):
    @swagger_auto_schema( 
        request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'username': openapi.Schema(type=openapi.TYPE_STRING),
            'password': openapi.Schema(type=openapi.TYPE_STRING),
            'password2': openapi.Schema(type=openapi.TYPE_STRING),

        },
        required=['username', 'password','password2'],
    ),
    responses={
        201: 'Created',
        400: 'Bad Request',
    },)
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh_token': str(refresh),
                'access_token': str(refresh.access_token),
            })
        return Response(serializer.errors, status=400)


class LoginView(APIView):
    @swagger_auto_schema( 
        request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'username': openapi.Schema(type=openapi.TYPE_STRING),
            'password': openapi.Schema(type=openapi.TYPE_STRING),

        },
        required=['username', 'password'],
    ),
    responses={
        200: 'Success',
        401: 'Invalid credentials',
    })
    def post(self, request):
        username = request.data.get('username')
        re_password = request.data.get('password')
        # ph = PasswordHasher()
        # user = AppUser.objects.filter(username=username).first()
        # password_hash = PasswordHasher().hash(re_password)
        user = authenticate(username=username, password=re_password)
        if user:
            refresh = RefreshToken.for_user(user)
            serializer = UserSerializer(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'user': serializer.data
            }, status=200)
        else:
            return Response({'error': 'Invalid credentials'}, status=401)
        
@permission_classes([IsAuthenticated])
class UserView(APIView):
    def get(self, request):
        user = request.user
        if user:
            serializer = UserSerializer(user)
            return Response({
                'user': serializer.data
            }, status=200)
        else:
            return Response({'error': 'Invalid credentials'}, status=401)
