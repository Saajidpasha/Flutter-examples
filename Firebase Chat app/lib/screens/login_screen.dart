import 'package:flutter/material.dart';
import '../components/roundedButton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreenRoute';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String email;
   String password;
   bool isSpinner = false;
   FirebaseAuth _authInstance = FirebaseAuth.instance;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isSpinner,
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
                   email = value;
                  },
                  decoration:
          kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
          hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    color: Colors.lightBlueAccent,
                    buttonText: 'Log In',
                    onPressed: () async{
          setState(() {
            isSpinner = true;
          });

           try {
            final user =
                await _authInstance.signInWithEmailAndPassword(
                    email: email, password: password);
                    if(user != null){
                      Navigator.of(context).pushNamed(
                        ChatScreen.routeName
                      );
                    }
                    setState(() {
                      isSpinner = false;
                    });
          } catch (e) {
            print(e);
          }
                    }),
              ],
            ),
        ),
      ),
    );
  }
}
