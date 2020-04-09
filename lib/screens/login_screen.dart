import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/customButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingControllerEmail;
  TextEditingController textEditingControllerPassword;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool progressControl = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingControllerEmail = TextEditingController();
    textEditingControllerPassword = TextEditingController();
    textEditingControllerEmail.text = "ozanbatusss@gmail.com";
    textEditingControllerPassword.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: progressControl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  controller: textEditingControllerEmail,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kRegistrationTextFieldDecoration.copyWith(
                      hintText: "Enter your email"),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    controller: textEditingControllerPassword,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kRegistrationTextFieldDecoration.copyWith(
                        hintText: "Enter your password"),
                    style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 24.0,
                ),
                CustomButton(
                  color: Colors.lightBlueAccent,
                  function: () async {
                    setState(() {
                      progressControl = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: textEditingControllerEmail.text,
                          password: textEditingControllerPassword.text);
                      if (user != null) {
                        Navigator.pushNamed(context, '/chat');
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        progressControl = false;
                      });
                    }
                    setState(() {
                      progressControl = false;
                    });
                  },
                  text: 'Log in',
                  textStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
