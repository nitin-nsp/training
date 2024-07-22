from django.db import models

class Subject(models.Model):
    name = models.CharField(max_length=50)

class Student(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    roll_number = models.IntegerField()
    phone_number = models.CharField(max_length=15) 
    standard = models.CharField(max_length=50)

class Attendance(models.Model):
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    on_date = models.DateField()
