import 'package:flutter/material.dart';
import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:digital_episode_new/services/auth.dart'; // Import your Firebase Auth class

class EpisodeScreen extends StatefulWidget {
  final int seriesId;
  final int seasonNumber;

  const EpisodeScreen({super.key, required this.seriesId, required this.seasonNumber});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  // Track the state of checkboxes
  Map<int, bool> watchedEpisodes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: ApiService().getEpisodes(widget.seriesId, widget.seasonNumber),
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
                final episodeId = episode.id.toString();

                // Check if the episode is in the watchlist
                return FutureBuilder<bool>(
                  future: Auth().isInEpisodeWatchlist(episodeId),
                  builder: (context, snapshot) {
                    bool isInWatchlist = snapshot.data ?? false;

                    return CheckboxListTile(
                      title: Text("${episode.name!} -- ${episode.episodeNumber!.toString()}"),
                      subtitle: Text(episode.overview!),
                      value: isInWatchlist,
                      onChanged: (bool? value) async {
                        if (value == true) {
                          // Add to watchlist
                          await Auth().addToEpisodeWatchlist(
                            episodeId: episodeId,
                            title: episode.name!,
                            posterUrl: episode.stillPath ?? '', // Adjust this based on your data
                          );
                        } else {
                          // Remove from watchlist
                          await Auth().removeFromEpisodeWatchlist(episodeId);
                        }
                        setState(() {
                          watchedEpisodes[episode.id!] = value ?? false;
                        });
                      },
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

