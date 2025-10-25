from django.db import models

# Create your models here.
from typing import Iterable
from django.db import models
from django.contrib.auth.models import AbstractUser, AbstractBaseUser, AnonymousUser, BaseUserManager, Permission, PermissionsMixin, Group
from django.utils import timezone
from django.conf import settings
import uuid
from config.settings import AUTH_USER_MODEL
from django.utils.translation import gettext_lazy as _
from django.utils.encoding import force_str
from django.db.models.signals import post_save, post_delete, m2m_changed
from django.dispatch import receiver
from datetime import timedelta
import datetime
from uuid import UUID

def generate_avatar_url(email):
    """メールアドレスを基にアバター URL を生成"""
    seed = email.split("@")[0] if email else "default"
    return f"https://api.dicebear.com/7.x/identicon/svg?seed={seed}"
class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("メールアドレスが必要です。")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user
    def create_staffuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", False)
        return self.create_user(email, password, **extra_fields)
    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        return self.create_user(email, password, **extra_fields)
class CustomUser(AbstractBaseUser, PermissionsMixin):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    avatar = models.URLField(blank=True, null=True)
    icon = models.ImageField(upload_to="avatars/", null=True, blank=True, default="None")
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=30, blank=True)
    last_name = models.CharField(max_length=30, blank=True)
    nickname = models.CharField(max_length=150, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(default=timezone.now)
    objects = CustomUserManager()
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []
    def save_avatar(self, *args, **kwargs):
        if not self.avatar:
            self.avatar = generate_avatar_url(self.email)
        super().save(*args, **kwargs)
    def __str__(self):
        return self.email
    class Meta:
        verbose_name = "ユーザー"
        verbose_name_plural = "ユーザー一覧"
class TodoItem(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="todo_user")
    title = models.CharField(max_length=100)
    nemo = models.TextField(blank=True)
    is_completed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
    class Meta:
        verbose_name = "ToDoアイテム"
        verbose_name_plural = "ToDoアイテム一覧"