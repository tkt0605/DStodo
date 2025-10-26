from django.shortcuts import render
from django.contrib.auth import get_user_model
from rest_framework import viewsets, permissions
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.parsers import MultiPartParser, FormParser
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
    serializer_class = CustomUserSerializer
    parser_classes = [MultiPartParser, FormParser]
    def get_permissions(self):
        if self.action in ["create", "list"]:
            self.permission_classes = [AllowAny]
        return super().get_permissions()
    def get_serializer_class(self):
        if self.action == "retrieve":
            return CustomUserDetairsSerializer
        return CustomUserSerializer
    @action(detail=False, methods=["get"], permission_classes=[IsAuthenticated])
    def me(self, request):
        user = request.user
        serializer = self.get_serializer(user)
        return Response(serializer.data)
    @action(detail=False, methods=["post"], permission_classes=[IsAuthenticated])
    def upload_avatar(self, request):
        user = request.user
        serializer = self.get_serializer(user, data=request.data, partial = True)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, status=200)
        return Response(serializer.errors, status=400)
        

class TodoItemViewSet(viewsets.ModelViewSet):
    queryset = TodoItem.objects.all()
    serializer_class = TodoItemSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        if self.action in ["list", "create"]:
            self.permission_classes = [AllowAny]
        return super().get_permissions()
    def get_serializer_class(self):
        if self.action == "retrieve":
            return TodoItemReadSerializer
        return TodoItemSerializer
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    