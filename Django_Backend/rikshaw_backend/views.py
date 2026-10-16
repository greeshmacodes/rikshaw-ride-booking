import datetime
import random
import smtplib

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.models import User, Group
from django.core.files.storage import FileSystemStorage
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from myapp.models import *


def login1(request):
    return render (request,"login.html")

def login1_post(request):
    un=request.POST['textfield']
    pswd=request.POST['textfield2']
    data=authenticate(request,username=un,password=pswd)
    if data is not None:
        login(request,data)
        if data.is_superuser:
            return HttpResponse("<script>alert('success');window.location='/admin_home'</script>")



    return HttpResponse("<script>alert('no user found');window.location='/'</script>")



def change_pass(request):
    return render(request, "admin/change_pass.html")

def change_pass_post(request):
    cp=request.POST['textfield']
    np=request.POST['textfield2']
    conp=request.POST['textfield3']
    if np==conp:
        res=check_password(cp,request.user.password)
        if res:
            user=request.user
            user.set_password(np)
            user.save()
            logout(request)
            return HttpResponse("<script>alert=('loged out');window.location='/' </script>")

    return HttpResponse("<script>alert('invalid')</script>")

def admin_home(request):
    return render(request,"admin/admin_home.html")

def view_drivers(request):
    data=Driver_tb.objects.filter(status="pending")
    return render(request, "admin/view_drivers.html", {'data':data})

def approve_driver(request,id):
    Driver_tb.objects.filter(id=id).update(status="approved")
    return HttpResponse("<script>alert('driver approved');window.location='/view_drivers' </script>")

def reject_drvers(request,id):
    Driver_tb.objects.filter(id=id).update(status="reject")
    return HttpResponse("<script>alert('driver rejected');window.location='/view_drivers' </script>")

def view_approved_driver(request):
    data=Driver_tb.objects.filter(status__in=["approved","blocked"])
    return render(request, "admin/view_approved_driver.html", {'data':data})

def block_driver(request,id):
    Driver_tb.objects.filter(id=id).update(status='blocked')
    return HttpResponse("<script>alert('driver blocked');window.location='/view_approved_driver' </script>")

def unblock_driver(request,id):
    Driver_tb.objects.filter(id=id).update(status='approved')
    return HttpResponse("<script>alert('driver unblocked');window.location='/view_approved_driver' </script>")


def view_reviews(request):
    rew=Review_tb.objects.all()
    return render(request,"admin/view_reviews.html",{'data':rew})


def view_user(request):
    data=User_tb.objects.all()
    return render(request,"admin/view_users.html",{'data':data})


def block_user(request,id):
    User_tb.objects.filter(id=id).update(status='blocked')
    return HttpResponse("<script>alert('user blocked');window.location='/view_users' </script>")

def unblock_user(request,id):
    User_tb.objects.filter(id=id).update(status='approved')
    return HttpResponse("<script>alert('user unblocked');window.location='/view_users' </script>")



def view_complaints(request):
    data=Complaint_tb.objects.all()
    return render(request,"admin/view_complaints.html",{'data':data})

def view_reports(request):
    data=Report_tb.objects.all()
    return render(request,"admin/view_report.html",{'data':data})

def send_reply(request,id):
    return render(request,"admin/send_reply.html")

def send_reply_post(request,id):
    reply=request.POST["textarea"]
    Complaint_tb.objects.get(id=id).update(reply=reply,replydate=datetime.datetime.now().strftime("%Y-%m-%d"))
    return HttpResponse("<script>alert('reply sent succsessfully');window.location='/view_reply.html' </script>")


#-----------------driver----------------


from django.http import JsonResponse
from django.contrib.auth import authenticate, login

