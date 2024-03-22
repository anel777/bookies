from decimal import Decimal
from datetime import datetime, date, timedelta

from django.db.models import Q
from django.shortcuts import render, redirect  # temp
from django.contrib.auth import login, logout  # temp
from django.views.decorators.cache import cache_control  # temp

from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render
from libraryapp.models import *
from django.core import serializers
import json
from django.http import JsonResponse




def login(request):
    return render(request, 'loginindex.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)  # temp
def loginCode(request):
    try:
        uname = request.POST['textfield']
        pswrd = request.POST['textfield2']
        ob = loginTable.objects.get(username=uname, password=pswrd)
        if ob.type == 'admin':
            return HttpResponse('''<script>alert("LOGGED IN AS ADMIN");window.location="/ahome"</script>''')
        elif ob.type == 'library':
            request.session['lid'] = ob.id
            return HttpResponse('''<script>alert("LOGGED IN AS LIBRARIAN");window.location="/libraryHome"</script>''')
        elif ob.type == 'bookstall':
            request.session['bsid'] = ob.id
            return HttpResponse('''<script>alert("LOGGED IN AS BOOKSTALL");window.location="/bookStallHome"</script>''')
        else:
            return HttpResponse('''<script>alert("Incorrect Password / Username");window.location="/"</script>''')
    except:
        return HttpResponse('''<script>alert("Incorrect Password / Username ");window.location="/"</script>''')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)  # temp
def clear_session(request):  # Temp
    logout(request)
    return redirect('login')


# //////////////////ADMIN///////////////////////


def ahome(request):
    return render(request, 'Admin/adminindex.html')


def vbookstall(request):
    ob = bookstallTable.objects.all()
    return render(request, 'Admin/verify bookstall.html', {'val': ob})


def vlibrary(request):
    ob = libraryTable.objects.all()
    return render(request, 'Admin/verify library.html', {'val': ob})


def acceptBookstall(request, id):
    ob = loginTable.objects.get(id=id)
    ob.type = 'bookstall'
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/vbookstall#"</script>''')


def acceptLibrary(request, id):
    ob = loginTable.objects.get(id=id)
    ob.type = 'library'
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/vlibrary#"</script>''')


def rejectLibrary(request, id):
    ob = loginTable.objects.get(id=id)
    ob.type = 'rejected'
    ob.save()
    return HttpResponse('''<script>alert("Rejected!");window.location="/vlibrary#"</script>''')


def rejectBookstall(request, id):
    ob = loginTable.objects.get(id=id)
    ob.type = 'rejected'
    ob.save()
    return HttpResponse('''<script>alert("Rejected!");window.location="/vbookstall#"</script>''')


def searchLibrary(request):
    name = request.POST['textfield8']
    ob = libraryTable.objects.filter(name__contains=name)
    return render(request, 'Admin/verify library.html', {'val': ob})


def searchBookstall(request):
    name = request.POST['textfield8']
    ob = bookstallTable.objects.filter(name__contains=name)
    return render(request, 'Admin/verify bookstall.html', {'val': ob})


def viewFeedbacks(request):
    ob = feedbackTable.objects.all()
    return render(request, 'Admin/View Feedbacks.html', {'data': ob})


def feedbackSearch(request):
    type = request.POST['select']
    if type == "Library":
        ob = feedbackTable.objects.filter(LOGIN__type='library')
    else:
        ob = feedbackTable.objects.filter(LOGIN__type='bookstall')
    return render(request, 'Admin/View Feedbacks.html', {'data': ob})


def viewBookAndOffers(request):
    ob = bookStallBooksTable.objects.all()
    # ob1 = offersTable.objects.all()
    return render(request, 'Admin/View new books and offers.html', {'data': ob})


def offersSearch(request):
    name = request.POST['select']
    ob = bookStallBooksTable.objects.filter(name__icontains=name)
    return render(request, 'Admin/View new books and offers.html', {'data': ob})


