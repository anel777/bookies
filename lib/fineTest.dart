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
              child: CircularProgressIndicator(),
            )
          : CarouselSlider.builder(
              itemCount: fines.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: false,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return _buildFineCard(fines[index]);
              },
            ),
    );
  }

  Widget _buildFineCard(Map<String, String> fine) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 200),
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
              "ID: ${fine['id']}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Status: ${fine['status']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Fine: ${fine['fine']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Return Date: ${fine['rDate']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Book Number: ${fine['bookNumber']}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
