import 'dart:convert';
import 'package:bookies/fine.dart';
import 'package:bookies/home.dart';
import 'package:http/http.dart' as http;
import 'package:bookies/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class renew extends StatefulWidget {
  @override
  _renewState createState() => _renewState();
}

class _renewState extends State<renew> {
  List<String> bookName_ = <String>[];
  List<String> bookId_ = <String>[];
  List<String> date_ = <String>[];
  List<String> returnDate_ = <String>[];
  List<String> fine_ = <String>[];
  List<String> sts_ = <String>[];
  List<String> issueid_ = <String>[];

  _renewState() {
    load();
  }

  Future<void> load() async {
    List<String> bookName = <String>[];
    List<String> bookId = <String>[];
    List<String> date = <String>[];
    List<String> returnDate = <String>[];
    List<String> fine = <String>[];
    List<String> sts = <String>[];
    List<String> issueid = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_renew";
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
        bookName.add(arr[i]['bookName'].toString());
        date.add(arr[i]['date'].toString());
        bookId.add(arr[i]['bookId'].toString());
        returnDate.add(arr[i]['returnDate'].toString());
        fine.add(arr[i]['fine'].toString());
        sts.add(arr[i]['status'].toString());
        issueid.add(arr[i]['id'].toString());
      }

      setState(() {
        bookName_ = bookName;
        date_ = date;
        bookId_ = bookId;
        returnDate_ = returnDate;
        fine_ = fine;
        sts_ = sts;
        issueid_ = issueid;
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
        title: Text("Renew Books"),
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
          itemCount: bookName_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 300,
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
                                    children: [Text("Book name")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(bookName_[index])],
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
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Date")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(date_[index])],
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
                                    children: [Text("Book Id")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(bookId_[index])],
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
                                    children: [Text(returnDate_[index])],
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
                                ElevatedButton(
                                    onPressed: () async {
                                      final pref = await SharedPreferences.getInstance();

                                      String ip = pref.getString("url").toString();

                                      String url = ip + "and_renewbtn";
                                      print(url);
                                      var data = await http.post(Uri.parse(url), body: {'bid': issueid_[index]});

                                      var jsondata = json.decode(data.body);
                                      String status = jsondata['status'];

                                      if (status == "ok") {
                                        _showAlertDialog(context);


                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Renew Failed'),
                                              content:
                                              Text('Please try again.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text("Renew"))
                              ],
                            )
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

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Renew request sent successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => renew(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
