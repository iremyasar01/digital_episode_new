import 'package:digital_episode_new/screens/airing_today_screen.dart';
import 'package:digital_episode_new/services/api_service.dart';
import 'package:flutter/material.dart';

class AiringTodayWidget extends StatelessWidget {
  const AiringTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Airing Today",
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 9, 73),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to AiringTodayScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AiringTodayScreen(),
                    ),
                  );
                },
                child: const Text(
                  "see all",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 9, 73),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder(
          future: ApiService().getShows(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(snapshot.data!.length, (index) {
                    String posterUrl = "https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}";
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              posterUrl,
                              height: 300,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(snapshot.data![index].name.toString()),
                        ],
                      ),
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
