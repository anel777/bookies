import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookies/Drawer.dart';

class RenewStatus extends StatefulWidget {
  @override
  _RenewStatusState createState() => _RenewStatusState();
}

class _RenewStatusState extends State<RenewStatus> {
  List<Map<String, String>> bookStatus = [];

  @override
  void initState() {
    super.initState();
    loadBookStatus();
  }

  Future<void> loadBookStatus() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_bookstatus";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      if (status == "ok") {
        var statusData = jsonData["data"];

        List<Map<String, String>> loadedStatus = [];
        for (var statusItem in statusData) {
          loadedStatus.add({
            'bookName': statusItem['bookName'].toString(),
            'bookId': statusItem['bookId'].toString(),
            'status': statusItem['status'].toString(),
            'id': statusItem['id'].toString(),
            'date': statusItem['date'].toString(),
          });
        }

        setState(() {
          bookStatus = loadedStatus;
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sᴛᴀᴛᴜs"),
      ),
      drawer: Drawerclass(),
      body: bookStatus.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider.builder(
              itemCount: bookStatus.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: false,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return _buildBookStatusCard(bookStatus[index]);
              },
            ),
    );
  }

  Widget _buildBookStatusCard(Map<String, String> status) {
    Color containerColor;
    IconData statusIcon;

    switch (status['status']) {
      case 'Rejected':
        containerColor = Colors.red;
        statusIcon = Icons.close; // Cross mark icon for rejected
        break;
      case 'pending':
        containerColor = Colors.blue;
        statusIcon = Icons
            .mode_comment; // Comment or any other suitable icon for pending
        break;
      case 'renewed':
        containerColor = Colors.green;
        statusIcon = Icons.bookmark; // Bookmark icon for accepted
        break;
      default:
        containerColor = Colors.black;
        statusIcon = Icons.error; // Default icon for other statuses
    }

    return Padding(
      padding: const EdgeInsets.only(top: 150, bottom: 150),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                radius: 0.8, colors: [Colors.white, containerColor]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              statusIcon,
              color: containerColor,
              size: 80,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "${status['bookName']}".toUpperCase(),
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              "${status['status']}",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "${status['id']}",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "${status['date']}",
              style: TextStyle(color: Color.fromRGBO(243, 85, 85, 1)),
            )
          ],
        ),
      ),
    );
  }
}
