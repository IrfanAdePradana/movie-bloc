import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/Trailer.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final repository = Repository();
  final movieId = BehaviorSubject<int>();
  final trailer = BehaviorSubject<Future<Trailer>>();

  Function(int) get fetchTrailersById => movieId.sink.add;
  Observable<Future<Trailer>> get movieTrailers => trailer.stream;

  MovieDetailBloc(){
    movieId.stream.transform(itemTransformer()).pipe(trailer);
  }

  dispose() async {
    movieId.close();
    await trailer.drain();
    trailer.close();
  }

  itemTransformer(){
    return ScanStreamTransformer(
      (Future<Trailer> trailer, int id, int index){
        print(index);
        trailer = repository.fetchAllTrailer(id);
        return trailer;
      }
    );
  }
}