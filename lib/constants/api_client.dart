/*
import 'dart:convert';

import 'package:digital_episode_new/constants/api_constants.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client;
  ApiClient(this._client);
  dynamic get (String path ) async{
     final response = await _client.get(Uri.parse('${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}'),
     headers: {
      'Content type ': 'application json', }, );

     
     if(response.statusCode==200){
          if (response.statusCode == 200) {
      // Decode the response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract the list of shows from the 'results' key
      List<dynamic> responseList = responseBody['results'];
      
     }
     }
  }
}
*/
  
