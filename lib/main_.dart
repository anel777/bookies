import 'package:bookies/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {
  runApp(const Bookies());
}

class Bookies extends StatelessWidget {
  const Bookies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: ip(),
    );
  }
}

class ip extends StatefulWidget {
  const ip({super.key});

  @override
  State<ip> createState() => _ipState();
}

class _ipState extends State<ip> {
  TextEditingController ipcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookies"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: ipcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter IP",
                      labelText: "IP Address"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the IP';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        print("Not valid");
                      } else {
                        String ip = ipcontroller.text.toString();
                        final sh = await SharedPreferences.getInstance();
                        sh.setString(("url"), "http://" + ip + ":5000/");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      }
                    },
                    child: Text("Set"))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
