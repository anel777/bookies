# Generated by Django 3.2.25 on 2024-03-15 17:38

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('libraryapp', '0009_delete_reviewtable2'),
    ]

    operations = [
        migrations.CreateModel(
            name='reviewTable2',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('review', models.CharField(max_length=120)),
                ('rating', models.FloatField()),
                ('date', models.DateField()),
                ('BOOK', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='libraryapp.libraybooktable')),
                ('USER', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='libraryapp.usertable')),
            ],
        ),
    ]
