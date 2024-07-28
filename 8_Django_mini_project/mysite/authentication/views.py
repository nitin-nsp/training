import json

from django.shortcuts import render, redirect
from django.views import View
from django.urls import reverse
from django.contrib import auth
from django.core.mail import send_mail
from django.core.mail import EmailMessage
from django.http import JsonResponse

from django.contrib import messages
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.contrib.sites.shortcuts import get_current_site
# from django.utils.encoding import force_bytes, force_text, DjangoUnicodeDecodeError

from django.contrib.auth.models import User

# from .utils import account_activation_token

class EmailValidationView(View):
    def post(self, request):
        data = json.loads(request.body)
        email = data['email']
        if not validate_email(email):
            return JsonResponse({'email_error': 'Email is invalid'}, status=400)
        if User.objects.filter(email=email).exists():
            return JsonResponse({'email_error': 'sorry email in use,choose another one '}, status=409)
        return JsonResponse({'email_valid': True})
   
class UsernameValidationView(View):
    def post(self, request):
        data = json.loads(request.body)
        username = data['username']
        if not str(username).isalnum():
            return JsonResponse({'username_error': 'username should only contain alphanumeric characters'}, status=400)
        if User.objects.filter(username=username).exists():
            return JsonResponse({'username_error': 'sorry username in use,choose another one '}, status=409)
        return JsonResponse({'username_valid': True})

class RegistrationView(View):
    def get(self,request):
        return render(request,'authentication/register.html')
    def post(self,request):
        """ 
        get user data,validate, create user

        """
        username=request.POST['username']
        email=request.POST['email']
        password=request.POST['password']

        context={'fieldValues':request.POST}

        if not User.objects.filter(username=username).exists():
            if not User.objects.filter(email=email).exists():
                if len(password)<6:
                    messages.error(request,'Too Short Password')
                    return render(request,'authentication/register.html',context)
                
                user=User.objects.create_user(username=username,email=email)

                user.set_password(password)
                user.is_active=False
                user.save()

                #  get url or website and send email 
                origin_url=get_current_site(request)
                email_body={
                    'user':user,
                    'domain':origin_url.domain,
                    'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                    'token': account_activation_token.make_token(user),
                }
                link=reverse('activate',kwargs={'uidb64':email_body['uid'],'token':email_body['token']})
                email_subject='Acitvate your account'

                activate_url = 'http://'+origin_url.domain+link

                email = EmailMessage(
                    email_subject,
                    'Hi '+user.username + ', Please the link below to activate your account \n'+activate_url,
                    'noreply@semycolon.com',
                    [email],
                )
                email.send(fail_silently=False)
                messages.success(request, 'Account successfully created')
                return render(request, 'authentication/register.html')

        return render(request,'authentication/register.html')


       
        



        
