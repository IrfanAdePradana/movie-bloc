import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/Item.dart';
import '../models/Upcoming.dart';

class MoviesBloc {
  final repository = Repository();
  final moviesFetcher = BehaviorSubject<Item>();
  final topFetcher = BehaviorSubject<Item>();
  final upFetcher = BehaviorSubject<Upcoming>();

  Observable<Item> get allMovies => moviesFetcher.stream;
  Observable<Item> get topMovies => topFetcher.stream;
  Observable<Upcoming> get upMovies => upFetcher.stream;

  fetchAllMovies() async {
    Item item = await repository.fetchAllMovies();
    moviesFetcher.sink.add(item);
  }

  fetchTopMovies() async {
    Item item = await repository.fetchAllTopMovies();
    topFetcher.sink.add(item);
  }

  fetchUpcomingMovies() async {
    Upcoming upcoming = await repository.fetchAllUpcomingMovies();
    upFetcher.sink.add(upcoming);
  }

  dispose(){
    moviesFetcher.close();
    topFetcher.close();
    upFetcher.close();
  }
}

final bloc = MoviesBloc();