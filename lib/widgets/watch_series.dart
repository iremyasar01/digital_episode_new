import 'package:flutter/material.dart';
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
      stream: Auth().getSeriesWatchList(), // Listen to watchlist series
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Failed to load watchlist."));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No series in your watchlist."));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var series = snapshot.data![index];
              return ListTile(
                leading: Image.network(
                  series['posterUrl'],
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
                title: Text(series['title']),
              );
            },
          );
        }
      },
    );
  }
}
