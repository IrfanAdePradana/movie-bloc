import 'package:flutter/material.dart';
import '../models/Item.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  @override
  void initState(){
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose(){
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<Item> snapshot){
          if(snapshot.hasData){
            return buildList(snapshot);
          } else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  openDetailPage(Item data, int index){
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data.results[index].title,
            posterUrl: data.results[index].backdropPath,
            description: data.results[index].overview,
            releaseDate: data.results[index].releaseDate,
            voteAverage: data.results[index].voteAverage.toString(),
            movieId: data.results[index].id,
          ),
        );
      }
    ));
  }
  Widget buildList(AsyncSnapshot<Item> snapshot){
  return GridView.builder(
    itemCount: snapshot.data.results.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2
    ),
    itemBuilder: (BuildContext context, int index){
      return GridTile(
        child: InkResponse(
          enableFeedback: true,
          child: Image.network('https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}', fit: BoxFit.cover,),
          onTap: () => openDetailPage(snapshot.data, index),
        ),
      );
    },
  );
}
}
