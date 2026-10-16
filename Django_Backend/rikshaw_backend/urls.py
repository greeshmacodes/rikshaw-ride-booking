"""rickshaw_ride URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path

from myapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',views.login1),
    path('login1_post',views.login1_post),
    path('change_pass',views.change_pass),
    path('change_pass_post',views.change_pass_post),
    path('admin_home',views.admin_home),
    path('view_drivers',views.view_drivers),
    path('approve_drivers/<id>',views.approve_driver),
    path('reject_drivers/<id>',views.reject_drvers),
    path('view_approved_driver',views.view_approved_driver),
    path('block_driver/<id>',views.block_driver),
    path('unblock_driver/<id>',views.unblock_driver),
    path('view_reviews',views.view_reviews),
    path('view_users',views.view_user),
    path('block_user/<id>',views.block_user),
    path('unblock_user/<id>',views.unblock_user),
    path('view_complaints',views.view_complaints),
    path('view_reports',views.view_reports),

    path('user_register',views.user_register),
    path('driver_register', views.driver_register),
    path('updatelocation',views.updatelocation),
    path('userlogin',views.userlogin),
    path('view_availability',views.view_availability),
    path('view_calculate_fair',views.view_calculate_fair),
    path('view_booking_status',views.view_booking_status),
    path('view_previous_ride',views.view_previous_ride),
    path('user_view_profile',views.user_view_profile),

    path('user_edit_profile',views.user_edit_profile),
    path('driver_view_profile',views.driver_view_profile),
    path('driver_edit_profile',views.driver_edit_profile),
    path('user_change_password',views.user_change_password),
    path('driver_change_password',views.driver_change_password),
    path('add_vehicle',views.add_vehicle),
    path('edit_vehicle_details',views.edit_vehicle_details),
    path('view_vehicle_details',views.view_vehicle_details),
    path('user_view_vehicle_details_and_images',views.user_view_vehicle_details_and_images),
    path('view_user_review',views.view_user_review),
    # path('view_all_users_review',views.view_all_users_review),
    path('view_driver',views.view_driver),
    path('user_send_review',views.user_send_review),
    path('book_ride',views.book_ride),
    path('remove_vehicle_details',views.remove_vehicle_details),
    path('user_sendchat',views.user_sendchat),
    path('user_viewchat',views.user_viewchat),
    path('driver_update_availability',views.driver_update_availability),
    # path('driver_view_chat',views.driver_view_chat),
    path('driver_viewchat',views.driver_viewchat),
    path('driver_sendchat',views.driver_sendchat),
    path('view_passengers_requst',views.view_passengers_requst),
    path('view_apprroved_request',views.view_apprroved_request),
    path('accept_passenger_request',views.accept_passenger_request),
    path('reject_passenger_request',views.reject_passenger_request),
    path('view_apprroved_request',views.view_apprroved_request),
    path('view_ride_history',views.view_ride_history),
    path('view_passenger_location',views.view_passenger_location),
    path('report_driver',views.report_driver),
    path('report_user',views.report_user),
    path('view_payment_logs',views.view_payment_logs),
    path('view_passenger_request',views.view_passenger_request),
    path('add_extra_charges_with_fair',views.add_extra_charges_with_fair),
    path('make_payment',views.make_payment),
    path('forgotpassword',views.forgotpassword),
    path('forgotpasswordbuttonclick',views.forgotpasswordbuttonclick),
    path('otp',views.otp),
    path('otpbuttonclick',views.otpbuttonclick),
    path('forgotpswdpswed',views.forgotpswdpswed),
    path('forgotpswdpswedbuttonclick',views.forgotpswdpswedbuttonclick),
    path('forgotemail',views.forgotemail),
    path('forgotpass',views.forgotpass),
    path('cancel_booking',views.cancel_booking),
    path('view_others_ride',views.view_others_ride),
    path('user_send_other_request',views.user_send_other_request),
    path('user_view_user_request',views.user_view_user_request),
    path('driver_complete_ride',views.driver_complete_ride),





]
urlpatterns+=static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
