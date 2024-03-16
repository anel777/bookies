import 'dart:convert';

import 'package:bookies/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class fine extends StatefulWidget {
  @override
  State<fine> createState() => _fineState();
}

class _fineState extends State<fine> {
  List<String> fid_ = <String>[];
  List<String> rdate_ = <String>[];
  List<String> fine_ = <String>[];
  List<String> bookNumber_ = <String>[];
  List<String> sts_ = <String>[];

  _fineState() {
    load();
  }

  Future<void> load() async {
    List<String> fid = <String>[];
    List<String> rdate = <String>[];
    List<String> fine = <String>[];
    List<String> bookNumber = <String>[];
    List<String> sts = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewFineAndPayments";
      print(url);
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      //
      // print(arr);
      //
      // print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        fid.add(arr[i]['id'].toString());
        rdate.add(arr[i]['rDate'].toString());
        fine.add(arr[i]['fine'].toString());
        bookNumber.add(arr[i]['bookNumber'].toString());
        sts.add(arr[i]['status'].toString());
      }
      setState(() {
        fid_ = fid;
        rdate_ = rdate;
        fine_ = fine;
        bookNumber_ = bookNumber;
        sts_ = sts;
      });
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is an error during converting file image to base64 encoding.
    }
    // ... Your existing code for loading complaints ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fine and Payments"),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/rating1.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: fid_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(" ID")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(fid_[index])],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Status")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(sts_[index])],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Fine")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(fine_[index])],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Return Date")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(rdate_[index])],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Book Number")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(bookNumber_[index])],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 20,
                        margin: EdgeInsets.all(25),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: Drawerclass(),
    );
  }
}
