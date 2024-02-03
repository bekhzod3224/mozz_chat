
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mozz_chat/api/api.dart';
import 'package:mozz_chat/app/home/home-page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  _handleGoogleSignIn(){
       showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
    signInWithGoogle().then((user) async {
      //for hiding progress bar
      // Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
         
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }), (route) => false);
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }), (route) => false);
          });
        }
      }
    });
    
  }

  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              

              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisSize:  MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          child: Image.asset("assets/google.png", )),
                        TextButton(onPressed: (){
                          _handleGoogleSignIn();
                        }, child: Text("Google Auth", style: TextStyle(color: Colors.white, fontSize: 18),)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}