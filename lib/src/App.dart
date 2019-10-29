import 'package:flutter/material.dart';
import './ui/movie_list.dart';
import './ui/movie_top.dart';
import './ui/movie_upcoming.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Movie-U',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieList(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => MovieList());
          case '/movie-top':
            return MaterialPageRoute(builder: (_) => MovieTop());
          case '/movie-upcoming':
            return MaterialPageRoute(builder: (_) => MovieUpcoming());
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}')),
            )
          );
        }
      },
    );
  }
}