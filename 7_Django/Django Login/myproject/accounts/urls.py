from django.urls import path
from .views import CustomLoginView, profile

urlpatterns = [
    path('login/', CustomLoginView.as_view(), name='login'),
    path('profile/', profile, name='profile'),
]
