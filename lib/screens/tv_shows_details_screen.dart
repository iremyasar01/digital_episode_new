import 'package:digital_episode_new/screens/episode_screen.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';
import 'package:digital_episode_new/services/api_service.dart';

class TvShowDetailsScreen extends StatelessWidget {
  final int seriesId;

  const TvShowDetailsScreen({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: ApiService().getSeasons(seriesId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed. Please try again."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("There are no seasons."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final season = snapshot.data![index];
                return ListTile(
                  title: Text(season.name),
                  subtitle: Text('${season.episodeCount} episodes'),
                  onTap: () {
              Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const EpisodeScreen(tvEpisodeGroupId: 'your_episode_group_id'),
  ),

               
                      
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