def viewBookAndOffers2(request):
    ob = offersTable.objects.all()
    return render(request, 'Admin/views new books and offers 2.html', {'val': ob})


def viewReviewsAndRating(request):
    ob = bookstallTable.objects.all()
    ob1 = reviewTable.objects.all()
    return render(request, 'Admin/views reviews and rating.html', {'data': ob, 'val': ob1})


def writingTable(request):
    name = request.POST['select']
    ob = bookstallTable.objects.all()
    ob1 = reviewTable.objects.filter(BOOK__name__icontains=name)
    return render(request, 'Admin/views reviews and rating.html', {'val': ob1, 'data': ob})


def writingTable1(request):  # offers page
    name = request.POST['select']
    ob = bookstallTable.objects.all()
    ob1 = offersTable.objects.filter(BOOKSTALL=name)
    return render(request, 'Admin/View new books and offers.html', {'val': ob1, 'data': ob})


# \\\\\\\\\\\\\\\\BookStall\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


def add_ManageBooks(request):
    ob = bookStallBooksTable.objects.filter(BOOKSTALL__LOGIN__id=request.session['bsid'])
    return render(request, 'Bookstall/Add and Manage Books.html', {"val": ob})


def add_ManageBooksSearch(request):
    param = request.POST['select']
    ob = bookStallBooksTable.objects.filter(BOOKSTALL__LOGIN__id=request.session['bsid'], name__istartswith=param)
    return render(request, 'Bookstall/Add and Manage Books.html', {"val": ob})


def add_Books(request):
    return render(request, 'Bookstall/Add books.html')


def add_BooksBs(request):
    name = request.POST['textfield']
    author = request.POST['textfield2']
    genre = request.POST['textfield3']
    rate = request.POST['textfield4']
    stock = request.POST['textfield5']
    language = request.POST['textfield6']
    ob = bookStallBooksTable()

    ob.BOOKSTALL = bookstallTable.objects.get(LOGIN__id=request.session['bsid'])
    ob.name = name
    ob.genre = genre
    ob.author = author
    ob.stock = stock
    ob.rate = rate
    ob.language = language
    ob.save()
    return HttpResponse('''<script>alert("BOOKS ADDED...!");window.location="/add_ManageBooks"</script>''')


########
def editBooksbs(request, id):
    ob = bookStallBooksTable.objects.get(id=id)
    request.session['bid'] = ob.id
    return render(request, 'Bookstall/edit books.html', {"val": ob})


def editBooks_bs(request):
    name = request.POST['textfield']
    genre = request.POST['textfield2']
    author = request.POST['textfield3']
    rate = request.POST['textfield4']
    stock = request.POST['textfield5']
    ob = bookStallBooksTable.objects.get(id=request.session['bid'])

    ob.BOOKSTALL = bookstallTable.objects.get(LOGIN_id=request.session['bsid'])
    ob.name = name
    ob.genre = genre
    ob.author = author
    ob.rate = rate
    ob.stock = stock
    ob.save()
    return HttpResponse('''<script>alert("BOOKS Edited...!");window.location="add_ManageBooks"</script>''')


# Delete Books
def delBooksBS(request, id):
    ob = bookStallBooksTable.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script>alert("Book Deleted...!");window.location="/add_ManageBooks"</script>''')


#######

def bookStallHome(request):
    return render(request, 'Bookstall/bookstallindex.html')


def bookStallRegistration(request):
    return render(request, 'Bookstall/Bookstall registration.html')


# REGISTRATION CODE
def bookStallRegistrationCode(request):
    name = request.POST['textfield']
    ownerName = request.POST['textfield2']
    place = request.POST['textfield3']
    post = request.POST['textfield4']
    pin = request.POST['textfield5']
    email = request.POST['textfield6']
    phone = request.POST['textfield7']
    photo = request.FILES['textfield8']
    fs = FileSystemStorage()
    fsave = fs.save(photo.name, photo)
    lattitude = request.POST['textfield9']
    longitude = request.POST['textfield10']
    lic = request.POST['textfield13']
    username = request.POST['textfield11']
    password = request.POST['textfield12']


    ob = loginTable()
    ob.username = username
    ob.password = password
    ob.type = 'pending'
    ob.save()

    ob1 = bookstallTable()
    ob1.name = name
    ob1.lic = lic
    ob1.ownerName = ownerName
    ob1.place = place
    ob1.post = post
    ob1.pin = pin
    ob1.email = email
    ob1.phone = phone
    ob1.photo = fsave
    ob1.date = datetime.today()
    ob1.lattitude = lattitude
    ob1.longitude = longitude
    ob1.LOGIN = ob
    ob1.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY REGISTERED...!");window.location="/"</script>''')


