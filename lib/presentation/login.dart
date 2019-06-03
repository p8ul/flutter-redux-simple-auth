import 'package:flutter/material.dart';
import '../utils/index.dart';
import '../models/model.dart';

typedef OnSaveCallback = Function(String username, String email, String password, BuildContext context);

class LoginScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final Login login;

  LoginScreen({Key key, @required this.onSave, @required this.login});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form_key = GlobalKey<FormState>();

  String username;
  String email;
  String password;

  void handleChange(String name, String value) {
    if (name == 'username') {
      setState(() {
        username = value;
      });
    }
    if (name == 'email') {
      setState(() {
        email = value;
      });
    }
    if (name == 'password') {
      setState(() {
        password = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
          key: _form_key,
          child: Container(
            padding: EdgeInsets.all(23.0),
            child: Column(
              children: <Widget>[
                textCenter,
                Text(widget.login.error, style: TextStyle(color: Colors.redAccent),),
                // FormUsernameField(
                //   handleChange: handleChange,
                // ),
                FormEmailField(
                  handleChange: handleChange,
                ),
                FormPasswordField(
                  handleChange: handleChange,
                ),
                SizedBox(
                    width: double.infinity,
                    child: OutlineButton(
                      child: new Text(
                        widget.login.loading ? 'Loading': 'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                      color: Colors.transparent,
                      shape: StadiumBorder(),
                      onPressed: widget.login.loading ? null : () {
                        if (_form_key.currentState.validate()) {
                          _form_key.currentState.save();
                          widget.onSave(username, email, password, context);
                        }
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}

Widget textCenter = Container(
  child: Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
      ),
      Text(
        'HELLO',
        style: TextStyle(
            fontWeight: FontWeight.w800,
            color: HexColor('CF1847'),
            fontSize: 30),
      ),
      Padding(
        padding: EdgeInsets.all(10),
      ),
      Text("Let's start!",
          style: TextStyle(
              color: HexColor('BF16C5'), fontWeight: FontWeight.bold)),
      Padding(
        padding: EdgeInsets.all(5),
      ),
    ],
  ),
);

BoxDecoration inputDecoration = BoxDecoration(
    color: Colors.black12,
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    boxShadow: [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(2, 3),
          blurRadius: 5.0,
          spreadRadius: 2.3)
    ]);

typedef OnChangeCallback = Function(String name, String value);

class FormUsernameField extends StatefulWidget {
  final OnChangeCallback handleChange;
  FormUsernameField({Key key, this.handleChange}) : super(key: key);

  _FormUsernameFieldState createState() => _FormUsernameFieldState();
}

class _FormUsernameFieldState extends State<FormUsernameField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: inputDecoration,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            child: BuildIcon(icon: Icons.person),
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                return value.trim().isEmpty ? 'Please add a username' : null;
              },
              onSaved: (val) => {widget.handleChange('username', val)},
              decoration: const InputDecoration(
                  hintText: 'Username', border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}

class FormEmailField extends StatefulWidget {
  final OnChangeCallback handleChange;

  FormEmailField({Key key, this.handleChange}) : super(key: key);

  _FormEmailFieldState createState() => _FormEmailFieldState();
}

class _FormEmailFieldState extends State<FormEmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: inputDecoration,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            child: BuildIcon(icon: Icons.email),
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
          ),
          Expanded(
            child: TextFormField(
              onSaved: (val) {
                widget.handleChange('email', val);
              },
              validator: (value) {
                return value.trim().isEmpty ? 'Email is required' : null;
              },
              decoration: const InputDecoration(
                  hintText: 'Email', border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}

class FormPasswordField extends StatefulWidget {
  final OnChangeCallback handleChange;

  FormPasswordField({Key key, this.handleChange}) : super(key: key);

  _FormPasswordField createState() => _FormPasswordField();
}

class _FormPasswordField extends State<FormPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: inputDecoration,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            child: BuildIcon(icon: Icons.lock_outline),
            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                return value.trim().isEmpty
                    ? 'Password field is required'
                    : null;
              },
              onSaved: (val) {
                widget.handleChange('password', val);
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuildIcon extends StatelessWidget {
  final IconData icon;
  final List<Color> colors = [
    HexColor('CF1847'),
    HexColor('D7408C'),
  ];
  BuildIcon({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Icon(icon, color: Colors.white,),
    );
  }
}
