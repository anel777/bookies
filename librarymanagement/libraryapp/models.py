from django.db import models

# Create your models here.
class loginTable(models.Model):
    username = models.CharField(max_length = 24)
    password = models.CharField(max_length = 24)
    type = models.CharField(max_length = 12)

class userTable(models.Model):
    LOGIN = models.ForeignKey(loginTable, on_delete = models.CASCADE)
    name = models.CharField(max_length = 12)
    place = models.CharField(max_length = 12)
    post = models.CharField(max_length = 12)
    pin = models.CharField(max_length=10)
    phone = models.BigIntegerField()
    email = models.CharField(max_length = 40)
    photo = models.FileField()

class bookstallTable(models.Model):
    LOGIN = models.ForeignKey(loginTable, on_delete = models.CASCADE)
    name = models.CharField(max_length = 12)
    lic = models.CharField(max_length = 100)
    place = models.CharField(max_length = 12)
    ownerName = models.CharField(max_length = 12)
    phone = models.BigIntegerField()
    date = models.DateField()
    email = models.CharField(max_length = 24)
    post = models.CharField(max_length = 24)
    pin = models.CharField(max_length=10)
    lattitude = models.FloatField()
    longitude = models.FloatField()
    photo = models.FileField()

class libraryTable(models.Model):
    LOGIN = models.ForeignKey(loginTable, on_delete = models.CASCADE)
    name = models.CharField(max_length = 12)
    lic = models.CharField(max_length = 100)
    place = models.CharField(max_length = 12)
    phone = models.BigIntegerField()
    date = models.DateField()
    email = models.CharField(max_length = 24)
    post = models.CharField(max_length = 12)
    pin = models.CharField(max_length= 12)
    photo = models.FileField()


class feedbackTable(models.Model):
    LOGIN = models.ForeignKey(loginTable, on_delete = models.CASCADE)
    USER = models.ForeignKey(userTable, on_delete = models.CASCADE)
    feedback = models.CharField(max_length = 120)
    date = models.DateField()
    rating = models.FloatField()

class bookStallBooksTable(models.Model):
    BOOKSTALL = models.ForeignKey(bookstallTable, on_delete= models.CASCADE)
    genre = models.CharField(max_length=30)
    name = models.CharField(max_length=30)
    author = models.CharField(max_length=30)
    language = models.CharField(max_length=30)
    rate = models.FloatField()
    stock = models.CharField(max_length=100)


class reviewTable(models.Model):
    USER = models.ForeignKey(userTable, on_delete = models.CASCADE)
    BOOK = models.ForeignKey(bookStallBooksTable, on_delete = models.CASCADE)
    review = models.CharField(max_length = 120)
    rating = models.FloatField()
    date = models.DateField()

class librayBookTable(models.Model):
    LIBRARY = models.ForeignKey(libraryTable, on_delete=models.CASCADE)
    genre = models.CharField(max_length = 24)
    bookName = models.CharField(max_length=30)
    author = models.CharField(max_length=24)
    quantity = models.BigIntegerField()
    language = models.CharField(max_length=24)

class reviewTable2(models.Model):
    USER = models.ForeignKey(userTable, on_delete = models.CASCADE)
    BOOK = models.ForeignKey(librayBookTable, on_delete = models.CASCADE)
    review = models.CharField(max_length = 120)
    rating = models.FloatField()
    date = models.DateField()

class bookNumberTable(models.Model):
    LIBRARY_BOOK = models.ForeignKey(librayBookTable, on_delete=models.CASCADE)
    bookId = models.CharField(max_length=10)

class offersTable(models.Model):
    BOOKSTALL = models.ForeignKey(bookStallBooksTable, on_delete=models.CASCADE)
    offers = models.CharField(max_length = 100)
    offerDetails = models.CharField(max_length = 100)
    offerPeriod = models.DateField()

class ordersTable(models.Model):
    USER = models.ForeignKey(userTable,on_delete=models.CASCADE)
    date = models.DateField()

    total = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=30)

class orderItemsTable(models.Model):
    ORDER = models.ForeignKey(ordersTable, on_delete=models.CASCADE)
    BOOKSTALLBOOKS = models.ForeignKey(bookStallBooksTable, on_delete=models.CASCADE)
    quantity = models.CharField(max_length= 100)


class issueTable(models.Model):
    USER = models.ForeignKey(userTable, on_delete=models.CASCADE)
    LIBRARYBOOK  = models.ForeignKey(librayBookTable, on_delete=models.CASCADE)
    BOOKNUMBER = models.ForeignKey(bookNumberTable, on_delete=models.CASCADE)
    date = models.DateField()
    returnDate = models.DateField()
    status = models.CharField(max_length=100)
    fineAmount = models.FloatField()

class preBookingTable(models.Model):
    USER = models.ForeignKey(userTable, on_delete=models.CASCADE)
    LIBRARYBOOK = models.ForeignKey(librayBookTable, on_delete=models.CASCADE)
    date = models.DateField()
    status = models.CharField(max_length=100)

class paymentTable(models.Model):
    ISSUE = models.ForeignKey(issueTable, on_delete= models.CASCADE)
    amount = models.FloatField()
    date = models.DateField()
    status = models.CharField(max_length=102)







