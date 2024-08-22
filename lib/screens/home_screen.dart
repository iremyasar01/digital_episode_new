import 'package:digital_episode_new/components/all_movies_model.dart';
import 'package:digital_episode_new/components/all_series_model.dart';
import 'package:digital_episode_new/components/new_series_model.dart';
import 'package:digital_episode_new/components/tv_shows_models.dart';
import 'package:digital_episode_new/screens/tv_shows_details_screen.dart';
import 'package:digital_episode_new/services/api_service.dart';
import 'package:digital_episode_new/widgets/drawer.dart';
import 'package:digital_episode_new/widgets/airing_today_widget.dart';
import 'package:digital_episode_new/widgets/new_series_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  List<newSeriesModel> allNewSeries = [];
  List<TvShowsModel> allTvShows = [];
  List<AllMoviesModel> allMovies = [];
  List<AllSeriesModel> allSeries = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
    fetchAllItems();
  }

  void fetchAllItems() async {
    List<newSeriesModel> newSeries = await ApiService().getNewSeries();
    List<TvShowsModel> tvShows = await ApiService().getShows();
    List<AllMoviesModel> movies = await ApiService().getAllMovies();
    List<AllSeriesModel> series = await ApiService().getAllSeries();

    setState(() {
      allNewSeries = newSeries;
      allTvShows = tvShows;
      allMovies = movies;
      allSeries = series;
    });
  }

  void updateSearchResults(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      searchResults = [
        ...allNewSeries.where((item) => item.name?.toLowerCase().contains(lowerCaseQuery) ?? false),
        ...allTvShows.where((item) => item.name?.toLowerCase().contains(lowerCaseQuery) ?? false),
        ...allMovies.where((item) => item.title?.toLowerCase().contains(lowerCaseQuery) ?? false),
        ...allSeries.where((item) => item.name?.toLowerCase().contains(lowerCaseQuery) ?? false),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 216, 216),
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 179, 228),
        title: !isSearching
            ? const Text(
                "Episode App",
                style: TextStyle(color: Color.fromARGB(255, 65, 9, 73)),
              )
            : TextFormField(
                controller: searchController,
                onChanged: (value) {
                  updateSearchResults(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                autofocus: true,
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  searchResults = [];
                }
              });
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Bildirim ikonuna basılınca olacaklar
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                            color: Color.fromARGB(255, 65, 9, 73),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "What did you watch today?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 65, 9, 73),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              if (isSearching && searchController.text.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final result = searchResults[index];
                    final name = result is newSeriesModel
                        ? result.name
                        : result is TvShowsModel
                            ? result.name
                            : result is AllMoviesModel
                                ? result.title
                                : result is AllSeriesModel
                                    ? result.name
                                    : null;
                    final posterPath = result is newSeriesModel
                        ? result.posterPath
                        : result is TvShowsModel
                            ? result.posterPath
                            : result is AllMoviesModel
                                ? result.posterPath
                                : result is AllSeriesModel
                                    ? result.posterPath
                                    : null;

                    return ListTile(
                      title: Text(name ?? 'Unknown'),
                      leading: posterPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500$posterPath',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            )
                          : const Icon(Icons.broken_image),
                      onTap: () {
                        final seriesId = result is newSeriesModel
                            ? result.id
                            : result is TvShowsModel
                                ? result.id
                                : result is AllMoviesModel
                                    ? result.id
                                    : result is AllSeriesModel
                                        ? result.id
                                        : null;

                        if (seriesId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TvShowDetailsScreen(
                                  seriesId: seriesId),
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              else ...[
                const AiringTodayWidget(),
                const SizedBox(height: 15),
                const NewSeriesWidget(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
