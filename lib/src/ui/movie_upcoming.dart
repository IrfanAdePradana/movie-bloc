import 'package:flutter/material.dart';
import 'package:moviebloc/src/models/Upcoming.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieUpcoming extends StatefulWidget {
  @override
  _MovieUpcomingState createState() => _MovieUpcomingState();
}

class _MovieUpcomingState extends State<MovieUpcoming> {
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    bloc.fetchUpcomingMovies();
  }

  @override
  void dispose(){
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        title: Text('Movie-U'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () => drawerKey.currentState.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 40),
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              selected: true,
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            ListTile(
              title: Text('Top Rated'),
              leading: Icon(Icons.star),
              selected: true,
              onTap: () {
                Navigator.of(context).pushNamed('/movie-top');
              },
            ),
            ListTile(
              title: Text('Upcoming'),
              leading: Icon(Icons.update),
              selected: true,
              onTap: () {
                Navigator.of(context).pushNamed('/movie-upcoming');
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text("Film yang akan datang nanti, check this out", textAlign: TextAlign.center, style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.w400)),
              ),
            ),
            StreamBuilder(
              stream: bloc.upMovies,
              builder: (context, AsyncSnapshot<Upcoming> snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
                    itemCount: snapshot.data.results.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.7
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      return GridTile(
                        child: InkResponse(
                          enableFeedback: true,
                          child: Image.network('https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}', fit: BoxFit.cover,),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return MovieDetailBlocProvider(
                                  child: MovieDetail(
                                    title: snapshot.data.results[index].title,
                                    posterUrl: snapshot.data.results[index].backdropPath,
                                    description: snapshot.data.results[index].overview,
                                    releaseDate: snapshot.data.results[index].releaseDate,
                                    voteAverage: snapshot.data.results[index].voteAverage.toString(),
                                    movieId: snapshot.data.results[index].id,
                                  ),
                                );
                              }
                            ))
                          }
                        ),
                      );
                    },
                  );
                } else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        )
      )
    );
  }
}
