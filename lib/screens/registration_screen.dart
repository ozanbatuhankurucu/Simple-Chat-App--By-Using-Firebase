import 'package:flash_chat/components/customButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool progressControl = false;

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
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kRegistrationTextFieldDecoration.copyWith(
                        hintText: "Enter your email"),
                    style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
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
                  color: Colors.blueAccent,
                  function: () async {
                    setState(() {
                      progressControl = true;
                    });
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, '/chat');
                        print(email + " " + password);
                      } else {}
                    } catch (e) {
                      print(e);
                      setState(() {
                        progressControl = false;
                      });
                    }
                  },
                  text: 'Register',
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
