import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/Item.dart';

class MoviesBloc {
  final repository = Repository();
  final moviesFetcher = BehaviorSubject<Item>();

  Observable<Item> get allMovies => moviesFetcher.stream;

  fetchAllMovies() async {
    Item item = await repository.fetchAllMovies();
    moviesFetcher.sink.add(item);
  }

  dispose(){
    moviesFetcher.close();
  }
}

final bloc = MoviesBloc();