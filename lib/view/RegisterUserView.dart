import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/service/user_api.dart';

class RegisterUserView extends StatefulWidget {
  @override
  _RegisterUserViewState createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  String _username, _email, _password, _phone, _address;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
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
                  _showUserName(),
                  _showEmail(),
                  _showPassword(),
                  _showPhone(),
                  _showAddress(),
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
      'Register',
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _showUserName() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: nameController,
        validator: (val) => val.length < 6 ? 'Username is too short' : null,
        onSaved: (val) => _username = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            hintText: 'Enter Username, Minimum Of Lenght 6',
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            )),
      ),
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
        obscureText: true,
        decoration: InputDecoration(
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

  Widget _showPhone() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: phoneController,
        onSaved: (val) => _phone = val,
        validator: (val) => val.length < 6 ? 'Phone is too short' : null,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone',
            hintText: 'Enter Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showAddress() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: addressController,
        onSaved: (val) => _address = val,
        validator: (val) => val.length < 6 ? 'Address is too short' : null,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
            hintText: 'Enter Address',
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
              debugPrint('Register Pressed');
              _onSubmit();
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          FlatButton(
            onPressed: () {
              debugPrint('Login clicked');
              Navigator.pushNamed(context, '/login_user');
            },
            child: Text(
              'Existing User ? Login',
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() async{
    final form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      debugPrint('valid');
      debugPrint(
          'Username : $_username, Email : $_email, Password : $_password');
      var name = nameController.text;
      var email = emailController.text;
      var password = passwordController.text;
      var phone = phoneController.text;
      var address = addressController.text;

      setState(() {
        message = 'Please wait......';
      });
      var rsp = await registerUser(name, email, password, phone, address);
      print(rsp);
      if (rsp.containsKey('status')) {
        if (rsp['status'] == 1) {
          setState(() {
            message = rsp['status_text'];
          });
          if (rsp['status'] == 1) {
            Navigator.pushNamed(context, '/login_user');
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
