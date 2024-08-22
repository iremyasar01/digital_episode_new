import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:digital_episode_new/services/auth.dart';

class WatchSeries extends StatefulWidget {
  const WatchSeries({super.key});

  @override
  State<WatchSeries> createState() => _WatchSeriesState();
}

class _WatchSeriesState extends State<WatchSeries> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Auth().getSeriesWatchList(), // Listen to the watchlist stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load watchlist."));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No movies in your watchlist."));
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
                        await Auth().removeFromWatchlist(seriesId);
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
                  leading: Image.network(
                    series['posterUrl'] ?? '',
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                  title: Text(series['title'] ?? 'Unknown title'),
                ),
              );
            },
          );
        }
      },
    );
  }
}