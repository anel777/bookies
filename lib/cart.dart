import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookies/Drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> book_ = <String>[];
  List<String> quantity_ = <String>[];
  List<String> total_ = <String>[];
  List<String> genre_ = <String>[];
  List<String> author_ = <String>[];

  _CartPageState() {
    load();
  }

  Future<void> load() async {
    List<String> book = <String>[];
    List<String> quantity = <String>[];
    List<String> total = <String>[];
    List<String> genre = <String>[];
    List<String> author = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();

      String url = ip + "and_viewCart";
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
        book.add(arr[i]['book'].toString());
        quantity.add(arr[i]['quantity'].toString());
        total.add(arr[i]['total'].toString());
        genre.add(arr[i]['genre'].toString());
        author.add(arr[i]['author'].toString());
      }
      setState(() {
        book_ = book;
        quantity_ = quantity;
        total_ = total;
        genre_ = genre;
        author_ = author;
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
        title: Text("Cart"),
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
          itemCount: book_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                                    children: [Text(book_[index])],
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
                                    children: [Text("Total")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(total_[index])],
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
                                    children: [Text("Quantity")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(quantity_[index])],
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
                                    children: [Text("Genre")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(genre_[index])],
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
                                    children: [Text("Author")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(author_[index])],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
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
