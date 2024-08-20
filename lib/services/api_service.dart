import 'dart:convert';

import 'package:digital_episode_new/components/all_movies_model.dart';
import 'package:digital_episode_new/components/new_series_model.dart';
import 'package:digital_episode_new/components/tv_shows_models.dart';
import 'package:digital_episode_new/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<TvShowsModel>> getShows() async{
 final response= await http.get(Uri.parse("$BASE_URL/trending/tv/week?api_key=$API_KEY"));
/*
//url'nin doğru gelip gelmediğini kontrol eden kod 200 döndürmesi lazım.
print(response.statusCode);
*/
/*
//initalize et listeyi
List<TvShowsModel> tvShows = [];
List <dynamic> responseList =jsonDecode(response.body);
//hepsini map halinde listede depoladı.
//List<TvShowsModel> list =List.empty();
for(var i =0; i<responseList.length; i++){
  tvShows.add(TvShowsModel.fromJson(responseList[i]));
}
return tvShows;

  }
  */
     if (response.statusCode == 200) {
      // Decode the response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract the list of shows from the 'results' key
      List<dynamic> responseList = responseBody['results'];

      // Initialize the list of TvShowsModel
      List<TvShowsModel> tvShows = [];

      // Map each item in responseList to a TvShowsModel
      for (var item in responseList) {
        tvShows.add(TvShowsModel.fromJson(item));
      }

      return tvShows;
    } else {
      throw Exception("Failed to load shows");
    }
  }
   Future<List<newSeriesModel>> getNewSeries() async{
 final response= await http.get(Uri.parse("$BASE_URL/tv/airing_today?api_key=$API_KEY"));



     if (response.statusCode == 200) {
      // Decode the response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract the list of shows from the 'results' key
      List<dynamic> responseList = responseBody['results'];

      // Initialize the list of TvShowsModel
      List<newSeriesModel> newSeries = [];

      // Map each item in responseList to a TvShowsModel
      for (var item in responseList) {
        newSeries.add(newSeriesModel.fromJson(item));
      }

      return newSeries;
    } else {
      throw Exception("Failed to load shows");
    }
  }
   Future<List<AllMoviesModel>> getAllMovies() async{
 final response= await http.get(Uri.parse("$BASE_URL/trending/movie/week?api_key=$API_KEY"));

 

     if (response.statusCode == 200) {
      // Decode the response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract the list of shows from the 'results' key
      List<dynamic> responseList = responseBody['results'];

      // Initialize the list of TvShowsModel
      List<AllMoviesModel> allMovies = [];

      // Map each item in responseList to a TvShowsModel
      for (var item in responseList) {
        allMovies.add(AllMoviesModel.fromJson(item));
      }

      return allMovies;
    } else {
      throw Exception("Failed to load shows");
    }
  }
 
}
