import 'package:flutter/material.dart';
import 'package:chat_app/component/rounded_Button.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String Password;
  bool showSpinner = false;

  void spinner(bool spin) {
    setState(() {
      showSpinner = spin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecaration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  Password = value;
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecaration.copyWith(
                    hintText: 'Enter Your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              new RoundButton(
                onPressed: () async {
                  spinner(true);
                  try {
                    //  email = 'shawon@gmail.com';
                    //Password = '123456trew';
                    print(
                        '========================firebase============================\n');

                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: Password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    spinner(false);
                  } catch (e) {
                    print(
                        '===========================execption=========================\n');
                    print(e);
                    spinner(false);
                  }
                },
                color: Colors.blueAccent,
                title: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
