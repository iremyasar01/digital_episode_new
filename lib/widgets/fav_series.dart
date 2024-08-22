import 'package:digital_episode_new/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class FavSeries extends StatefulWidget {
  const FavSeries({super.key});

  @override
  State<FavSeries> createState() => _FavSeriesState();
}

class _FavSeriesState extends State<FavSeries> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Auth().getFavorites(), // Listen to favorite series
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load favorite series."));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No favorite series found."));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var series = snapshot.data![index];
              var seriesId = series['seriesId']?.toString() ?? '';
                   if (seriesId.isEmpty) {
                return const ListTile(
                  title: Text("Invalid movie data"),
                );
              }
               return Slidable(
                key: Key(seriesId),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await Auth().removeFavorite(seriesId);
                        setState(() {}); // Refresh the list after removal
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Remove',
                    ),
                  ],
                ),
             child:  ListTile(
                leading: Image.network(series['posterUrl']),
                title: Text(series['title']),
              ),
               );
            },
          );
        }
      },
    );
  }
}
