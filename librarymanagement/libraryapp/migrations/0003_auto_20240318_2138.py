# Generated by Django 3.2.25 on 2024-03-18 16:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('libraryapp', '0002_auto_20240318_2020'),
    ]

    operations = [
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='author',
            field=models.CharField(max_length=30),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='genre',
            field=models.CharField(max_length=30),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='language',
            field=models.CharField(max_length=30),
        ),
        migrations.AlterField(
            model_name='bookstallbookstable',
            name='name',
            field=models.CharField(max_length=30),
        ),
    ]
