import 'dart:convert';
import 'dart:math';

import 'package:bookies/Drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map<String, String>> orders = [];
  List<Map<String, String>> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewOrderHistory";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      if (status == "ok") {
        var cartData = jsonData["data"];

        List<Map<String, String>> _loadedOrders = [];
        for (var item in cartData) {
          _loadedOrders.add({
            'date': item['date'].toString(),
            'total': item['total'].toString(),
            'id': item['id'].toString(),
          });
        }

        setState(() {
          _orders = _loadedOrders;
        });
      } else {
        print("Status is not OK");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> loadCartItems() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewOrderHistory";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      if (status == "ok") {
        var orderData = jsonData["data"];

        List<Map<String, String>> loadedOrders = [];
        for (var item in orderData) {
          loadedOrders.add({
            'id': item['id'].toString(),
            'rate': item['rate'].toString(),
            'quantity': item['quantity'].toString(),
            'name': item['name'].toString(),
            'author': item['author'].toString(),
            'genre': item['genre'].toString(),
          });
        }

        setState(() {
          orders = loadedOrders;
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
      backgroundColor: Colors.grey[100],
      drawer: Drawerclass(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(letterSpacing: 2, fontFamily: 'mont'),
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height:
              MediaQuery.of(context).size.height, // adjust the height as needed
          aspectRatio: 16 / 9, // adjust the aspect ratio as needed
          enableInfiniteScroll: true,
          autoPlay: true,
          initialPage: 0,
          viewportFraction: 1,
        ),
        items: _orders.map((order) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              // color: Colors.red,
                              //Order ID
                              child: Center(
                                child: Text(
                                  'Order ID: #${order['id']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'mont',
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //Order Date
                              // color: Colors.orange,
                              child: Center(
                                child: Text(
                                  'Order Date: ${order['date']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'mont',
                                      letterSpacing: 2,
                                      color: Colors.grey[400]),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    //First Divider
                    color: Colors.grey[300],
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      //ListView of the items
                      // color: Colors.blue,
                      child: ListView(
                        children: [
                          for (int i = 0; i < orders.length; i++)
                            if (orders[i]['id'] == order['id'])
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Container(
                                  // color: Colors.red,
                                  height: 80,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          // Book Icon
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient:
                                                    _generateRandomGradientColor(),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  //Book Name
                                                  child: Text(
                                                    '${orders[i]['name']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontFamily: 'mont',
                                                        letterSpacing: 2,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                        child: Text(
                                                          //Author
                                                          '${orders[i]['author']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[400],
                                                              letterSpacing: 2,
                                                              fontFamily:
                                                                  'mont',
                                                              fontSize: 12),
                                                        ),
                                                      )),
                                                      VerticalDivider(
                                                        color: Colors.grey[400],
                                                        indent: 2,
                                                        endIndent: 20,
                                                        thickness: 1,
                                                        width: 25,
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        //Genre
                                                        child: Text(
                                                          '${orders[i]['genre']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[400],
                                                              letterSpacing: 2,
                                                              fontFamily:
                                                                  'mont',
                                                              fontSize: 12),
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          // color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  //Price
                                                  // color: Colors.green,
                                                  child: Text(
                                                    '${orders[i]['rate']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 28),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  //Quantity
                                                  // color: Colors.yellow,
                                                  child: Text(
                                                    'qty : ${orders[i]['quantity']}',
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        letterSpacing: 2,
                                                        fontFamily: 'mont',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    //First Divider
                    color: Colors.grey[300],
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //Total Amount
                      // color: Colors.yellow,
                      child: Text(
                        'Total : ${order['total']}/-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'mont',
                            letterSpacing: 2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  _generateRandomGradientColor() {
    Random random = Random();

    // Generate random RGB values for the start color (lighter shades)
    int startRed = random.nextInt(128) + 128; // Red component (128-255)
    int startGreen = random.nextInt(128) + 128; // Green component (128-255)
    int startBlue = random.nextInt(128) + 128; // Blue component (128-255)

    // Create a linear gradient from top to bottom
    return LinearGradient(
      colors: [
        Color.fromARGB(255, startRed, startGreen, startBlue),
        const Color.fromARGB(255, 233, 252, 250),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
