import 'package:digital_episode_new/services/auth.dart';
import 'package:flutter/material.dart';


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
              return ListTile(
                leading: Image.network(series['posterUrl']),
                title: Text(series['title']),
              );
            },
          );
        }
      },
    );
  }
}
