import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Item.dart';
import '../models/Trailer.dart';
import '../models/Upcoming.dart';

class MovieProvider {
  final apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final baseUrl = "http://api.themoviedb.org/3/movie";

  Future<Item> fetchMovieList() async {
    final http.Response response = await http.get("$baseUrl/popular?api_key=$apiKey");
    if(response.statusCode == 200){
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Trailer> fetchTrailer (int movieId) async {
    final http.Response response = await http.get("$baseUrl/$movieId/videos?api_key=$apiKey");

    if (response.statusCode == 200) {
      return Trailer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }

  Future<Item> fetchTopMovieList() async {
    final http.Response response = await http.get("$baseUrl/top_rated?api_key=$apiKey");
    if(response.statusCode == 200){
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Upcoming> fetchUpcomingMovieList() async {
    final http.Response response = await http.get("$baseUrl/upcoming?api_key=$apiKey");
    if(response.statusCode == 200){
      return upcomingFromJson(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}