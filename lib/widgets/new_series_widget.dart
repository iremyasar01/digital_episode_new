import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/screens/new_series_screen.dart';
import 'package:flutter/material.dart';

class NewSeriesWidget extends StatelessWidget {
  const NewSeriesWidget({super.key});

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
                "New Series",
                style: TextStyle(
                    color: Color.fromARGB(255, 65, 9, 73),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to NewSeriesScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewSeriesScreen(),
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
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: ApiService().getNewSeries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: List.generate(snapshot.data!.length, (index) {
                    String posterUrl = "https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}";
                    String name = snapshot.data![index].name!;
                    double voteAverage = snapshot.data![index].voteAverage ?? 0.0;

                    return InkWell(
                      onTap: () {
                        // You can define actions on tap here
                      },
                      child: Container(
                        width: 190,
                        height: 280,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF292B37),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF292B37).withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                posterUrl,
                                height: 180,
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                             Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber),
                                     const SizedBox(width: 5),
                                      Text(
                                        "$voteAverage",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                 const SizedBox(height: 5),
                                  Text(
                                    name,
                                    style:const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