def updateProfile(request):
    ob = bookstallTable.objects.get(LOGIN__id=request.session['bsid'])
    return render(request, 'Bookstall/update profile.html', {'val': ob})


def updateProfile_bs(request):
    phone = request.POST['phone']
    email = request.POST['email']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']

    ob = bookstallTable.objects.get(LOGIN__id=request.session['bsid'])
    ob.phone = phone
    ob.place = place
    ob.email = email
    ob.post = post
    ob.pin = pin
    ob.save()

    return HttpResponse('''<script>alert("Profile Updated...!");window.location="updateProfile"</script>''')


def viewBooks(request, id):  # pass ID
    ob = orderItemsTable.objects.filter(ORDER_id=id)
    return render(request, 'Bookstall/View books.html', {'val': ob})


def viewOrdersAndPayment(request):
    ob = orderItemsTable.objects.filter(BOOKSTALLBOOKS__BOOKSTALL__LOGIN=request.session['bsid'])
    list1 = []
    for i in ob:
        list1.append(i.ORDER.id)
    order_obj = ordersTable.objects.filter(id__in=list1)
    return render(request, "Bookstall/View Orders and payment.html", {'val': order_obj})


def deliveredBtn(request, id):
    ob = ordersTable.objects.get(id=id)
    ob.status = 'delivered'
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/viewOrdersAndPayment"</script>''')



# //////////////////////LIBRARY//////////////////////////////////

def addBooks(request):
    return render(request, 'Library/Add books.html')


# Add books -
def addBooksLib(request):
    name = request.POST['textfield']
    genre = request.POST['textfield2']
    author = request.POST['textfield3']
    quantity = request.POST['textfield4']
    language = request.POST['textfield5']
    ob = librayBookTable()

    ob.LIBRARY = libraryTable.objects.get(LOGIN_id=request.session['lid'])
    ob.bookName = name
    ob.genre = genre
    ob.author = author
    ob.quantity = quantity
    ob.language = language
    ob.save()
    return HttpResponse('''<script>alert("BOOKS ADDED...!");window.location="/addBooks"</script>''')


# edit Book

def editBooks(request, id):
    ob = librayBookTable.objects.get(id=id)
    request.session['bid'] = ob.id
    return render(request, 'Library/edit books.html', {"val": ob})


def editBooksLib(request):
    name = request.POST['textfield']
    genre = request.POST['textfield2']
    author = request.POST['textfield3']
    quantity = request.POST['textfield4']
    language = request.POST['textfield5']
    ob = librayBookTable.objects.get(id=request.session['bid'])

    ob.LIBRARY = libraryTable.objects.get(LOGIN_id=request.session['lid'])
    ob.bookName = name
    ob.genre = genre
    ob.author = author
    ob.quantity = quantity
    ob.language = language
    ob.save()
    return HttpResponse('''<script>alert("BOOKS Edited...!");window.location="manageLibraryBooks"</script>''')


