import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/helper/theme.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =
      new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
            if(result != null){

              Map<String,String> userDataMap = {
                "userName" : usernameEditingController.text,
                "userEmail" : emailEditingController.text
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
              HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
            }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF73AEF5),
      resizeToAvoidBottomInset: false,
      body: isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :  Container(
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
                      // style: simpleTextStyle(),
                      controller: usernameEditingController,
                      validator: (val){
                        return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                      },
                      // decoration: textFieldInputDecoration("username"),
                      decoration: InputDecoration(
                            hintText: 'Enter your Username',
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
                    SizedBox
                    (
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      controller: emailEditingController,

                      // style: simpleTextStyle(),
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                            null : "Enter correct email";
                      },
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
                            ),
                    ),
                    SizedBox
                    (
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      obscureText: true,
                      // style: simpleTextStyle(),
                      // decoration: textFieldInputDecoration("password"),
                      controller: passwordEditingController,
                      validator:  (val){
                        return val.length < 6 ? "Enter Password 6+ characters" : null;
                      },
                      decoration: InputDecoration(
                            hintText: 'Enter your Password',
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
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 16,
            // ),
            SizedBox
            (
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            FlatButton(
              onPressed: singUp,
              child: Text('Sign Up', style: TextStyle(color: Color(0xFF73AEF5)),),
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              ),
            SizedBox
            (
              height: MediaQuery.of(context).size.height * 0.004,
            ),
            FlatButton(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
            onPressed: ()  {
              
              widget.toggleView();
              // SignIn();
            },
            child:
                const Text('Log In', style: TextStyle(color: Colors.blue)),
            color: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
            // GestureDetector(
            //   onTap: (){
            //     singUp();
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 16),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         gradient: LinearGradient(
            //           colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
            //         )),
            //     width: MediaQuery.of(context).size.width,
            //     child: Text(
            //       "Sign Up",
            //       style: biggerTextStyle(),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 16),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30), color: Colors.white),
            //   width: MediaQuery.of(context).size.width,
            //   child: Text(
            //     "Sign Up with Google",
            //     style: TextStyle(fontSize: 17, color: CustomTheme.textColor),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Already have an account? ",
            //       style: simpleTextStyle(),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         widget.toggleView();
            //       },
            //       child: Text(
            //         "SignIn now",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             decoration: TextDecoration.underline),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 50,
            // )
          ],
        ),
      ),
    );
    ;
  }
}
