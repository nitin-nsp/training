from django.shortcuts import render
from django.http import HttpResponse

from .models import Question,Choice



def index(request):
    return HttpResponse('hello ')

def getFun(request):
    latest_question_list=Question.objects.order_by('-pub_date')[:5]
    context={'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)

def choices(request):
    choices_available =Choice.objects
    return render(request, 'polls/choices.html',{'list_choice':choices_available})

   
