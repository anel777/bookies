import 'dart:convert';
import 'dart:math';

import 'package:bookies/Drawer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  List<Map<String, String>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewCart";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      if (status == "ok") {
        var cartData = jsonData["data"];

        List<Map<String, String>> loadedCartItems = [];
        for (var item in cartData) {
          loadedCartItems.add({
            'book': item['book'].toString(),
            'total': item['total'].toString(),
            'quantity': item['quantity'].toString(),
            'genre': item['genre'].toString(),
            'author': item['author'].toString(),
            'place': item['place'].toString(),
            'phone': item['phone'].toString(),
            'oid': item['oid'].toString(),
          });
        }

        setState(() {
          cartItems = loadedCartItems;
        });
      } else {
        print("Status is not OK");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cᴀʀᴛ 🛒'),
        backgroundColor: Colors.transparent,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(40),
                        height: 400,
                        width: 400,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: _buildCard(
                            cartItems[index]['book'],
                            cartItems[index]['genre'],
                            cartItems[index]['author'],
                            cartItems[index]['total'],
                          ),
                          back: _buildCard2(
                            cartItems[index]['phone'],
                            cartItems[index]['place'],
                            cartItems[index]['quantity'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {
                          confirmButton(
                              context, cartItems[0]['oid'].toString());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green[300]!), // Set background color
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Set rounded corners
                            ),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
      drawer: Drawerclass(),
    );
  }

  Widget _buildCard(
      String? book, String? genre, String? author, String? total) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _generateRandomGradientColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Center(
                child: Text(
                  (book ?? '').toUpperCase(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text(
                  genre ?? '',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text(
                  author ?? '',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Center(
                child: Text(
                  total ?? '',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard2(String? phone, String? place, String? quantity) {
    return Container(
      decoration: BoxDecoration(
        gradient: _generateRandomGradientColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text(
                  phone ?? '',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 95, left: 95),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          quantity ?? '',
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.amber[300],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'COUNT',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Text(
                  'Address: ${place ?? ''}',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 21),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _generateRandomGradientColor() {
    Random random = Random();
    int startRed = random.nextInt(128) + 128;
    int startGreen = random.nextInt(128) + 128;
    int startBlue = random.nextInt(128) + 128;
    int endRed = random.nextInt(64) + 192;
    int endGreen = random.nextInt(64) + 192;
    int endBlue = random.nextInt(64) + 192;

    return LinearGradient(
      colors: [
        Color.fromARGB(255, startRed, startGreen, startBlue),
        Colors.white,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  void confirmButton(BuildContext context, String oid) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();

      String url = ip + "and_cartbtn";
      var data = await http.post(Uri.parse(url), body: {'oid': oid});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      if (status == "ok") {
        print('Success');
      } else {
        print('FAILED==============');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
