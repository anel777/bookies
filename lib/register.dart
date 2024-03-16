import 'dart:convert';
import 'package:bookies/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  final RegExp nameRegExp = RegExp(r'^[A-Za-z ]{2,25}$');
  final RegExp placeRegExp = RegExp(r'^[A-Za-z0-9]{2,25}$');
  final RegExp postRegExp = RegExp(r'^[A-Za-z0-9]{2,25}$');
  final RegExp pinRegExp = RegExp(r'^[0-9]{6}$');
  final RegExp emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$');
  final RegExp _phoneReguser = RegExp(r'^[6789]\d{9}$');
  final RegExp UnameRegExp = RegExp(r'^[A-Za-z]{3,25}$');
  XFile? _image;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Signup Here",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffdbd8cd),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(_image!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your lastname';
                          } else if (!nameRegExp.hasMatch(value)) {
                            return 'Name must be between 1 and 25 characters, including uppercase and lowercase letters';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: placeController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Place",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your place';
                          } else if (!placeRegExp.hasMatch(value)) {
                            return 'Must consist of letters with more than 3 characters.';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: postController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Post",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your post';
                          } else if (!postRegExp.hasMatch(value)) {
                            return 'Post may consist of alphabets and numbers.';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: pinController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "pin",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your pin';
                          } else if (!pinRegExp.hasMatch(value)) {
                            return 'Must consist of exactly 6 numeric digits.';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Phone",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone no';
                          } else if (!_phoneReguser.hasMatch(value)) {
                            return 'Enter 10 digit valid phone number';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Email address Must contain characters with @ and .';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          } else if (!UnameRegExp.hasMatch(value)) {
                            return 'Username must contain more than 3 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            print("Not validated");
                          } else if (_image == null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please select an image.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          } else {
                            final sh = await SharedPreferences.getInstance();
                            String name = nameController.text.toString();
                            String place = placeController.text.toString();
                            String post = postController.text.toString();
                            String pin = pinController.text.toString();
                            String phone = phoneController.text.toString();
                            String email = emailController.text.toString();
                            String uname = usernameController.text.toString();
                            String pswd = passwordController.text.toString();
                            final bytes = File(_image!.path).readAsBytesSync();
                            String base64Image = base64Encode(bytes);
                            String url = sh.getString("url").toString();

                            var data = await http.post(
                              Uri.parse(url + "and_registration"),
                              body: {
                                'name': name,
                                "place": place,
                                "post": post,
                                "pin": pin,
                                "phone": phone,
                                "email": email,
                                "username": uname,
                                "password": pswd,
                                "photo": base64Image,
                              },
                            );

                            var jasondata = json.decode(data.body);
                            String status = jasondata['task'].toString();

                            if (status == "ok") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Successfully Registered'),
                                  duration: Duration(seconds: 4),
                                ),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            }
                          }
                        },
                        icon: Icon(Icons.send),
                        label: Text('Submit'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF6ADC50),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
