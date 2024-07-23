from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="polls-index"),
    path("questions",views.getFun, name="get-5-question"),
    path("choices",views.choices,name="get-choices")
]