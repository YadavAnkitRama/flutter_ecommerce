import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/service/user_api.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class LoginUserView extends StatefulWidget {
  @override
  _LoginUserViewState createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obsecure = true;
  String _email, _password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  AnimationController _animationController;
  Animation<Color> _colorTween;

  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1800),
      vsync: this,
    );
    _colorTween = _animationController
        .drive(ColorTween(begin: Colors.white, end: Colors.indigo[900]));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true, isDismissible: false);
    pr.style(message: 'checking, Please wait...');
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
                  //_showMessage(),
                  _showButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showMessage() {
    return Text(message);
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
              color: Colors.indigo[900],
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo[900],
            )
          ),
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
            
            labelText: 'Password',
            hintText: 'Enter Password',
            icon: Icon(
              Icons.lock,
              color: Colors.indigo[900],
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
            color: Colors.indigo[900],
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
      pr.show();
      form.save();
      //debugPrint('valid');
      debugPrint('Email : $_email, Password : $_password');

      var email = emailController.text;
      var password = passwordController.text;
      // setState(() {
      //   message = 'Please wait......';
      // });
      var rsp = await loginUser(email, password);
      print(rsp);
      if (rsp.containsKey('status')) {
        if (rsp['status'] == 1) {
          // setState(() {
          //   message = rsp['status_text'];
          // });
          if (rsp['status'] == 1) {
            Future.delayed(Duration(seconds: 0)).then((value) {
              pr.hide().whenComplete(() {
                debugPrint('Success PD Stopped');
                Navigator.pushNamed(context, '/home_user');
              });
            });
          }
        } else {
          Future.delayed(Duration(seconds: 0)).then((value) {
            pr.hide().whenComplete(() {
              setState(() {
                message = 'Login Failed, Please Try Again';
              });
            });
          });
        }
      }
    } else {
      debugPrint('Invalid');
    }
  }
}
