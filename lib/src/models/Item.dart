class Item {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results = [];

  @override
  Item(this.page, this.totalResults, this.totalPages, this.results);

  Item.fromJson(Map<String, dynamic> json){
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    List<Result> temp = [];
    for(int i = 0; i < json['results'].length; i++){
      Result result = Result(json['results'][i]);
      temp.add(result);
    }
    results = temp;
  }
}

class Result {
  int voteCount;
  int id;
  bool video;
  var voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds = [];
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Result(result) {
    voteCount = result['vote_count'];
    id = result['id'];
    video = result['video'];
    voteAverage = result['vote_average'];
    title = result['title'];
    popularity = result['popularity'];
    posterPath = result['poster_path'];
    originalLanguage = result['original_language'];
    originalTitle = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      genreIds.add(result['genre_ids'][i]);
    }
    backdropPath = result['backdrop_path'];
    adult = result['adult'];
    overview = result['overview'];
    releaseDate = result['release_date'];
  }
}