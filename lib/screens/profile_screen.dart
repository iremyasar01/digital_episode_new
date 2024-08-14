import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
//profile ekranında ad soyad istesin maili gçstersin tel no iste.uğdate buttondan ekran yap firebasedem çek
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     body: Center(child: Text("profile")),
      
    );
  }
}