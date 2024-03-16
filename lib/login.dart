import 'package:bookies/discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register.dart';


import 'home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookies Login'),
        backgroundColor: CupertinoColors.systemGrey,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: username_controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    // Adjust the horizontal padding
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Username';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: password_controller,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  // Indicates that this is a password field
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    // Adjust the horizontal padding
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Password';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            print("Not valid");
                          } else {
                            String username =
                                username_controller.text.toString();
                            String password =
                                password_controller.text.toString();

                            final sh = await SharedPreferences.getInstance();

                            String url = sh.getString("url").toString();

                            var data = await http.post(
                              Uri.parse(url + "and_login"),
                              body: {
                                'username': username,
                                "password": password,
                              },
                            );

                            var jasondata = json.decode(data.body);
                            String status = jasondata['status'].toString();

                            if (status == "valid") {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text("Logged in"),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              String lid = jasondata['lid'].toString();
                              sh.setString("lid", lid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => discovery(),
                                ),
                              );

                            } else {
                              // Show an error message for invalid username or password
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Login Failed'),
                                    content: Text(
                                        'Invalid username or password. Please try again.'),
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
                          }                        },
                        child: Text('Login'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registration()),
                          );
                        },
                        child: Text('Sign Up'),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
