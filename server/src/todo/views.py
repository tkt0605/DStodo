from django.shortcuts import render
from django.contrib.auth import get_user_model
from rest_framework import viewsets, permissions
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.views import APIView
from rest_framework.generics import (
    ListCreateAPIView,
    RetrieveUpdateDestroyAPIView,
    CreateAPIView
)
from rest_framework_simplejwt.tokens import RefreshToken

from .serializers import (
    CustomUserSerializer,
    CustomUserDetairsSerializer,
    TodoItemSerializer,
    TodoItemReadSerializer,
    RegisterSerializer,
    LoginSerializer,
    LogoutSerializer
)
from .models import (
    CustomUser,
    TodoItem
)
from typing import cast
# Create your views here.
def index(request):
    return render(request, "index.html")
class RegisterAPI(CreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterSerializer
    queryset = CustomUser.objects.all()
class LoginAPI(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        serilaizer = LoginSerializer(data = request.data, context = {"request": request})
        if serilaizer.is_valid(raise_exception=True):
            user = cast(CustomUser, serilaizer.validated_data)
            refresh = RefreshToken.for_user(user)
            return Response({
                "access": str(refresh.access_token),
                "refresh": str(refresh)
            })
class LogoutAPI(APIView):
    permission_classes = [IsAuthenticated]
    def post(self, request):
        serializer = LogoutSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"detail": f"User {request.user.email} Logged out successfully"})
class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all()
    permission_classes = [AllowAny]
    
class TodoItemViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
