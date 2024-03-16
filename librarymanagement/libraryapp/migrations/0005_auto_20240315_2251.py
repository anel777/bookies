# Generated by Django 3.2.25 on 2024-03-15 17:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('libraryapp', '0004_reviewtable2'),
    ]

    operations = [
        migrations.AlterField(
            model_name='booknumbertable',
            name='bookId',
            field=models.CharField(max_length=800),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='author',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='genre',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='language',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='name',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='stock',
            field=models.CharField(max_length=720),
        ),
        migrations.AlterField(
            model_name='bookstalltable',
            name='email',
            field=models.CharField(max_length=40),
        ),
        migrations.AlterField(
            model_name='bookstalltable',
            name='name',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstalltable',
            name='ownerName',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='bookstalltable',
            name='place',
            field=models.CharField(max_length=40),
        ),
        migrations.AlterField(
            model_name='librarytable',
            name='email',
            field=models.CharField(max_length=40),
        ),
        migrations.AlterField(
            model_name='librarytable',
            name='name',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='librarytable',
            name='place',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='librarytable',
            name='post',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='libraybooktable',
            name='bookName',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='logintable',
            name='password',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='logintable',
            name='username',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='orderitemstable',
            name='quantity',
            field=models.CharField(max_length=500),
        ),
        migrations.AlterField(
            model_name='usertable',
            name='email',
            field=models.CharField(max_length=40),
        ),
        migrations.AlterField(
            model_name='usertable',
            name='name',
            field=models.CharField(max_length=24),
        ),
        migrations.AlterField(
            model_name='usertable',
            name='place',
            field=models.CharField(max_length=50),
        ),
        migrations.AlterField(
            model_name='usertable',
            name='post',
            field=models.CharField(max_length=24),
        ),
    ]