# Delete Books
def delBooksLib(request, id):
    ob = librayBookTable.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script>alert("Book Deleted...!");window.location="/manageLibraryBooks"</script>''')


def issueBooks(request, id):
    request.session['bid'] = id
    ob = userTable.objects.all()
    ob1 = bookNumberTable.objects.filter(LIBRARY_BOOK__id=id)
    return render(request, 'Library/Issue books.html', {'val': ob, 'bno': ob1})


# To Issue a book to a USER
def issueBooks_issue(request):
    user = request.POST['select']
    rDate = request.POST['rDate']
    fine = request.POST['fine']
    bookNumb = request.POST['bkno']

    ob = issueTable()
    ob.returnDate = rDate
    ob.fineAmount = fine
    ob.date = datetime.today()
    ob.BOOKNUMBER = bookNumberTable.objects.get(id=bookNumb)
    ob.LIBRARYBOOK = librayBookTable.objects.get(id=request.session['bid'])
    ob.USER = userTable.objects.get(id=user)
    ob.status = 'issued'
    ob.save()
    return HttpResponse('''<script>alert("Book Issued...!");window.location="/renewAndIssueBooks"</script>''')


def libraryRegistration(request):
    return render(request, 'Library/libarary Registration.html')


def libraryRegistrationCode(request):
    print(request.FILES, "REGISTER")
    name = request.POST['textfield']
    place = request.POST['textfield2']
    phone = request.POST['textfield4']
    email = request.POST['textfield5']
    post = request.POST['textfield6']
    pin = request.POST['textfield7']
    lic = request.POST['textfield11']
    photo = request.FILES['file']
    fs = FileSystemStorage()
    fsave = fs.save(photo.name, photo)
    username = request.POST['textfield9']
    password = request.POST['textfield10']

    ob = loginTable()
    ob.username = username
    ob.password = password
    ob.type = 'pending'
    ob.save()

    ob1 = libraryTable()
    ob1.name = name
    ob1.lic = lic
    ob1.place = place
    ob1.phone = phone
    ob1.date = datetime.today()
    ob1.email = email
    ob1.post = post
    ob1.pin = pin
    ob1.photo = fsave
    ob1.LOGIN = ob
    ob1.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY REGISTERED...!");window.location="/"</script>''')


def libraryHome(request):
    return render(request, 'Library/libraryindex.html')


def manageLibraryBooks(request):
    ob = librayBookTable.objects.filter(LIBRARY__LOGIN__id=request.session['lid'])
    return render(request, 'Library/Manage Library Books.html', {"val": ob})


def manageLibraryBooksSearch(request):
    type = request.POST['type']
    if type == 'Name':
        name = request.POST['select']
        ob = librayBookTable.objects.filter(LIBRARY__LOGIN__id=request.session['lid'], bookName__istartswith=name)
    elif type == 'Author':
        name = request.POST['select']
        ob = librayBookTable.objects.filter(LIBRARY__LOGIN__id=request.session['lid'], author__istartswith=name)
    else:
        name = request.POST['select']
        ob = librayBookTable.objects.filter(LIBRARY__LOGIN__id=request.session['lid'], genre__istartswith=name)
    return render(request, 'Library/Manage Library Books.html', {"val": ob, "name": name})


def renewAndIssueBooks(request):  # Issue renew search
    ob = librayBookTable.objects.all()
    return render(request, 'library/Renew and Issue books.html', {'val': ob})


def irSearch2(request):  # Issue renew search
    param = request.POST['select']
    ob = librayBookTable.objects.filter(bookName__istartswith=param)
    return render(request, 'library/Renew and Issue books.html', {'val': ob, 'name': param})


def libraryUpdateProfile(request):
    ob = libraryTable.objects.get(LOGIN__id=request.session['lid'])
    return render(request, 'Library/Update Profile.html', {'val': ob})


def updateProfile_lib(request):
    phone = request.POST['phone']
    email = request.POST['email']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']

    ob = libraryTable.objects.get(LOGIN__id=request.session['lid'])
    ob.phone = phone
    ob.place = place
    ob.email = email
    ob.post = post
    ob.pin = pin
    ob.save()

    return HttpResponse('''<script>alert("Profile Updated...!");window.location="libraryUpdateProfile"</script>''')


def verifyIssueRequests(request):
    ob = issueTable.objects.filter(status='pending')
    return render(request, 'Library/Verify issue requests.html', {'val': ob})



