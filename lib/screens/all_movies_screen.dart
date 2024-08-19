import 'package:digital_episode_new/services/api_service.dart';
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
    return  Scaffold(
      appBar: const MyAppBar(), 
      body: Center(
       child:FutureBuilder(future: ApiService().getAllMovies(), builder: (context, snapshot) {
          if(snapshot.hasData){
        return ListView.builder(
          itemCount:snapshot.data!.length ,
          itemBuilder: (context, index) {
            return Text(snapshot.data![index].title.toString());
          }
        );

          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");

          }
          return const CircularProgressIndicator();
        },),
      ),
    );
  }
}