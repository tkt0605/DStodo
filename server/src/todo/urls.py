from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from rest_framework import routers
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenBlacklistView
)
from todo import views
from views import (
    LoginAPI,
    RegisterAPI,
    LogoutAPI,
    CustomUserViewSet,
    TodoItemViewSet
)
router = routers.DefaultRouter()
router.register(r"users", CustomUserViewSet, basename="user")
urlpatterns = [
    path('token/', TokenObtainPairView.as_view(), name='token-login'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token-refresh'),
    path('token/logout/', TokenBlacklistView.as_view(), name='token-logout'),
    path('login/', LoginAPI.as_view(), name='login'),
    path('register/', RegisterAPI.as_view(), name="register"),
    path('logout/', LogoutAPI.as_view(), name='logout'),
    path('', include(router.urls))
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)