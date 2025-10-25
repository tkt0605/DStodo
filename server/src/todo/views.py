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

from .models import (
    CustomUser,
    TodoItem
)
# Create your views here.
def index(request):
    return render(request, "index.html")
class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all()
    permission_classes = [AllowAny]
    
class TodoItemViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
