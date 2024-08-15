import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';
class AllTvShowsScreen extends StatefulWidget {
  const AllTvShowsScreen({super.key});

  @override
  State<AllTvShowsScreen> createState() => _AllTvShowsScreenState();
}

class _AllTvShowsScreenState extends State<AllTvShowsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold
    (
        appBar:MyAppBar(), 
      body: Center(child: Text("all tv show")),);
  }
}