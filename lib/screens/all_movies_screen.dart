import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/My_appbar.dart';
import 'package:flutter/material.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

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
                return const Center(child: Text("Bir hata oluştu, lütfen tekrar deneyin."));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Yeni bir dizi bulunamadı."));
              } else {
                return Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    String posterUrl = "https://image.tmdb.org/t/p/w500${snapshot.data![index].posterPath}";
                    String name = snapshot.data![index].title!;

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
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 65, 9, 73),
                            size: 23,
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