def userlogin(request):
    username = request.POST.get('usernam')
    password = request.POST.get('password')

    user = authenticate(request, username=username, password=password)

    if user is None:
        return JsonResponse({'status': 'invalid', 'message': 'Invalid username or password'})

    if user.groups.filter(name="driver").exists():
        try:
            driver = Driver_tb.objects.get(LOGIN=user.id)
        except Driver_tb.DoesNotExist:
            return JsonResponse({'status': 'invalid', 'message': 'Driver record not found'})

        if driver.status == "approved":
            login(request, user)
            return JsonResponse({
                'status': 'ok',
                'type': 'driver',
                'did': str(driver.id)
            })

        elif driver.status == "pending":
            return JsonResponse({'status': 'invalid', 'message': 'Driver approval pending'})

        elif driver.status == "reject":
            return JsonResponse({'status': 'reject', 'message': 'Driver rejected by admin'})

        elif driver.status == "blocked":
            return JsonResponse({'status': 'invalid', 'message': 'Driver blocked by admin'})

        return JsonResponse({'status': 'invalid', 'message': 'Invalid driver status'})

    elif user.groups.filter(name="user").exists():
        try:
            usr = User_tb.objects.get(LOGIN=user.id)
        except User_tb.DoesNotExist:
            return JsonResponse({'status': 'invalid', 'message': 'User record not found'})

        if usr.status == "approved" or usr.status == 'pending':
            login(request, user)
            return JsonResponse({
                'status': 'ok',
                'type': 'user',
                'uid': str(usr.id)
            })

        elif usr.status == "blocked":
            return JsonResponse({'status': 'blocked', 'message': 'User blocked by admin'})

        return JsonResponse({'status': 'invalid', 'message': 'Invalid user status'})

    return JsonResponse({'status': 'invalid', 'message': 'Unauthorized user'})



def driver_register(request):
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    newpass = request.POST['newpass']
    cpass = request.POST['cpass']
    photo = request.FILES['photo']
    proof = request.FILES['proof']
    latitude = request.POST['latitude']
    logitude = request.POST['longitude']
    print(name,email,latitude,logitude)


    if User.objects.filter(username=email).exists():
        return JsonResponse({'status': 'Exist'})
    if newpass == cpass:
        fs = FileSystemStorage()
        photo = fs.save(photo.name,photo)
        path = fs.url(photo)
        proof =fs.save(proof.name,proof)
        path1 = fs.url(proof)
        ob = User()
        ob.username = email
        ob.password = make_password(newpass)
        ob.save()
        ob.groups.add(Group.objects.get(name='driver'))
        obj = Driver_tb()
        obj.name = name
        obj.email=email
        obj.phone=phone
        obj.photo=path1
        obj.proof=path
        obj.latitude = latitude
        obj.longitude = logitude
        obj.LOGIN_id = ob.id
        obj.status = "pending"
        obj.date = "pending"
        obj.availability = "pending"
        obj.save()
        return JsonResponse({'status':'ok'})
    return JsonResponse({'status':'invalid'})






def user_register(request):
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    newpass = request.POST['newpass']
    cpass = request.POST['cpass']
    latitude = request.POST['latitude']
    logitude = request.POST['longitude']
    print(name,email,latitude,logitude)
    if User.objects.filter(username=email).exists():
        return JsonResponse({'status': 'Exist'})
    if newpass == cpass:
        ob = User()
        ob.username = email
        ob.password = make_password(newpass)
        ob.save()
        ob.groups.add(Group.objects.get(name='user'))
        obj = User_tb()
        obj.name = name
        print(obj.name)
        obj.email=email
        print(obj.email)
        obj.phone=phone
        print(obj.phone)
        obj.latitude=latitude
        print(obj.latitude)
        obj.longitude=logitude
        print(obj.longitude)
        obj.LOGIN_id = ob.id
        print()
        obj.status = "pending"

        obj.date = "pending"
        obj.save()
        return JsonResponse({'status':'ok'})
    return JsonResponse({'status':'invalid'})



def view_availability(request):
    data = Driver_tb.objects.all()
    ar = []
    for i in data:
        ar.append({
            'id':i.id,
            'phone':i.phone,
            'photo':i.photo,
            'proof':i.name,
            'email':i.email,
            'name':i.name,
            'availability':i.availability,
            'status':i.status,
            'date':i.date,

        })
    return JsonResponse({'status':'ok','message':ar})


