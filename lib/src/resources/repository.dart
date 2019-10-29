import 'dart:async';
import 'movie_api_provider.dart';
import '../models/Item.dart';
import '../models/Trailer.dart';
import '../models/Upcoming.dart';

class Repository {
  final movieApiProvider = MovieProvider();

  Future<Item> fetchAllMovies() => movieApiProvider.fetchMovieList();
  Future<Trailer> fetchAllTrailer(int movieId) => movieApiProvider.fetchTrailer(movieId);
  Future<Item> fetchAllTopMovies() => movieApiProvider.fetchTopMovieList();
  Future<Upcoming> fetchAllUpcomingMovies() => movieApiProvider.fetchUpcomingMovieList();
}