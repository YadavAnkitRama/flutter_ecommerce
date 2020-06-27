import 'package:flutter/material.dart';

class HomeUserView extends StatefulWidget {
  @override
  _HomeUserViewState createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text(
          'Shop Here'
        ),
      ),
    );
  }
}