def view_booking_status(request):
    uid = request.POST['uid']
    data = Request_tb.objects.filter(USER_id=uid)
    ar = []

    for i in data:
        amount = float(i.amount or 0)
        extra = float(i.extra_charge or 0)
        total_amount = round(amount + extra, 2)

        ar.append({
            'id': i.id,
            'dname':i.DRIVER.name,
            'dphone':i.DRIVER.phone,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'd_lat': i.DRIVER.latitude,
            'd_lon': i.DRIVER.longitude,
            'amount': str(amount),
            'extra_charge': str(extra),
            'total_amount': str(total_amount),
            'status': i.status,
        })

    return JsonResponse({'status': 'ok', 'message': ar})

def view_calculate_fair(request):
    data = Request_tb.objects.all()
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude':i.to_latitude,
            'to_longitude':i.to_longitude,
            'amount': i.amount,
            'extra_charge':i.extra_charge,
            'payment_status':i.payment_status,
        })
    return JsonResponse({'status':'ok','message':ar})

def user_view_profile(request):
    uid=request.POST['uid']
    data = User_tb.objects.filter(id=uid)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,

            'name': i.name,
            'email': i.email,
            'phone': i.phone,
        })
    return JsonResponse({'status':'ok','message':ar})



def view_previous_ride(request):
    uid=request.POST['uid']
    data = Request_tb.objects.filter(USER_id=uid)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'amount': i.amount,
            'extra_charge':i.extra_charge,
            'payment_status':i.payment_status,
            'driver':i.DRIVER.id,
            'DRIVER':i.DRIVER.name,
            'status':i.status,
            'ride_status':i.ride_status
        })
    return JsonResponse({'status': 'ok', 'message': ar})




def view_others_ride(request):
    uid=request.POST['uid']
    data = Request_tb.objects.filter(~Q(USER_id=uid), ~Q(status="completed"), share="share").order_by("-id")
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'amount': i.amount,
            'username':i.USER.name,
            'DRIVER':i.DRIVER.name,
            'status':i.status,
        })
    return JsonResponse({'status': 'ok', 'message': ar})


def user_send_other_request(request):
    uid=request.POST['uid']
    rid=request.POST['rid']
    obj=Share_tb()
    obj.USER_id=uid
    obj.RIDE_REQUEST_id=rid
    obj.status="pending"
    obj.amount="pending"
    obj.date=datetime.datetime.now()
    obj.save()
    return JsonResponse({'status': 'ok'})


def user_view_user_request(request):
    bid = request.POST['bid']
    cutoff_time = datetime.timezone.now() - datetime.timedelta(minutes=15)

    data = Share_tb.objects.filter(
        RIDE_REQUEST_id=bid,
        date__gte=cutoff_time
    ).order_by("-id")

    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'name': i.USER.name,
            'email': i.USER.email,
            'phone': i.USER.phone,
            'status': i.USER.status,
        })

    return JsonResponse({'status': 'ok', 'message': ar})


def user_edit_profile(request):
    id=request.POST['id']
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    User_tb.objects.filter(id=id).update(name=name,email=email,phone=phone)
    return JsonResponse({'status':'ok'})


def driver_view_profile(request):
        id = request.POST['did']
        data = Driver_tb.objects.filter(id=id)
        ar = []
        for i in data:
            ar.append({
                'id': i.id,
                'name': i.name,
                'email': i.email,
                'phone': i.phone,
                'proof': i.proof,
                'photo': i.photo,

            })
        return JsonResponse({'status': 'ok', 'message': ar})

def driver_edit_profile(request):
    id=request.POST['id']
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    if 'proof' in request.FILES:
        proof = request.FILES['proof']

        fs=FileSystemStorage()
        path=fs.save(proof.name,proof)
        Driver_tb.objects.filter(id=id).update(proof=fs.url(path))
    if 'photo' in request.FILES:
        photo = request.FILES['photo']

        fss = FileSystemStorage()
        path1 = fss.save(photo.name, photo)
        Driver_tb.objects.filter(id=id).update(photo=fss.url(path1))
    Driver_tb.objects.filter(id=id).update(name=name,email=email,phone=phone)
    return JsonResponse({'status': 'ok'})



def updatelocation(request):
    return JsonResponse({'status': 'ok'})



def user_change_password(request):
    np=request.POST['new_password']
    uid=request.POST['uid']
    lid=User_tb.objects.get(id=uid).LOGIN_id
    print(np,lid,uid)
    User.objects.filter(id=lid).update(password=make_password(np))
    return JsonResponse({'status': 'ok'})


