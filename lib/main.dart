import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {
  runApp(const Bookies());
}

class Bookies extends StatelessWidget {
  const Bookies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: IPPage(), // Set the IPPage as the home screen
    );
  }
}

class IPPage extends StatefulWidget {
  const IPPage({Key? key}) : super(key: key);

  @override
  State<IPPage> createState() => _IPPageState();
}

class _IPPageState extends State<IPPage> {
  TextEditingController ipController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookies"),
        backgroundColor: Colors.yellow.shade200,
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
                    controller: ipController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter IP",
                      labelText: "IP Address",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the IP';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        print("Not valid");
                      } else {
                        String ip = ipController.text.toString();
                        final sh = await SharedPreferences.getInstance();
                        sh.setString(("url"), "http://" + ip + ":5000/");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      }
                    },
                    child: Text("Set"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
