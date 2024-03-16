import 'dart:convert';

import 'package:bookies/home.dart';
import 'package:http/http.dart' as http;
import 'package:bookies/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class orders extends StatefulWidget {
  const orders({super.key});

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {
  List<Map<String, String>> orders = [];

  @override
  void initState() {
    super.initState();
    loadFacilities();
  }

  Future<void> loadFacilities() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewOrderHistory";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      var orderData = jsonData["data"];

      List<Map<String, String>> loadedOrders = [];
      for (var order in orderData) {
        loadedOrders.add({
          'data': order['date'].toString(),
          'total': order['total'].toString(),
          'id': order['id'].toString(),
        });
      }

      setState(() {
        orders = loadedOrders;
      });

      print(jsonData['data']+"++++++++++++++++++++++++++++++++");
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: WillPopScope(
        child: Stack(
          children: [
            // Background image
            Container(),
            // Your existing body content
            Container(
              child: orders.isNotEmpty
                  ? ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text("Total: ${orders[index]['order']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date: ${orders[index]['date']}"),
                              Text("Description: ${orders[index]['id']}"),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("No Orders Found"),
                    ),
            ),
          ],
        ),
        onWillPop: () async {
          // Handle the back button press or pop gesture here
          // bool shouldPop = await showExitConfirmationDialog(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => home()));
          return true;
        },
      ),
      drawer: Drawerclass(),
    );
  }
}
