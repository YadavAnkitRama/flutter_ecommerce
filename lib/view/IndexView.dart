import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/LoginUserView.dart';

class IndexView extends StatefulWidget {
  @override
  _IndexViewState createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginUserView(),
    );
  }
}