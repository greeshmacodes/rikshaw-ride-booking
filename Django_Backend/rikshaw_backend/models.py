from django.contrib.auth.models import User
from django.db import models

# Create your models here.
class loginn_tb(models.Model):
    username=models.CharField(max_length=50)
    password=models.CharField(max_length=50)
    usertype=models.CharField(max_length=50)

class Driver_tb(models.Model):
    name=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    photo=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    proof=models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    latitude=models.CharField(max_length=100)
    longitude=models.CharField(max_length=100)
    availability=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(User,on_delete=models.CASCADE)


class User_tb(models.Model):
    name=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    latitude=models.CharField(max_length=100)
    longitude=models.CharField(max_length=100)
    status=models.CharField(max_length=100,default="pending")
    LOGIN=models.ForeignKey(User, on_delete=models.CASCADE)

class Review_tb(models.Model):
    USER= models.ForeignKey(User_tb, on_delete=models.CASCADE)
    DRIVER=models.ForeignKey(Driver_tb, on_delete=models.CASCADE)
    rating=models.CharField(max_length=100)
    review=models.CharField(max_length=100)
    date=models.CharField(max_length=100)

class Report_tb(models.Model):
    USER=models.ForeignKey(User_tb, on_delete=models.CASCADE)
    DRIVER=models.ForeignKey(Driver_tb, on_delete=models.CASCADE)
    date=models.CharField(max_length=100)
    report_reason=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class Chat_tb(models.Model):
    USER = models.ForeignKey(User_tb, on_delete=models.CASCADE)
    DRIVER = models.ForeignKey(Driver_tb, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    type = models.CharField(max_length=100)
    messages=models.CharField(max_length=100)

class Complaint_tb(models.Model):
    USER = models.ForeignKey(User_tb, on_delete=models.CASCADE)
    complaint= models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    reply= models.CharField(max_length=100)
    replydate= models.CharField(max_length=100)

class Vehicle_tb(models.Model):
    DRIVER = models.ForeignKey(Driver_tb, on_delete=models.CASCADE)
    photo = models.CharField(max_length=100)
    model = models.CharField(max_length=100)
    rc= models.CharField(max_length=100)
    license= models.CharField(max_length=100)
    no_of_seat=models.CharField(max_length=100)

class Request_tb(models.Model):
    USER = models.ForeignKey(User_tb, on_delete=models.CASCADE)
    DRIVER= models.ForeignKey(Driver_tb, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    from_latitude= models.CharField(max_length=100)
    from_longitude= models.CharField(max_length=100)
    to_latitude=models.CharField(max_length=100)
    to_longitude=models.CharField(max_length=100)
    amount = models.CharField(max_length=100)
    extra_charge=models.CharField(max_length=100)
    payment_status=models.CharField(max_length=100)
    share=models.CharField(max_length=200)
    status=models.CharField(max_length=100)
    ride_status=models.CharField(max_length=200,default='pending')

class Share_tb(models.Model):
    USER = models.ForeignKey(User_tb, on_delete=models.CASCADE)
    RIDE_REQUEST= models.ForeignKey(Request_tb, on_delete=models.CASCADE)
    status = models.CharField(max_length=100)
    amount= models.CharField(max_length=100)
    date=models.CharField(max_length=100)


