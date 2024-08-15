import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';

class NewSeriesScreen extends StatefulWidget {
  const NewSeriesScreen({super.key});

  @override
  State<NewSeriesScreen> createState() => _NewSeriesScreenState();
}

class _NewSeriesScreenState extends State<NewSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar:MyAppBar(), 
      body: Center(child: Text("new series")),);
  }
}