def driver_change_password(request):
    np=request.POST['new_password']
    did=request.POST['did']
    lid=Driver_tb.objects.get(id=did).LOGIN_id
    print(np,lid,did)
    User.objects.filter(id=lid).update(password=make_password(np))
    return JsonResponse({'status': 'ok'})


def add_vehicle(request):
    did=request.POST['did']
    model=request.POST['model']
    nos=request.POST['no_of_seat']
    image=request.FILES['image']
    fs=FileSystemStorage()
    path=fs.save(image.name,image)
    rc=request.FILES['rc']
    fss = FileSystemStorage()
    path1 = fss.save(rc.name, rc)
    license=request.FILES['license']
    fsss = FileSystemStorage()
    path2 = fsss.save(license.name, license)
    obj=Vehicle_tb()
    obj.DRIVER_id=did
    obj.photo=fs.url(path)
    obj.model=model
    obj.no_of_seat=nos
    obj.rc=fss.url(path1)
    obj.license=fss.url(path2)
    obj.save()
    return JsonResponse({'status':'ok'})

def edit_vehicle_details(request):
    id=request.POST['id']
    if 'photo' in request.FILES:
        photo=request.FILES['photo']
        fs = FileSystemStorage()
        path = fs.save(photo.name, photo)
        Vehicle_tb.objects.filter(id=id).update(photo=fs.url(path))
    if 'rc' in request.FILES:
        rc = request.FILES['rc']
        fss = FileSystemStorage()
        path1 = fss.save(rc.name, rc)
        Vehicle_tb.objects.filter(id=id).update(rc=fss.url(path1))
    if 'license' in request.FILES:
        license = request.FILES['license']
        fsss = FileSystemStorage()
        path2 = fsss.save(license.name, license)
        Vehicle_tb.objects.filter(id=id).update(license=fsss.url(path2))
    model = request.POST['model']
    nos = request.POST['no_of_seat']
    Vehicle_tb.objects.filter(id=id).update(no_of_seat=nos,model=model)
    return JsonResponse({'status':'ok'})




def view_vehicle_details(request):
    data = Vehicle_tb.objects.all()
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'model': i.model,
            'no_of_seat':i.no_of_seat,
            'photo':i.photo,
            'rc':i.rc,
            'license':i.license,


        })
    return JsonResponse({'status':'ok','message':ar})





def  view_user_review(request):
    id=request.POST['did']
    data = Review_tb.objects.filter(DRIVER_id=id)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'user':i.USER.name,
            'email': i.USER.email,
            'rating': i.rating,
            'review':i.review,
            'date':i.date,


        })
    return JsonResponse({'status':'ok','message':ar})
#
# def  view_user_review(request):
#     data = Review_tb.objects.all()
#     ar = []
#     for i in data:
#         ar.append({
#             'id': i.id,
#             'DRIVER':i.USER.DRIVER,
#             'rating': i.USER.rating,
#             'review':i.USER.review,
#             'date':i.USER.date,
#
#
#         })
#     return JsonResponse({'status':'ok','message':ar})


# def  view_all_users_review(request):
#     data = Review_tb.objects.all()
#     ar = []
#     for i in data:
#         ar.append({
#             'id': i.id,
#             'DRIVER':i.USDRIVER,
#             'rating': i.USER.rating,
#             'review':i.USER.review,
#             'date':i.USER.date,
#
#
#         })
#     return JsonResponse({'status':'ok','message':ar})


def user_send_review(request):
    did=request.POST['did']
    uid=request.POST['uid']
    rev=request.POST['review']
    ra=request.POST['rating']
    obj=Review_tb()
    obj.review=rev
    obj.rating=ra
    obj.date=datetime.date.today()
    obj.USER_id=uid
    obj.DRIVER_id=did
    obj.save()
    return JsonResponse({'status':'ok'})

def view_driver(request):
    data = Driver_tb.objects.filter(availability='available')
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'name': i.name,
            'email': i.email,
            'phone':i.phone,
            'photo': i.photo,
            'proof': i.proof,


        })
    return JsonResponse({'status':'ok','message':ar})

