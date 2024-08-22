import 'package:digital_episode_new/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class FavMovies extends StatefulWidget {
  const FavMovies({super.key});

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Auth().getMoviesFavorites(), // Listen to favorite movies
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load favorite movies."));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No favorite movies found."));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var movie = snapshot.data![index];
              var moviesId = movie['movieId']?.toString() ?? '';
                   if (moviesId.isEmpty) {
                return const ListTile(
                  title: Text("Invalid movie data"),
                );
              }
               return Slidable(
                key: Key(moviesId),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await Auth().removeFavoriteMovie(moviesId);
                        setState(() {}); // Refresh the list after removal
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Remove',
                    ),
                  ],
                ),
              child: ListTile(
                leading: Image.network(movie['posterUrl']),
                title: Text(movie['title']),
              ),
               );
            },
          );
        }
      },
    );
  }
}
