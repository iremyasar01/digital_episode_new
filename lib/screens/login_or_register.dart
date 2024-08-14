import 'package:digital_episode_new/screens/home_screen.dart';
import 'package:digital_episode_new/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
      if(snapshot.hasData){
        return const HomeScreen();
      }
      else{
        return const LoginScreen();
      }
      }),
    );
    
  }
}