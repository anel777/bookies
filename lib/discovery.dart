import 'dart:convert';
import 'dart:math';

import 'package:bookies/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class discovery extends StatefulWidget {
  @override
  _discoveryState createState() => _discoveryState();
}

class _discoveryState extends State<discovery> {
  TextEditingController searchController = TextEditingController();

  List<String> bid_ = <String>[];
  List<String> bookName_ = <String>[];
  List<String> author_ = <String>[];
  List<String> language_ = <String>[];
  List<String> genre_ = <String>[];
  List<String> type_ = <String>[];
  List<String> rate_ = <String>[];
  List<String> bookPlace_ = <String>[];
  List<String> placeName_ = <String>[];

  List<String> review_ = <String>[];
  List<String> date_ = <String>[];
  List<String> rating_ = <String>[];
  List<String> user_ = <String>[];

  List<String> filteredNames = []; //Filter names

  List<Color> tileColors = []; // Store randomly generated colors for tiles

  List<Gradient> gradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.orange, Colors.yellow],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.green],
    ),
    // Add more gradients as needed
  ];

  _discoveryState() {
    load();
  }

  Future<void> load() async {
    List<String> bid = <String>[];
    List<String> bookName = <String>[];
    List<String> author = <String>[];
    List<String> language = <String>[];
    List<String> genre = <String>[];
    List<String> type = <String>[];
    List<String> rate = <String>[];
    List<String> bookPlace = <String>[];
    List<String> placeName = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewBooks";
      print(url);
      var data = await http.post(Uri.parse(url), body: {});

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      //
      // print(arr);
      //
      // print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        //Library
        bid.add(arr[i]['bid'].toString());
        bookName.add(arr[i]['bookName'].toString());
        author.add(arr[i]['author'].toString());
        language.add(arr[i]['language'].toString());
        genre.add(arr[i]['genre'].toString());
        type.add(arr[i]['type'].toString());
        rate.add(arr[i]['rate'].toString());
        bookPlace.add(arr[i]['bookPlace'].toString());
        placeName.add(arr[i]['placeName'].toString());

        // Generate a random color for each tile and store it in the list
      }
      setState(() {
        bid_ = bid;
        bookName_ = bookName;
        author_ = author;
        language_ = language;
        genre_ = genre;
        type_ = type;
        rate_ = rate;
        bookPlace_ = bookPlace;
        placeName_ = placeName;

        filteredNames = List.from(bookName);
      });

      print(placeName_);
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is an error during converting file image to base64 encoding.
    }
    // ... Your existing code for loading complaints ...
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Exᴘʟᴏʀᴇ",
            style: TextStyle(letterSpacing: 2),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            //Search Button
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: GestureDetector(
                //Search Function
                child: Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, bottom: 7, right: 20),
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Child 1 -> Search Books
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Books',
                            hintStyle: TextStyle(
                                color: Colors.grey[600],
                                letterSpacing: 2,
                                fontFamily: 'mots'),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          onChanged: (value) {
                            // Handle text changes here
                          },
                        ),
                      ),

                      //Child 2 -> Search Icon
                      GestureDetector(
                        onTap: () {
                          displaySearchBooks();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.search_rounded,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  child: Text(
                    "Exᴘʟᴏʀᴇ ᴛʜᴇ ʀᴇᴀʟᴍs ᴡɪᴛʜɪɴ ʙᴏᴏᴋs 🍾",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),

            //Stagger View Of Books
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                width: 290,
                height: 530,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: bookName_.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildBookItem(context, index),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 25.0,
                  crossAxisSpacing: 16.0,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawerclass(),
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _showOptionsModal(context, index);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Card(
          elevation: 2.0,
          child: Container(
            //Container For books
            height: 350,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: _generateRandomGradientColor(),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon
                  if (type_[index] == 'Library')
                    Icon(Icons.book, color: Colors.blue[500])
                  else
                    Icon(Icons.shop, color: Colors.red[300]),

                  Text(
                    bookName_[index].toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  //Price of the Book
                  if (type_[index] == 'Bookstall')
                    Text(
                      '${rate_[index].toUpperCase()} ₹',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.green,
                      ),
                    ),

                  SizedBox(height: 10.0),
                  Text(
                    genre_[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontFamily: 'mots'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showOptionsModal(BuildContext context, int index) async {
    List<String> review = <String>[]; //2
    List<String> rating = <String>[];
    List<String> date = <String>[];
    List<String> user = <String>[];

    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("url").toString();

    String url = ip + "and_viewReviews";
    print(url);
    var data = await http.post(
      Uri.parse(url),
      body: {
        'type': type_[index],
        'bid': bid_[index],
      },
    );
    var jsonData = json.decode(data.body);
    String status = jsonData['status'];

    var arr = jsonData["data"];

    for (int i = 0; i < arr.length; i++) {
      //Reviews
      review.add(arr[i]['review'].toString());
      rating.add(arr[i]['rating'].toString());
      date.add(arr[i]['date'].toString());
      user.add(arr[i]['user'].toString());
    }

    setState(() {
      review_ = review;
      rating_ = rating;
      date_ = date;
      user_ = user;
    });

    //The function which runs on tapping a book
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: 600,
            height: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: _generateRandomGradientColor(),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  //Container 1 for Buttons
                  padding: EdgeInsets.all(20),
                  width: 600,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Button1
                      GestureDetector(
                        onTap: () {
                          if (type_[index] == 'Bookstall') {
                            _showOrderDialog(context,
                                bookName_.indexOf(filteredNames[index]));
                          } else {
                            _showPreBookDialog(context,
                                bookName_.indexOf(filteredNames[index]));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: 60,
                          height: 40,
                          child: Center(
                            child: Text(
                              type_[index] == 'Library' ? 'Book' : 'Buy',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      ),
                      //Details
                      Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                //place name
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(
                                  placeName_[index].toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: 180,
                                //address
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text(bookPlace_[index])),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    //Reviews list
                    padding: EdgeInsets.all(10),
                    width: 600,
                    height: 480,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text("Rᴇᴠɪᴇᴡs"),
                        Expanded(
                            child: Container(
                          child: ListView(
                            children: [
                              for (int count = 0;
                                  count < review.length;
                                  count++)
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    //Review Single Container Which is used to build
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 120,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Name Rating and Date
                                              Expanded(
                                                child: Container(
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    user_[count].toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      rating_[count],
                                                      style: TextStyle(
                                                        color:
                                                            Colors.amber[300],
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    date_[count],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: 300,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: Text(review_[count])),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ))
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: review_.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment:
                        //           MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Expanded(
                        //               child: Container(
                        //                 width: 30,
                        //                 height: 20,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius:
                        //                   BorderRadius.circular(15),
                        //                 ),
                        //                 child: Text(
                        //                   user_[index].toUpperCase(),
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Container(
                        //                 width: 30,
                        //                 height: 20,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius:
                        //                   BorderRadius.circular(15),
                        //                 ),
                        //                 child: Center(
                        //                   child: Text(
                        //                     rating_[index],
                        //                     style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.amber[300],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Container(
                        //                 width: 30,
                        //                 height: 20,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius:
                        //                   BorderRadius.circular(15),
                        //                 ),
                        //                 child: Text(
                        //                   date_[index],
                        //                   textAlign: TextAlign.right,
                        //                   style: TextStyle(
                        //                       fontSize: 12,
                        //                       color: Colors.grey),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.all(20),
                        //           width: 400,
                        //           height: 100,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(15),
                        //             color: Colors.grey[200],
                        //           ),
                        //           child: Text(
                        //             review_[index],
                        //             style: TextStyle(fontSize: 12),
                        //           ),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),//End of List View
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  void _showPreBookDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Pre-Booking?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to pre-book ${bookName_[index]}?"),
              SizedBox(height: 16),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ok"),
              onPressed: () async {
                final sh = await SharedPreferences.getInstance();
                String ip = sh.getString("url").toString();
                String lid = sh.getString("lid").toString();

                String url = ip + "and_preBook";

                var data = await http.post(
                  Uri.parse(url),
                  body: {
                    'lid': lid,
                    'bid': bid_[index],
                  },
                );

                var jsonData = json.decode(data.body);
                String status = jsonData['task'].toString();
                if (status == "ok") {
                  Navigator.pop(context);

                  final snackBar = SnackBar(
                    content: Text('Successfully Pre-Booked'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  print("Error");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showOrderDialog(BuildContext context, int index) {
    int quantity = 0;

    double totalPrice = 0.0; // Set a default value for the total price
    print(rate_[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[200]),
                                  //Book Head
                                  child: Center(
                                    child: Text(
                                      '${bookName_[index]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 15),
                                        //Count head
                                        child: Center(
                                          child: Text(
                                            '$quantity',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 15),
                                        //Count
                                        child: Center(
                                          child: Text(
                                            '$quantity',
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.amber[300],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  //Down Arrow
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        if (quantity > 1)
                                          setState(() {
                                            quantity--;
                                            totalPrice =
                                                double.parse(rate_[index]) *
                                                    quantity;
                                          });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),

                                  //Price
                                  child: Center(
                                    child: Text(
                                      '₹${totalPrice}',
                                      style: TextStyle(
                                          color: Colors.amber[300],
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  //Up arrow
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                          totalPrice =
                                              double.parse(rate_[index]) *
                                                  quantity;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final sh = await SharedPreferences.getInstance();
                      String ip = sh.getString("url").toString();
                      String lid = sh.getString("lid").toString();

                      if (quantity == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 200,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Icon(
                                                Icons.warning,
                                                color: Colors.red,
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Check Count',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green[400]),
                                      child: Center(
                                          child: Text(
                                        'OK',
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                        return; // Don't proceed with API call if quantity is 0
                      }

                      String url = ip + "and_addToCart";

                      print(bid_[index]);

                      var data = await http.post(
                        Uri.parse(url),
                        body: {
                          'quantity': quantity.toString(),
                          'lid': lid,
                          'amount': totalPrice.toString(),
                          'bid': bid_[index],
                        },
                      );

                      var jsonData = json.decode(data.body);
                      String status = jsonData['task'].toString();
                      if (status == "ok") {
                        Navigator.pop(context);

                        final snackBar = SnackBar(
                          content: Text('Successfully Ordered'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        print("Error : $status");
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 130,
                      decoration: BoxDecoration(
                          //Add to Cart Button
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> displaySearchBooks() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();

      String url = ip + "and_searchBooks";
      String j = searchController.text.toString();

      var response = await http.post(Uri.parse(url), body: {'j': j});

      var jsonData = json.decode(response.body);
      String status = jsonData['status'];

      if (status == 'ok') {
        // Extract data from the response
        List<dynamic> data = jsonData['data'];
        // Clear existing lists
        setState(() {
          bid_.clear();
          bookName_.clear();
          author_.clear();
          language_.clear();
          genre_.clear();
          type_.clear();
          rate_.clear();
          bookPlace_.clear();
          placeName_.clear();
        });

        for (var item in data) {
          bid_.add(item['bid'].toString());
          bookName_.add(item['bookName'].toString());
          author_.add(item['author'].toString());
          language_.add(item['language'].toString());
          genre_.add(item['genre'].toString());
          type_.add(item['type'].toString());
          rate_.add(item['rate'].toString());
          bookPlace_.add(item['bookPlace'].toString());
          placeName_.add(item['placeName'].toString());
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  LinearGradient _generateRandomGradientColor() {
    Random random = Random();

    // Generate random RGB values for the start color (lighter shades)
    int startRed = random.nextInt(128) + 128; // Red component (128-255)
    int startGreen = random.nextInt(128) + 128; // Green component (128-255)
    int startBlue = random.nextInt(128) + 128; // Blue component (128-255)

    // Generate random RGB values for the end color (even lighter shades)
    int endRed = random.nextInt(64) + 192; // Red component (192-255)
    int endGreen = random.nextInt(64) + 192; // Green component (192-255)
    int endBlue = random.nextInt(64) + 192; // Blue component (192-255)

    // Create a linear gradient from top to bottom
    return LinearGradient(
      colors: [
        Color.fromARGB(255, startRed, startGreen, startBlue), // Start color
        Colors.white // End color
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