def  user_view_vehicle_details_and_images(request):
    did=request.POST['did']
    data = Vehicle_tb.objects.filter(DRIVER_id=did)
    ar = []
    for i in data:
        ar.append({
            'driver':i.DRIVER.id,
            'id': i.id,
            'model': i.model,
            'no_of_seat':i.no_of_seat,
            'photo':i.photo,
            'rc':i.rc,
            'license':i.license,


        })
    return JsonResponse({'status':'ok','message':ar})




def book_ride(request):
    from_latitude = request.POST['from_latitude']
    from_longitude = request.POST['from_longitude']
    to_latitude = request.POST['to_latitude']
    to_longitude = request.POST['to_longitude']
    ride_type = request.POST.get('ride_type')

    amount = request.POST['amount']
    try:
        amount = round(float(amount), 2)
    except ValueError:
        amount = 0.00  # fallback if invalid

    did = request.POST['did']
    uid = request.POST['uid']

    obj = Request_tb()
    obj.USER_id = uid
    obj.DRIVER_id = did
    obj.from_latitude = from_latitude
    obj.from_longitude = from_longitude
    obj.to_latitude = to_latitude
    obj.to_longitude = to_longitude
    obj.amount = str(amount)
    obj.share=ride_type
    obj.status = 'pending'
    obj.payment_status = 'pending'
    obj.extra_charge = '0'
    obj.date = datetime.date.today()
    obj.save()

    return JsonResponse({'status': 'ok', 'amount': str(amount)})



def remove_vehicle_details(request):
    id=request.POST['id']
    Vehicle_tb.objects.get(id=id).delete()
    return JsonResponse({'status':'ok'})


# -----userchta---

def user_sendchat(request):
    FROM_id=request.POST['from_id']
    TOID_id=request.POST['to_id']

    # print(FROM_id, TOID_id,"Lk")



    msg=request.POST['message']

    from  datetime import datetime
    c=Chat_tb()
    c.USER_id=FROM_id
    c.DRIVER_id=TOID_id
    c.messages=msg
    c.type='user'
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})

def user_viewchat(request):
    from_id=request.POST['from_id']
    to_id=request.POST['to_id']
    # print(to_id)

    l=[]
    data1=Chat_tb.objects.filter(USER_id=from_id,DRIVER_id=to_id).order_by('id')
    # data2=Chat.objects.filter(FROMID_id=to_id,TOID_id=from_id).order_by('id')

    # data= data1 | data2
    print(data1)


    # data= Chat.objects.all()

    for res in data1:
        l.append({'id':res.id,'from':res.USER.id,'to':res.DRIVER.id,'msg':res.messages,'date':res.date,'type':res.type})

    return JsonResponse({'status':"ok",'data':l})

def driver_update_availability(request):
    did=request.POST['did']
    status=request.POST['status']
    Driver_tb.objects.filter(id=did).update(availability=status)
    return JsonResponse({'status':'ok'})



# def remove_vehicle_details(request):
#     id=request.POST['id']
#     Vehicle_tb.objects.get(id=id).delete()
#     return JsonResponse({'status':'ok'})


def driver_complete_ride(request):
    id=request.POST['id']
    Request_tb.objects.filter(id=id).update(ride_status='completed')
    return JsonResponse({'status':'ok'})


def driver_sendchat(request):
    FROM_id=request.POST['from_id']
    TOID_id=request.POST['to_id']



    # print(FROM_id, TOID_id,"Lk")



    msg=request.POST['message']

    from  datetime import datetime
    c=Chat_tb()
    c.DRIVER_id=FROM_id
    c.USER_id=TOID_id
    c.messages=msg
    c.type='driver'
    c.date=datetime.now()
    c.save()
    return JsonResponse({'status':"ok"})

def driver_viewchat(request):
    from_id=request.POST['from_id']
    to_id=request.POST['to_id']
    # print(to_id)

    l=[]
    data1=Chat_tb.objects.filter(DRIVER_id=from_id,USER_id=to_id).order_by('id')
    # data2=Chat.objects.filter(FROMID_id=to_id,TOID_id=from_id).order_by('id')

    # data= data1 | data2
    print(data1)


    # data= Chat.objects.all()




    for res in data1:
        l.append({'id':res.id,'from':res.DRIVER.id,'to':res.USER.id,'msg':res.messages,'date':res.date,'type':res.type})



    return JsonResponse({'status':"ok",'data':l})


