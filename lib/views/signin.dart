import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/helper/theme.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/HomePage.dart';
import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/views/forgot_password.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF73AEF5),
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 35),
                    child: Row(children: <Widget>[
                Container(
                    
                    child: Image.asset('lib/images/logo.png'),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.17,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Text(
                    'Fam Meme',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please Enter Correct Email";
                            },
                            controller: emailEditingController,
                            // style: simpleTextStyle(),
                            decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            fillColor: Colors.white,
                            filled: true,
                            errorStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.white, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0)),
                            )
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Enter Password 6+ characters";
                            },
                            // style: simpleTextStyle(),
                            controller: passwordEditingController,
                            decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            fillColor: Colors.white,
                            filled: true,
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            // errorText: validatePassword(_passwordField.text),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.white, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0)),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  FlatButton(
                    onPressed: signIn,
                    child: Text('Log In', style: TextStyle(color: Color(0xFF73AEF5)),),
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    ),
                  // GestureDetector(
                  //   onTap: () {
                  //     signIn();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 16),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30),
                  //         color: Colors.white
                  //         ),
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Text(
                  //       "Log In",
                  //       style: TextStyle(color: Color(0xFF73AEF5)),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.004,
                  ),
                  FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  onPressed: ()  {
                    widget.toggleView();
                  },
                  child:
                      const Text('Signup', style: TextStyle(color: Colors.blue)),
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                  
                
                ],
              ),
            ),
    );
  }
}