def overDue():
    # Get today's date
    today = date.today()

    # Get all the issue records where today's date exceeds returnDate
    overdue_issues = issueTable.objects.filter(returnDate__lt=today, status='issued')

    # Iterate over each overdue issue and add payment record
    for issue in overdue_issues:
        # Calculate fine amount (for example, let's say it's $5 per day overdue)
        days_overdue = (today - issue.returnDate).days
        fine_amount = days_overdue * 40  # Adjust this calculation as per your requirement

        existing_payment = paymentTable.objects.filter(ISSUE=issue).first()

        if existing_payment.status != 'paid':
            # Update the existing payment record's fine amount
            existing_payment.amount = fine_amount
            existing_payment.date = today
            existing_payment.status = 'unpaid'  # Set the default status as 'unpaid'
            existing_payment.save()
        else:
            # Create payment record
            payment = paymentTable.objects.create(
                ISSUE=issue,
                amount=fine_amount,
                date=today,
                status='unpaid'  # Set the default status as 'unpaid'
            )
        issue.save()

        # Print a message or perform any additional action if needed
        print("Payment added for overdue book: Issue ID {issue.id}, Amount: {fine_amount}")



def Renewlist(request):
    ob = paymentTable.objects.all()
    overDue();
    return render(request, 'Library/list.html', {'val': ob})


# To accept the Issue requests & Reject
def reqAccepted(request, id):
    ob = issueTable.objects.get(id=id)
    ob.status = 'renewed'
    ob.returnDate += timedelta(weeks=2)
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/verifyIssueRequests"</script>''')


def reqRejected(request, id):
    ob = issueTable.objects.get(id=id)
    ob.status = 'Rejected'
    ob.save()
    return HttpResponse('''<script>alert("Rejected!");window.location="/verifyIssueRequests"</script>''')

def finePaid(request, id):
    ob = paymentTable.objects.get(id=id)
    ob.status = 'paid'
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/Renewlist"</script>''')


def viewFineAndPayment(request):
    ob = paymentTable.objects.all()
    return render(request, 'Library/View fine and payment.html', {'val': ob})


def viewFineAndPaymentSearch(request):
    param = request.POST['select']
    ob = paymentTable.objects.filter(ISSUE__USER__name__istartswith=param)
    return render(request, 'Library/View fine and payment.html', {'val': ob, "name": param})


def viewPreBooking(request):
    ob = preBookingTable.objects.all()
    return render(request, 'Library/View pre booking.html', {'val': ob})


def viewPreBookingSearch(request):
    param = request.POST['select']
    ob = preBookingTable.objects.filter(LIBRARYBOOK__bookName__istartswith=param)
    return render(request, 'Library/View pre booking.html', {'val': ob})


def issuedBtn(request, id):
    ob = preBookingTable.objects.get(id=id)
    ob.status = 'issued'
    ob.save()
    return HttpResponse('''<script>alert("Accepted!");window.location="/viewPreBooking"</script>''')

###########################Android#########################################



def and_login(request):
    print(request.POST)
    uname = request.POST['username']
    pswrd = request.POST['password']
    try:
        ob = loginTable.objects.get(username=uname, password=pswrd, type="user")
        if ob is None:
            return JsonResponse({"status": "invalid"})

        else:
            return JsonResponse({"status": "valid", "lid": ob.id})
    except:
        return JsonResponse({"status": "invalid"})


def and_registration(request):
    try:
        print(request.POST, "0000000000")
        name = request.POST['name']
        place = request.POST['place']
        post = request.POST['post']
        pin = request.POST['pin']
        phone = request.POST['phone']
        email = request.POST['email']
        photo = request.POST['photo']

        import base64
        timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
        print(timestr)
        a = base64.b64decode(photo)
        fh = open(r"C:\Users\anlmc\Downloads\Bookies\Bookies\librarymanagement\media\\" + timestr + ".jpg", "wb")
        path = timestr + ".jpg"
        fh.write(a)
        fh.close()

        username = request.POST['username']
        password = request.POST['password']

        ob = loginTable()
        ob.username = username
        ob.password = password
        ob.type = 'user'
        ob.save()

        ob1 = userTable()
        ob1.name = name
        ob1.place = place
        ob1.post = post
        ob1.pin = pin
        ob1.phone = phone
        ob1.email = email
        ob1.photo = path
        ob1.date = datetime.today()
        ob1.LOGIN = ob
        ob1.save()
        return JsonResponse({"task": "ok"})
    except Exception as e:
        print(e, "======================")
        return JsonResponse({"task": "na"})