def view_passengers_requst(request):
    did=request.POST['did']
    data = Request_tb.objects.filter(DRIVER_id=did,status='pending')
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'USER': i.USER.name,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'amount':i.amount,
            'status':i.status,
            'userid':i.USER.phone


        })
    return JsonResponse({'status':'ok','message':ar})

def add_extra_charges_with_fair(request):
    if request.method == "POST":

        request_id = request.POST.get('request_id')
        extra_charge = request.POST.get('extra_charge')

        if not request_id or not extra_charge:
            return JsonResponse({'status': 'failed', 'message': 'Missing data'})

        try:
            ride = Request_tb.objects.get(id=request_id)

            base_amount = float(ride.amount) if ride.amount else 0
            extra = float(extra_charge)

            ride.extra_charge = str(extra)
            ride.save()

            return JsonResponse({
                'status': 'ok',
                'extra_saved': ride.extra_charge
            })

        except Exception as e:
            print("ERROR:", e)
            return JsonResponse({'status': 'error'})

    return JsonResponse({'status': 'invalid'})



def view_apprroved_request(request):
    did=request.POST['did']
    data = Request_tb.objects.filter(~Q(payment_status='paid'),DRIVER_id=did,status='accept')
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'driver':i.DRIVER.id,
            'USER': i.USER.name,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'amount':i.amount,
            'userid':i.USER.id,
            'status':i.status,
            'payment_status':i.payment_status,
            'extra_charge':i.extra_charge,


        })
    return JsonResponse({'status':'ok','message':ar})

def reject_passenger_request(request):
    id=request.POST['id']
    Request_tb.objects.filter(id=id).update(status='reject')
    return JsonResponse({'status':'ok'})

def accept_passenger_request(request):
    id=request.POST['id']
    Request_tb.objects.filter(id=id).update(status='accept')
    return JsonResponse({'status':'ok'})

def view_ride_history(request):
    did = request.POST['did']
    data = Request_tb.objects.filter(DRIVER_id=did)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,
            'USER': i.USER.name,
            'amount': i.amount,
            'extra_charge': i.extra_charge,
            'payment_status': i.payment_status,
            'status': i.status,
            'ride_status':i.ride_status,

        })
    return JsonResponse({'status': 'ok', 'message': ar})


def view_passenger_location(request):
    did = request.POST['did']
    data = Request_tb.objects.filter(DRIVER_id=did)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'username':i.USER.name,
            'usermail':i.USER.email,
            'phone':i.USER.phone,
            'from_latitude': i.from_latitude,
            'from_longitude': i.from_longitude,
            'to_latitude': i.to_latitude,
            'to_longitude': i.to_longitude,

        })
    return JsonResponse({'status': 'ok', 'message': ar})

def report_driver(request):
    rep=request.POST['report']
    uid=request.POST['uid']
    reqid=request.POST['reqid']
    did=Request_tb.objects.get(id=reqid).DRIVER_id
    obj=Report_tb()
    obj.report_reason=rep
    obj.USER_id=uid
    obj.DRIVER_id=did
    obj.type='user'
    obj.date=datetime.date.today()
    obj.save()
    return JsonResponse({'status':'ok'})

def report_user(request):
    rep=request.POST['report']
    did=request.POST['did']
    reqid=request.POST['reqid']
    uid=Request_tb.objects.get(id=reqid).USER_id
    obj=Report_tb()
    obj.report_reason=rep
    obj.USER_id=uid
    obj.DRIVER_id=did
    obj.type='driver'
    obj.date=datetime.date.today()
    obj.save()
    return JsonResponse({'status':'ok'})

def view_payment_logs(request):
    did = request.POST['did']
    data = Request_tb.objects.filter(DRIVER_id=did)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'USER': i.USER.name,
            'amount': i.amount,
            'extra_charge': i.extra_charge,
            'payment_status': i.payment_status,

        })
    return JsonResponse({'status': 'ok', 'message': ar})

