import 'movies_suggestion.dart';

class Data {
  Data({this.movieCount, this.movies});

  Data.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesSuggestion.fromJson(v));
      });
    }
  }

  num? movieCount;
  List<MoviesSuggestion>? movies;

  Data copyWith({num? movieCount, List<MoviesSuggestion>? movies}) => Data(
    movieCount: movieCount ?? this.movieCount,
    movies: movies ?? this.movies,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