def and_viewCart(request):
    print(request.POST)
    lid = request.POST['lid']
    try:
        ob = orderItemsTable.objects.filter(ORDER__status='cart', ORDER__USER__LOGIN__id=lid)
        mdata = []
        for i in ob:
            print(i.BOOKSTALLBOOKS.rate, '++',i.ORDER.total, '++++++')
            data = {'book': i.BOOKSTALLBOOKS.name, 'quantity': i.quantity, 'total': i.ORDER.total, 'rate' : int(i.quantity) * i.BOOKSTALLBOOKS.rate,
                    'genre': i.BOOKSTALLBOOKS.genre, 'author': i.BOOKSTALLBOOKS.author,
                    'id': i.id, 'place': i.BOOKSTALLBOOKS.BOOKSTALL.place, 'phone': i.BOOKSTALLBOOKS.BOOKSTALL.phone, 'oid' : i.ORDER.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status": "ok", "data": mdata})
    except Exception as e:
        print(e, "++++++++++++++++++++++++++")


def and_preBook(request):
    lid = request.POST['lid']
    bid = request.POST['bid']

    ob = preBookingTable()
    ob.date = datetime.today()
    ob.status = 'pending'
    ob.USER = userTable.objects.get(LOGIN__id=lid)
    ob.LIBRARYBOOK = librayBookTable.objects.get(id=bid)
    ob.save()

    try:
        return JsonResponse({"task": "ok"})
    except Exception as e:
        return JsonResponse({"task": "na"})


def and_addToCart(request):
    try:
        print(request.POST, '+++++++ADD+')
        quantity = int(request.POST['quantity'])
        lid = request.POST['lid']
        amount = Decimal(request.POST['amount'])
        bid = request.POST['bid']
        order_id=ordersTable.objects.filter(USER__LOGIN__id=lid,status='cart')
        order_item = orderItemsTable.objects.filter(BOOKSTALLBOOKS__id=bid,ORDER__USER__LOGIN__id=lid,ORDER__status='cart')

        if len(order_item)==0:
            # If the item does not exist in the cart, create a new order and order item
            user = userTable.objects.get(LOGIN__id=lid)
            if len(order_id)==0:
                new_order = ordersTable.objects.create(
                    USER=user,
                    total=amount,
                    status='cart',
                    date=datetime.today()
                )
                new_order.total = 0
            else:
                new_order=order_id[0]

            orderItemsTable.objects.create(
                quantity=quantity,
                BOOKSTALLBOOKS=bookStallBooksTable.objects.get(id=bid),
                ORDER=new_order
            )
            new_order.total += amount
            print("new_order.total = ", new_order.total, " + ", amount )
            new_order.save()

        else:
            order_item = order_item[0]
            # If the item exists in the cart, update the quantity and total
            order_item.quantity = int(order_item.quantity) + quantity
            order_item.ORDER.total += amount
            order_item.ORDER.save()
            order_item.save()

        return JsonResponse({"task": "ok"})
    except Exception as e:
        print(e)
        return JsonResponse({"task": "na"})


def and_viewFineAndPayments(request):
    lid = request.POST['lid']
    print(request.POST)
    ob = paymentTable.objects.filter(ISSUE__USER__LOGIN__id=lid, status='unpaid')
    mdata = []
    for i in ob:
        data = {'fine': i.amount, 'bookNumber': i.ISSUE.BOOKNUMBER.bookId, 'status': i.status, 'rDate': i.ISSUE.returnDate,
                'id': i.id, 'bookName' : i.ISSUE.LIBRARYBOOK.bookName}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status": "ok", "data": mdata})


def and_viewBooks(request):
    ob = librayBookTable.objects.all()
    ob1 = bookStallBooksTable.objects.all()

    mdata0 = []
    mdata1 = []
    for i in ob:  # library
        data = {'placeName': i.LIBRARY.name, 'bookPlace': i.LIBRARY.place, 'bid': i.id, 'bookName': i.bookName,
                'author': i.author, 'language': i.language, 'genre': i.genre,
                'type': "Library", 'rate': 0.00}
        mdata0.append(data)
        print(mdata0)

    for i in ob1:  # bookstall
        data = {'placeName': i.BOOKSTALL.name, 'bookPlace': i.BOOKSTALL.place, 'bid': i.id, 'bookName': i.name,
                'author': i.author, 'language': i.language, 'genre': i.genre,
                'type': "Bookstall", 'rate': i.rate}
        mdata1.append(data)
        print(mdata1)

        # combinedata=mdata0 + mdata1
    mdata0.extend(mdata1)
    print(mdata0)
    return JsonResponse({"status": "ok", "data": mdata0})


def and_searchBooks(request):
    print(request.POST)
    j = request.POST['j']

    ob = librayBookTable.objects.filter(
        Q(genre__icontains=j) |
        Q(bookName__icontains=j) |
        Q(author__icontains=j) |
        Q(language__icontains=j)
    )

    ob1 = bookStallBooksTable.objects.filter(
        Q(genre__icontains=j) |
        Q(name__icontains=j) |
        Q(author__icontains=j) |
        Q(language__icontains=j)
    )
    mdata0 = []
    mdata1 = []
    for i in ob:  # library
        data = {'placeName': i.LIBRARY.name, 'bookPlace': i.LIBRARY.place, 'bid': i.id, 'bookName': i.bookName,
                'author': i.author, 'language': i.language, 'genre': i.genre,
                'type': "Library", 'rate': 0.00}
        mdata0.append(data)

    for i in ob1:  # bookstall
        data = {'placeName': i.BOOKSTALL.name, 'bookPlace': i.BOOKSTALL.place, 'bid': i.id, 'bookName': i.name,
                'author': i.author, 'language': i.language, 'genre': i.genre,
                'type': "Bookstall", 'rate': i.rate}
        mdata1.append(data)

    mdata0.extend(mdata1)
    print(mdata0)
    return JsonResponse({'status': 'ok', "data" : mdata0})


def and_viewOrderHistory(request):
    lid = request.POST['lid']
    ob = orderItemsTable.objects.filter(ORDER__USER__LOGIN__id=lid)
    mdata = []
    for i in ob:
        if i.ORDER.status != "cart":
            data = {'date': str(i.ORDER.date), 'total': str(i.ORDER.total), 'id': i.ORDER.id,
                    'rate': i.BOOKSTALLBOOKS.rate,
                    'quantity': i.quantity, 'name': i.BOOKSTALLBOOKS.name, 'genre': i.BOOKSTALLBOOKS.genre,
                    'author': i.BOOKSTALLBOOKS.author, 'status' : i.ORDER.status}
            mdata.append(data)
    print(mdata)
    return JsonResponse({"status": "ok", "data": mdata})


def and_viewReviews(request):
    type = request.POST['type']
    bid = request.POST['bid']
    mdata0 = []
    mdata1 = []
    if type =='Bookstall':
        ob = reviewTable.objects.filter(BOOK__id = bid)
        for i in ob:  # library
            data = {'review': i.review, 'date': i.date, 'rating': i.rating, 'user': i.USER.name}
            mdata0.append(data)
            print(mdata0)
    else  :
        ob1 = reviewTable2.objects.filter(BOOK__id = bid)
        for i in ob1:  # bookstall
            data = {'review': i.review, 'date': i.date, 'rating': i.rating, 'user': i.USER.name}
            mdata1.append(data)
            print(mdata1)

    mdata0.extend(mdata1)
    print(mdata0)
    return JsonResponse({'status' : 'ok', 'data': mdata0})


def ViewFeedbacks(request):
    lid = request.POST['lid']
    ob = feedbackTable.objects.filter(USER__LOGIN__id=lid)
    mdata = []
    for i in ob:
        data = {'USER': i.user_name, 'feedback': i.feedback, 'date': i.date, 'rating': i.rating,
                'id': i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status": "ok", "data": mdata})

def and_updateView(request):
    print(request.POST , '================')
    lid = request.POST['lid']
    ip = request.POST['ip']
    ob = userTable.objects.get(LOGIN__id=lid)
    ob1 = loginTable.objects.get(id = lid)
    data = {'name': ob.name, 'email': ob.email, 'phone': str(ob.phone), 'post': ob.post, 'pin': str(ob.pin),
            'place': ob.place, 'img': ip+ob.photo.url[1:], 'username' : ob1.username, 'password' : ob1.password}
    return JsonResponse({'status' : 'ok', "data":data})


def and_updateprofile(request):
    lid = request.POST['lid']
    name = request.POST['user']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']
    phone = request.POST['phone']
    email = request.POST['email']
    photo = request.FILES['photo']
    fs = FileSystemStorage()
    fsave = fs.save(photo.name, photo)

    ob1 = userTable.objects.get(LOGIN__id=lid)
    ob1.name = name
    ob1.place = place
    ob1.post = post
    ob1.pin = pin
    ob1.phone = phone
    ob1.email = email
    ob1.photo = fsave
    ob1.date = datetime.today()
    ob1.save()
    data = {"task": "valid"}

    return JsonResponse(data)


def and_renew(request):
    lid = request.POST['lid']
    ob = issueTable.objects.filter(USER__LOGIN__id=lid, status='issued')
    mdata = []
    for i in ob:
        data = {'bookName': i.LIBRARYBOOK.bookName, 'bookId': i.LIBRARYBOOK.id, 'date': i.date,
                'returnDate': i.returnDate, 'fine': i.fineAmount, 'status': i.status,
                'id': i.id, 'genre' : i.LIBRARYBOOK.genre, 'author' : i.LIBRARYBOOK.author }
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status": "ok", "data": mdata})

def and_renewbtn(request):
    try:
        bid = request.POST['bid']
        ob1 = issueTable.objects.get(id=bid)
        ob1.status = 'pending'
        ob1.save()
        return JsonResponse({"status": "ok"})
    except Exception as e:
        return JsonResponse({"status": "na"})

def and_reviewbtn(request):
    try:
        print(request.POST)
        book_id = request.POST['bid']
        user_id = request.POST['lid']
        review = request.POST['review']
        rating = request.POST['rating']

        user = userTable.objects.get(LOGIN__id=user_id)
        book = librayBookTable.objects.get(id=book_id)

        review_obj = reviewTable2(USER=user, BOOK=book, review=review, rating=rating, date=datetime.today())
        review_obj.save()

        return JsonResponse({"status": "ok"})
    except Exception as e:
        print("------------",e)
        return JsonResponse({"status": "na"})


def and_bookstatus(request):
    lid = request.POST['lid']
    ob = issueTable.objects.filter(USER__LOGIN__id=lid).exclude(status='issued')
    mdata = []
    for i in ob:
        data = {'bookName': i.LIBRARYBOOK.bookName, 'bookId': i.BOOKNUMBER.bookId, 'status': i.status,
                'id': i.id, 'date': i.returnDate}
        mdata.append(data)
        print(i.returnDate, "----------+++++")
    return JsonResponse({"status": "ok", "data": mdata})

def and_cartbtn(request):
    try:
        oid = request.POST['oid']
        ob1 = ordersTable.objects.get(id=oid)
        ob1.status = 'order'
        ob1.save()
        return JsonResponse({"status": "ok"})
    except Exception as e:
        return JsonResponse({"status": "na"})