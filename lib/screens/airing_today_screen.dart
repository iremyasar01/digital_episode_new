import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/my_appbar.dart';
import 'package:digital_episode_new/screens/tv_shows_details_screen.dart';
import 'package:digital_episode_new/services/auth.dart';
import 'package:flutter/material.dart';

class AiringTodayScreen extends StatefulWidget {
  const AiringTodayScreen({super.key});

  @override
  AiringTodayScreenState createState() => AiringTodayScreenState();
}

class AiringTodayScreenState extends State<AiringTodayScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 216, 216),
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: ApiService().getShows(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("failed.please try again"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("there are no new series."));
          } else {
            final seriesList = snapshot.data!;
            return ListView.builder(
              itemCount: seriesList.length,
              itemBuilder: (context, index) {
                final series = seriesList[index];
                final seriesId = series.id.toString();
                final name = series.name ?? 'Unknown';
                final posterUrl =
                    "https://image.tmdb.org/t/p/w500${series.posterPath}";

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          posterUrl,
                          width: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 70),
                        ),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 65, 9, 73),
                        ),
                      ),
                      trailing: FutureBuilder<bool>(
                        future: Auth().isFavorite(seriesId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          }
                          final isFav = snapshot.data ?? false;
                          return IconButton(
                            icon: Icon(
                              isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              if (isFav) {
                                await Auth().removeFavorite(seriesId);
                              } else {
                                await Auth().addFavorite(
                                  seriesId: seriesId,
                                  title: name,
                                  posterUrl: posterUrl,
                                );
                              }
                              setState(() {});
                            },
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvShowDetailsScreen(
                              seriesId: series.id!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

                  
            
  
  
                            