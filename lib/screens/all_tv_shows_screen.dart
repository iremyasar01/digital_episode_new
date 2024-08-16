import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';
class AllTvShowsScreen extends StatelessWidget {
  const AllTvShowsScreen({super.key});



  @override
  Widget build(BuildContext context) {
      ApiService apiService =ApiService();
    return  Scaffold
    (
        appBar: const MyAppBar(), 
      body: Center(
        child:FutureBuilder(future: apiService.getShows(), builder: (context, snapshot) {
          if(snapshot.hasData){
        return ListView.builder(
          itemCount:snapshot.data!.length ,
          itemBuilder: (context, index) {
            return Text(snapshot.data![index].name.toString());
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