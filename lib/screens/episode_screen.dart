import 'package:flutter/material.dart';
import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';

class EpisodeScreen extends StatelessWidget {
  final String tvEpisodeGroupId;

  const EpisodeScreen({super.key, required this.tvEpisodeGroupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: ApiService().getEpisodes(tvEpisodeGroupId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("There are no episodes."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final episode = snapshot.data![index];
                return CheckboxListTile(
                  title: Text("${episode.name!} -- ${episode.episodeNumber!.toString()}"),
                  subtitle: Text(episode.overview!),
                  value: false, // Bu değeri daha sonra güncelleyebilirsin
                  onChanged: (bool? value) {
                    // Checkbox değişimini burada yönetebilirsin
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

