import 'package:flutter/material.dart';
import 'package:garagesale2/service/auth_service.dart';
import 'package:garagesale2/share/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServise _auth = AuthServise();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error ='';


  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  @override
  Widget build(BuildContext context) {

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{
          if (_formKey.currentState.validate()){
            dynamic result = await _auth.signInWithEmailAndPassword(email, password);

            if(result == null) {
              setState(() {
                error = 'could not sign in with those credentials';
              });
            }
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign in to Garage Sale"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();

              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                  'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  decoration: TextDeco2().getDeco().copyWith(hintText: 'Email'),
                  validator: (value) {
                    return value.isEmpty ? 'Enter the Email' : null;
                  },
                  onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: TextDeco2().getDeco().copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) => value.length < 6 ? 'Enter Password 6+ Char Long' : null,
                  onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                  },
                ),
                SizedBox(height: 20.0,),

                loginButton,
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )

              ],
            ),
          )
        ),
      )
    );
  }
}
