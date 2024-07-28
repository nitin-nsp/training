# accounts/views.py
from django.contrib.auth.views import LoginView
from .forms import CustomAuthenticationForm
from django.http import HttpResponse

class CustomLoginView(LoginView):
    authentication_form = CustomAuthenticationForm
    template_name = 'accounts/login.html'

def profile(request):
    return HttpResponse("Success")