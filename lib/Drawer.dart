import 'dart:math';

import 'package:bookies/cartDesign.dart';
import 'package:bookies/profileD.dart';
import 'package:bookies/renewStatus.dart';
import 'package:bookies/discovery.dart';
import 'package:bookies/fineTest.dart';
import 'package:bookies/order2.dart';
import 'package:bookies/renewTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'order.dart';
import 'login.dart';

class Drawerclass extends StatelessWidget {
  const Drawerclass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            curve: Curves.fastOutSlowIn,
            child: Icon(
              Icons.book,
              size: 100,
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => discovery()),
                  );
                },
                icon: Icon(
                  Icons.menu_book,
                  color: Colors.white,
                )),
            title: const Text(
              "Discover Books",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => discovery()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profileView()),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.blue,
                )),
            title: const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileView()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Renew()),
                  );
                },
                icon: Icon(
                  Icons.autorenew,
                  color: Colors.green[300],
                )),
            title: const Text(
              "Renew Books",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Renew()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RenewStatus()),
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.yellow,
                )),
            title: const Text(
              "Book Status",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RenewStatus()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Orders()),
                  );
                },
                icon: const Icon(Icons.pending_actions_outlined,
                    color: Colors.purple)),
            title: const Text(
              "Order",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Orders()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => cart()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white70,
                )),
            title: const Text(
              "Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cart()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fine()),
                  );
                },
                icon: const Icon(
                  Icons.attach_money,
                  color: Colors.lightGreenAccent,
                )),
            title: const Text(
              "Fine and Payments",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Fine()),
              );
            },
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  _showLogoutConfirmation(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
            title: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'mots'),
            ),
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Are you sure you want to quit?',
                        style: TextStyle(letterSpacing: 2, fontFamily: 'mont'),
                      ),
                    ),
                  ),
                ), //Do you want to Quit Text
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          //cancel
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 30, right: 30),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'mont',
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: Container(
                          //Confirm
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 30, right: 30),
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontFamily: 'mots',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ), //No message
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
