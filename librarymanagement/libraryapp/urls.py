"""librarymanagement URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
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
from django.contrib import admin
from django.urls import path

from django.urls import path  # temp
from .views import clear_session  # temp

from libraryapp import views

urlpatterns = [
    # clear Session
    path('clear/', clear_session, name='clear_session'),  # temp

    # ADMIN
    path('', views.login, name='login'),
    path('loginCode', views.loginCode, name='loginCode'),
    path('ahome', views.ahome, name='ahome'),
    path('vbookstall', views.vbookstall, name='vbookstall'),
    path('vlibrary', views.vlibrary, name='vlibrary'),
    path('viewFeedbacks', views.viewFeedbacks, name='viewFeedbacks'),
    path('viewBookAndOffers', views.viewBookAndOffers, name='viewBookAndOffers'),
    path('viewBookAndOffers2', views.viewBookAndOffers2, name='viewBookAndOffers2'),
    path('viewReviewsAndRating', views.viewReviewsAndRating, name='viewReviewsAndRating'),
    path('acceptLibrary/<int:id>', views.acceptLibrary, name='acceptLibrary'),
    path('acceptBookstall/<int:id>', views.acceptBookstall, name='acceptBookstall'),
    path('rejectLibrary/<int:id>', views.rejectLibrary, name='rejectLibrary'),
    path('rejectBookstall/<int:id>', views.rejectBookstall, name='rejectBookstall'),
    path('searchBookstall', views.searchBookstall, name='searchBookstall'),
    path('searchLibrary', views.searchLibrary, name='searchLibrary'),
    path('writingTable', views.writingTable, name='writingTable'),
    path('feedbackSearch', views.feedbackSearch, name='feedbackSearch'),
    path('offersSearch', views.offersSearch, name='offersSearch'),

    # bookstall path
    path('bookStallHome', views.bookStallHome, name='bookStallHome'),
    path('add_ManageBooks', views.add_ManageBooks, name='add_ManageBooks'),
    path('add_ManageBooksSearch', views.add_ManageBooksSearch, name='add_ManageBooksSearch'),
    path('editBooksbs/<int:id>', views.editBooksbs, name='editBooksbs'),
    path('editBooks_bs', views.editBooks_bs, name='editBooks_bs'),
    path('delBooksBS/<int:id>', views.delBooksBS, name='delBooksBS'),
    path('add_Books', views.add_Books, name='add_Books'),
    path('add_BooksBs', views.add_BooksBs, name='add_BooksBs'),
    path('bookStallRegistration', views.bookStallRegistration, name='bookStallRegistration'),
    path('updateProfile', views.updateProfile, name='updateProfile'),
    path('updateProfile_bs', views.updateProfile_bs, name='updateProfile_bs'),
    path('viewBooks/<int:id>', views.viewBooks, name='viewBooks'),
    path('viewOrdersAndPayment', views.viewOrdersAndPayment, name='viewOrdersAndPayment'),
    path('bookStallRegistrationCode', views.bookStallRegistrationCode, name='bookStallRegistrationCode'),

    # library path
    path('libraryHome', views.libraryHome, name='libraryHome'),
    path('addBooks', views.addBooks, name='addBooks'),
    path('editBooks/<int:id>', views.editBooks, name='editBooks'),
    path('issueBooks/<int:id>', views.issueBooks, name='issueBooks'),
    path('issueBooks_issue', views.issueBooks_issue, name='issueBooks_issue'),
    path('libraryRegistration', views.libraryRegistration, name='libraryRegistration'),
    path('manageLibraryBooks', views.manageLibraryBooks, name='manageLibraryBooks'),
    path('manageLibraryBooksSearch', views.manageLibraryBooksSearch, name='manageLibraryBooksSearch'),
    path('addBooksLib', views.addBooksLib, name='addBooksLib'),
    path('editBooksLib', views.editBooksLib, name='editBooksLib'),
    path('delBooksLib/<int:id>', views.delBooksLib, name='delBooksLib'),
    path('renewAndIssueBooks', views.renewAndIssueBooks, name='renewAndIssueBooks'),
    path('reqAccepted/<int:id>', views.reqAccepted, name='reqAccepted'),
    path('reqRejected/<int:id>', views.reqRejected, name='reqRejected'),
    path('irSearch2', views.irSearch2, name='irSearch2'),
    path('libraryUpdateProfile', views.libraryUpdateProfile, name='libraryUpdateProfile'),
    path('updateProfile_lib', views.updateProfile_lib, name='updateProfile_lib'),
    path('verifyIssueRequests', views.verifyIssueRequests, name='verifyIssueRequests'),
    path('viewFineAndPayment', views.viewFineAndPayment, name='viewFineAndPayment'),
    path('viewFineAndPaymentSearch', views.viewFineAndPaymentSearch, name='viewFineAndPaymentSearch'),
    path('viewPreBooking', views.viewPreBooking, name='viewPreBooking'),
    path('viewPreBookingSearch', views.viewPreBookingSearch, name='viewPreBookingSearch'),
    path('libraryRegistrationCode', views.libraryRegistrationCode, name='libraryRegistrationCode'),

    #Android
    path('and_login', views.and_login, name='and_login'),
    path('and_registration', views.and_registration, name='and_registration'),
    path('and_viewOrderHistory', views.and_viewOrderHistory, name='and_viewOrderHistory'),
    path('and_viewFineAndPayments', views.and_viewFineAndPayments, name='and_viewFineAndPayments'),
    path('and_viewBooks', views.and_viewBooks, name='and_viewBooks'),
    path('and_renew', views.and_renew, name='and_renew'),
    path('and_renewbtn', views.and_renewbtn, name='and_renewbtn'),
    path('and_bookstatus', views.and_bookstatus, name='and_bookstatus'),
    path('and_updateView', views.and_updateView, name='and_updateView'),
    path('and_updateprofile', views.and_updateprofile, name='and_updateprofile'),
    path('and_viewCart', views.and_viewCart, name='and_viewCart'),
    path('and_addToCart', views.and_addToCart, name='and_addToCart'),
    path('and_preBook', views.and_preBook, name='and_preBook'),
    path('and_renew', views.and_preBook, name='and_renew'),
    path('and_reviewbtn', views.and_reviewbtn, name='and_reviewbtn'),
    path('and_renewbtn', views.and_reviewbtn, name='and_renewbtn'),

]
