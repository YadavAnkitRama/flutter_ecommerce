import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/service/user_api.dart';

class LoginUserView extends StatefulWidget {
  @override
  _LoginUserViewState createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecure = true;
  String _email, _password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showTitle(),
                  _showEmail(),
                  _showPassword(),
                  Text(message),
                  _showButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTitle() {
    return Text(
      'Login',
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _showEmail() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: emailController,
        onSaved: (val) => _email = val,
        validator: (val) => !val.contains('@') ? 'Email is Invalid' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter Valid Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showPassword() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: passwordController,
        onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? 'Password is too short' : null,
        obscureText: _obsecure,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              child: Icon(
                _obsecure ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showButtons() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.indigo[800],
            onPressed: () {
              debugPrint('Login Pressed');
              _onSubmit();
            },
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          FlatButton(
              onPressed: () {
                debugPrint('Register clicked');
                Navigator.pushNamed(context, '/register_user');
              },
              child: Text(
                'first Tine User ? Register yourself',
              )),
        ],
      ),
    );
  }

  void _onSubmit() async {
    final form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      debugPrint('valid');
      debugPrint('Email : $_email, Password : $_password');
      
      var email = emailController.text;
      var password = passwordController.text;
      setState(() {
        message = 'Please wait......';
      });
      var rsp = await loginUser(email, password);
      print(email);
      print(password);
      print(rsp);
      if (rsp.containsKey('status')) {
        if (rsp['status'] == 1) {
          setState(() {
            message = rsp['status_text'];
          });
          if (rsp['status'] == 1) {
            Navigator.pushNamed(context, '/home_user');
          }
        } else {
          setState(() {
            message = 'Login Failed, Please Try Again';
          });
        }
      }
    } else {
      debugPrint('Invalid');
    }
  }
}