def view_passenger_request(request):
    did = request.POST['did']
    data = Request_tb.objects.filter(DRIVER_id=did)
    ar = []
    for i in data:
        ar.append({
            'id': i.id,
            'date': i.date,
            'USER': i.USER.name,
            'amount': i.amount,
            'from_latitude': i.amount,
            'to_longitude': i.amount,
            'from_latitude': i.amount,
            'to_longitude': i.amount,



        })
    return JsonResponse({'status': 'ok', 'message': ar})


def make_payment(request):
    id=request.POST['requestId']
    mode=request.POST['mode']
    if mode =='online':
        paysts='paid'
    elif mode == 'offline':
        paysts ='pending'
    else:
        paysts=''


    Request_tb.objects.filter(id=id).update(payment_status=paysts,status=mode)
    return JsonResponse({'status':'ok'})


print(make_password('1234'))




def forgotpassword(request):
    return render(request,"forgotpassword.html")
def forgotpasswordbuttonclick(request):
    email = request.POST['textfield']
    if User.objects.filter(username=email).exists():
        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        sender_email = "voievoieapp@gmail.com"
        receiver_email = email  # change to actual recipient
        app_password = "bakd ccau rxqc oozg" \
                       ""  # App Password from Google
        pwd = str(random.randint(1100,9999))  # Example password to send
        request.session['otp'] = pwd
        request.session['email'] = email

        # Setup SMTP
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, app_password)

        # Create the email
        msg = MIMEMultipart("alternative")
        msg["From"] = sender_email
        msg["To"] = receiver_email
        msg["Subject"] = "Your OTP"

        # Plain text (backup)
        # text = f"""
        # Hello,

        # Your password for Smart Donation Website is: {pwd}

        # Please keep it safe and do not share it with anyone.
        # """

        # HTML (attractive)
        html = f"""
        <html>
          <body style="font-family: Arial, sans-serif; color: #333;">
            <h2 style="color:#2c7be5;">rickshaw ride</h2>
            <p>Hello,</p>
            <p>Your OTP is:</p>
            <p style="padding:10px; background:#f4f4f4; 
                      border:1px solid #ddd; 
                      display:inline-block;
                      font-size:18px;
                      font-weight:bold;
                      color:#2c7be5;">
              {pwd}
            </p>
            <p>Please keep it safe and do not share it with anyone.</p>
            <hr>
            <small style="color:gray;">This is an automated email from rickshawride System.</small>
          </body>
        </html>
        """

        # Attach both versions
        # msg.attach(MIMEText(text, "plain"))
        msg.attach(MIMEText(html, "html"))

        # Send email
        server.send_message(msg)
        print("✅ Email sent successfully!")

        # Close connection
        server.quit()
        return HttpResponse("<script>window.location='/otp'</script>")
    else:
        return HttpResponse("<script>alert('Email not found');window.location='/forgotpassword'</script>")


def otp(request):
    return render(request,"otp.html")
def otpbuttonclick(request):
    otp  = request.POST["textfield"]
    if otp == str(request.session['otp']):
        return HttpResponse("<script>window.location='/forgotpswdpswed'</script>")
    else:
        return HttpResponse("<script>alert('incorrect otp');window.location='/otp'</script>")

def forgotpswdpswed(request):
    return render(request,"forgotpswdpswed.html")
def forgotpswdpswedbuttonclick(request):
    np = request.POST["password"]
    User.objects.filter(username=request.session['email']).update(password=make_password(np))
    return HttpResponse("<script>alert('password has been changed');window.location='/' </script>")





