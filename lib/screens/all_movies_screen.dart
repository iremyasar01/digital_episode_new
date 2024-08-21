import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/services/auth.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';
 // Ensure this import is correct

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  AllMoviesScreenState createState() => AllMoviesScreenState();
}

class AllMoviesScreenState extends State<AllMoviesScreen> {
final Auth auth = Auth();

  // Check if the movie is a favorite
  Future<bool> isFavorite(String movieId) async {
    return await auth.isFavoriteMovie(movieId);
  }

  // Add movie to favorites
  Future<void> addFavorite(String movieId, String name, String posterUrl) async {
    await auth.addFavoriteMovie(movieId: movieId, title: name, posterUrl: posterUrl);
  }

  // Remove movie from favorites
  Future<void> removeFavorite(String movieId) async {
    await auth.removeFavoriteMovie(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: ApiService().getAllMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed. Please try again."));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("There are no movies."));
              } else {
                return Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    String posterUrl = "https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}";
                    String name = snapshot.data![index].title!;
                    String movieId = snapshot.data![index].id.toString();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              posterUrl,
                              height: 70,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 65, 9, 73),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: isFavorite(movieId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              bool isFav = snapshot.data ?? false;
                              return GestureDetector(
                                onTap: () async {
                                  if (isFav) {
                                    await removeFavorite(movieId);
                                  } else {
                                    await addFavorite(movieId, name, posterUrl);
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 23,
                                ),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to movie details screen if needed
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 65, 9, 73),
                              size: 23,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
