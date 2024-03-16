import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookies/Drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
        title: Text("Cart"),
      ),
      drawer: Drawerclass(),
      body: cartItems.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider.builder(
              itemCount: cartItems.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: false,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return _buildCartItemCard(cartItems[index]);
              },
            ),
    );
  }

  Widget _buildCartItemCard(Map<String, String> item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book: ${item['book']}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Total: ${item['total']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Quantity: ${item['quantity']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Genre: ${item['genre']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Author: ${item['author']}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