def forgotemail(request):
    import random,datetime
    import smtplib
    email = request.POST['email']
    print(email)
    data = User.objects.filter(username=email)
    print(data)
    if data.exists():
        otp = str(random.randint(100000, 999999))
        print(otp)
        # *✨ Python Email Codeimport smtplib*

        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        # ✅ Gmail credentials (use App Password, not real password)
        try:
            sender_email = "voievoieapp@gmail.com"
            receiver_email = email # change to actual recipient
            app_password = "bakd ccau rxqc oozg"
            # Setup SMTP
            server = smtplib.SMTP("smtp.gmail.com", 587)
            server.starttls()
            server.login(sender_email, app_password)

            # Create the email
            msg = MIMEMultipart("alternative")
            msg["From"] = sender_email
            msg["To"] = receiver_email
            msg["Subject"] = "🔑 Forgot Password "

            # Plain text (backup)
            # text = f"""
            # Hello,

            # Your password for Smart Donation Website is: {pwd}

            # Please keep it safe and do not share it with anyone.
            # """

            # HTML (attractive)
            html = f"""
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Password Reset OTP</title>
                </head>
                <body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                            line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">

                    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                                padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
                        <h1 style="color: white; margin: 0; font-size: 28px;">
                            🔐 rickshaw ride
                        </h1>
                    </div>

                    <div style="background-color: #f9f9f9; padding: 40px 30px; border-radius: 0 0 10px 10px; 
                                border: 1px solid #eaeaea;">

                        <h2 style="color: #2d3748; margin-top: 0;">Password Reset Request</h2>

                        <p style="color: #4a5568; font-size: 16px;">
                            Hello,
                        </p>

                        <p style="color: #4a5568; font-size: 16px;">
                            You requested to reset your password. Use the OTP below to proceed:
                        </p>

                        <div style="background: white; border-radius: 8px; padding: 20px; 
                                    text-align: center; margin: 30px 0; border: 2px dashed #cbd5e0;">
                            <div style="font-size: 32px; font-weight: bold; letter-spacing: 10px; 
                                        color: #2c7be5; margin: 10px 0;">
                                {otp}
                            </div>
                            <div style="font-size: 14px; color: #718096; margin-top: 10px;">
                                (Valid for 10 minutes)
                            </div>
                        </div>

                        <p style="color: #4a5568; font-size: 16px;">
                            Enter this code on the password reset page to complete the process.
                        </p>

                        <div style="background-color: #fef3c7; border-left: 4px solid #d97706; 
                                    padding: 15px; margin: 25px 0; border-radius: 4px;">
                            <p style="color: #92400e; margin: 0; font-size: 14px;">
                                ⚠️ <strong>Security tip:</strong> Never share this OTP with anyone. 
                                Our team will never ask for your password or OTP.
                            </p>
                        </div>

                        <p style="color: #718096; font-size: 14px;">
                            If you didn't request this password reset, please ignore this email or 
                            contact our support team if you have concerns.
                        </p>

                        <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 30px 0;">

                        <p style="text-align: center; color: #a0aec0; font-size: 12px;">
                            This is an automated email from rickshawride System.<br>
                            © {datetime.now().year} rickshawride. All rights reserved.
                        </p>

                    </div>
                </body>
                </html>
                """

            # Attach both versions
            # msg.attach(MIMEText(text, "plain"))
            msg.attach(MIMEText(html, "html"))

            # Send email
            server.send_message(msg)
            print("✅ Email sent successfully!", otp)

            # Close connection
            server.quit()

        except Exception as e:
            print("❌ Error loading email credentials:", e)
            return JsonResponse({'status': "ok", 'otpp': otp})

        return JsonResponse({'status': 'ok', 'otpp': otp})
    return JsonResponse({'status': "not found"})


def forgotpass(request):
    email = request.POST['email']
    npass = request.POST['password']
    cpass = request.POST['confirmpassword']
    print(email, npass, cpass)
    if npass == cpass:
        User.objects.filter(username=email).update(password=make_password(npass))
        return JsonResponse({'status': 'ok'})
    return JsonResponse({'status': 'invalid'})


print(make_password('1234'))


def cancel_booking(request):
    if request.method == "POST":
        booking_id = request.POST.get('booking_id')
        user_id = request.POST.get('user_id')

        try:
            booking = Request_tb.objects.get(id=booking_id, USER_id=user_id)

            if booking.status.lower() in ['pending', 'accept']:
                booking.status = 'cancelled'
                booking.save()

                return JsonResponse({
                    'status': "ok",
                    'message': 'Booking cancelled successfully'
                })
            else:
                return JsonResponse({
                    'success': False,
                    'message': 'Booking cannot be cancelled at this stage'
                })

        except Request_tb.DoesNotExist:
            return JsonResponse({
                'success': False,
                'message': 'Booking not found'
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            })

    return JsonResponse({'success': False, 'message': 'Invalid request method'})


print(make_password('1234'))