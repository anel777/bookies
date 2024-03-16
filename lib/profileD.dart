import 'dart:convert';

import 'package:bookies/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => profileViewState();
}

class profileViewState extends State<profileView> {
  final String ip = '';

  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

// String ip = (await SharedPreferences.getInstance()).getString("url").toString();

  Future<void> fetchUserProfile() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip.endsWith("/") ? ip : ip + "/";
      url += "and_updateView";
      var data = await http.post(Uri.parse(url), body: {'lid': lid, "ip": ip});

      print("++++++Raw Data: ${data.body}");

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      if (status == "ok") {
        Map<String, dynamic> responseData = jsondata['data'];
        setState(() {
          userData = responseData;
          ip = pref.getString("url") ?? '';
        });
      } else {
        print('Failed to fetch user profile data');
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
        title: Text(
          'Pʀᴏғɪʟᴇ',
          style: TextStyle(letterSpacing: 2),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.white,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 200,
                    width: 200,
                    //For Profile Pic
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.purple, width: 4)),
                    child: Center(
                      child: ClipOval(
                        child: Image.network(
                          "${userData['img'] ?? ''}",
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, StackTrace) {
                            return Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  //Container to Preview Username and password
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurpleAccent[100],
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  '${userData['username'] ?? ''}',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 28),
                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Icon(Icons.remove_red_eye)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  //Container to preview other details
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurpleAccent[100],
                      ),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['name'] ?? ''}'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['phone'] ?? ''}',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['email'] ?? ''}',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['place'] ?? ''}'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['post'] ?? ''}'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            width: BorderSide.strokeAlignCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '${userData['pin'] ?? ''}',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      drawer: Drawerclass(),
    );
  }
}
