import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';


class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  State<AllMoviesScreen> createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:MyAppBar(), 
      body: Center(child: Text("all movies")),);
  }
}