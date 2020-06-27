import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/HomeUserView.dart';
import 'package:flutter_ecommerce/view/IndexView.dart';
import 'package:flutter_ecommerce/view/LoginUserView.dart';
import 'package:flutter_ecommerce/view/RegisterUserView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ECommerce',
      initialRoute: '/',
      routes: {
        '/': (context) => IndexView(),
        '/register_user': (context) => RegisterUserView(),
        '/login_user': (context) => LoginUserView(),
        '/home_user': (context) => HomeUserView(),
      },
    );
  }
}
