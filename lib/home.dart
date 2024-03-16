import 'package:bookies/discovery.dart';
import 'package:flutter/material.dart';

import 'Drawer.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookies"),
      ),
      drawer: Drawerclass(),
      body: discovery(),
    );
  }
}
