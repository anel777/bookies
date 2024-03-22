import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookies/Drawer.dart';

class Fine extends StatefulWidget {
  @override
  State<Fine> createState() => _FineState();
}

class _FineState extends State<Fine> {
  List<Map<String, String>> fines = [];

  @override
  void initState() {
    super.initState();
    loadFines();
  }

  Future<void> loadFines() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewFineAndPayments";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      if (status == "ok") {
        var fineData = jsonData["data"];

        List<Map<String, String>> loadedFines = [];
        for (var fine in fineData) {
          loadedFines.add({
            'id': fine['id'].toString(),
            'rDate': fine['rDate'].toString(),
            'fine': fine['fine'].toString(),
            'bookNumber': fine['bookNumber'].toString(),
            'status': fine['status'].toString(),
            'bookName': fine['bookName'].toString(),
          });
        }

        setState(() {
          fines = loadedFines;
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
          title: Text("Fine and Payments"),
        ),
        drawer: Drawerclass(),
        body: fines.isEmpty
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        Colors.grey[200], // Background color of the container
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.block, color: Colors.grey), // Empty icon
                      SizedBox(width: 8),
                      Text(
                        "Oops Empty",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16), // Text style
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: fines.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildFineCard(fines[index]);
                },
              ));
  }

  Widget _buildFineCard(Map<String, String> fine) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "ID: #${fine['id']}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                    fontFamily: 'mont'),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UNPAID',
                  style: TextStyle(
                      color: Colors.red[500],
                      letterSpacing: 2,
                      fontFamily: 'mont'),
                ),
                Icon(
                  Icons.money_off,
                  color: Colors.green[400],
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              "${fine['fine']} ₹",
              style: TextStyle(fontSize: 16, letterSpacing: 2),
            ),
            Text(
              "Return Date: ${fine['rDate']}",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${fine['bookName']}".toUpperCase(),
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'mont', letterSpacing: 2),
                ),
                Text(
                  "  |  ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "${fine['bookNumber']}",
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'mont', letterSpacing: 2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
