import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bookies/Drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map<String, String>> orderDetails = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
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
        for (var order in orderData) {
          loadedOrders.add({
            'date': order['date'].toString(),
            'total': order['total'].toString(),
            'id': order['id'].toString(),
          });
        }

        setState(() {
          orderDetails = loadedOrders;
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
        title: Text("Orders"),
      ),
      drawer: Drawerclass(),
      body: orderDetails.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : CarouselSlider.builder(
        itemCount: orderDetails.length,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: false,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return _buildOrderDetailsCard(orderDetails[index]);
        },
      ),
    );
  }

  Widget _buildOrderDetailsCard(Map<String, String> order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 250),
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
        padding: const EdgeInsets.all(70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total: ${order['total']}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Date: ${order['date']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "ID: ${order['id']}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
