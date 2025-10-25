from rest_framework import serializers
from .models import (
    CustomUser,
    CustomUserManager,
    TodoItem
)
from rest_framework_simplejwt.tokens import RefreshToken
from django.db import IntegrityError, transaction
import os
from urllib.parse import unquote
from django.contrib.auth import get_user_model
User = get_user_model()
from typing import cast

user_manager = cast(CustomUserManager, CustomUser.objects)
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    class Meta:
        model = CustomUser
        fields = ('id', 'email', 'password')
    def create(self, validated_data):
        user = user_manager.create_user(
            email=validated_data['email'],
            password=validated_data['password'],
        )
        return user
class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True, allow_blank=False)
    password = serializers.CharField(write_only=True, reqiured = True, allow_blank=False)

    def validate(self, data):
        email = data['email']
        password = data['passwoed']
        user = User.objects.filter(email=email).first()
        if not user:
            raise serializers.ValidationError("User with this email does not exist.")
        elif user and user.check_password(password):
            return user
        else:
            raise serializers.ValidationError(('メールアドレスまたはパスワードが正しくありません。'))
class LogoutSerializer(serializers.Serializer):
    refresh = serializers.CharField()
    def validate(self, data):
        self.token = data['refresh']
        return data
    def save(self, **kwargs):
        RefreshToken(self.token).blacklist()
class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'email', 'avater', 'first_name', 'last_name', 'nickname')
        read_only_fields = ('id', 'avatar', 'date_joined')
class CustomUserDetairsSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'avater','approver' , 'is_active', 'is_staff', 'is_superuser',]
        read_only_fields = ['id', 'is_active', 'is_staff', 'is_superuser', 'date_joined']

class TodoItemSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(
        slug_field = 'email',
        queryset=CustomUser.objects.all(),
        required=False,
        allow_null=True
    )
    class Meta:
        model = TodoItem
        fields = ('id', 'user', 'title', 'nemo', 'is_completed', 'created_at', 'updated_at')
        read_only_fields = ('id', 'created_at', 'updated_at')
class TodoItemReadSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer(read_only=True)
    class Meta:
        model = TodoItem
        fields = ('id', 'title', 'nemo', 'is_completed', 'created_at', 'updated_at')
        read_only_fields = ('id', 'created_at', 'updated_at')

