import 'dart:convert';

import 'package:bookies/Drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Renew extends StatefulWidget {
  const Renew({super.key});

  @override
  State<Renew> createState() => _RenewState();
}

class _RenewState extends State<Renew> {
  final TextEditingController reviewController = TextEditingController();

  List<Map<String, String>> bookDetails = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_renew";
      var data = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      List<Map<String, String>> details = [];
      for (int i = 0; i < arr.length; i++) {
        Map<String, String> book = {
          'bookName': arr[i]['bookName'].toString(),
          'date': arr[i]['date'].toString(),
          'bookId': arr[i]['bookId'].toString(),
          'returnDate': arr[i]['returnDate'].toString(),
          'fine': arr[i]['fine'].toString(),
          'status': arr[i]['status'].toString(),
          'issueid': arr[i]['id'].toString(),
          'author': arr[i]['author'].toString(),
          'genre': arr[i]['genre'].toString(),
        };
        details.add(book);
      }

      setState(() {
        bookDetails = details;
      });
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rᴇɴᴇᴡ'),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(height: 500),
          items: [
            for (int count = 0; count < bookDetails.length; count++)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Container1 -> Name

                        Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Name
                              Container(
                                height: 70,
                                width: 100,
                                child: Center(
                                    child: Text(
                                  bookDetails[count]['bookName']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Checkbox.width),
                                )),
                              ),
                              //Columns (Author and Genre)
                              Container(
                                height: 70,
                                width: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Container(
                                          child: Text(
                                            bookDetails[count]['genre']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          bookDetails[count]['author']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Container2 -> Details
                        Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    //Return date Text
                                    child: Text(
                                      'RETURN DATE' //return date
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Text(
                                      bookDetails[count]['returnDate']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.green),
                                    ),
                                  ),
                                ), //Return Date
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          bookDetails[count]['fine']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ) // Fine amount
                              ],
                            ),
                          ),
                        ),

                        //Container3 -> Buttons
                        GestureDetector(
                          onTap: () {
                            ReviewPopUp(
                                context, bookDetails[count]['issueid']!);
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Button For Renew

                                Container(
                                  height: 50,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.amber[300],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    'Review',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ),
                                //Button For Review
                                GestureDetector(
                                  onTap: () {
                                    if (bookDetails[count]
                                            .containsKey('issueid') &&
                                        bookDetails[count]['issueid'] != null) {
                                      _renewBook(context,
                                          bookDetails[count]['issueid']!);
                                    } else {
                                      print('Issue ID is missing or null');
                                      // Handle the case where issue ID is missing or null
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.green[300],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      'Renew',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
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
              ),
          ],
        ),
      ),
      drawer: Drawerclass(),
    );
  }

  void _renewBook(BuildContext context, String issueId) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();

      String url = ip + "and_renewbtn";
      var data = await http.post(Uri.parse(url), body: {'bid': issueId});

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
              content: Text('Please try again.'),
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
    } catch (e) {
      print("Error: $e");
    }
  }

  void _reviewBook(
      BuildContext context, String bid, String review, double rating) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String lid = pref.getString("lid").toString();

      String url = ip + "and_reviewbtn";
      var data = await http.post(Uri.parse(url), body: {
        'bid': bid,
        'review': review,
        'rating': rating.toString(),
        'lid': lid
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      if (status == "ok") {
        print("Success");
        _showSuccessDialog(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Review Failed to Submit',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      print("Error: $e");
    }
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
                    builder: (context) => Renew(),
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

  void ReviewPopUp(BuildContext context, String _bid) {
    TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double _rating = 3;
        String review = 'Null';
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Material(
            // Wrap the content with Material widget
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLines: 3,
                  maxLength: 120,
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintMaxLines: 20,
                    hintText: 'Enter your review...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                  },
                  onRatingUpdate: (rating) {
                    print('rating $rating');
                    _rating = rating;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    review = reviewController.text;
                    _reviewBook(context, _bid, review, _rating);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.amber[300]!), // Set background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Set rounded corners
                      ),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Reviewed Successfully",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
