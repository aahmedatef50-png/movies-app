// lib/api/model/movies_suggestion/movies_suggestion_mapper.dart
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/api/model/movies_suggestion/movies_suggestion.dart';

extension MoviesSuggestionMapper on MoviesSuggestion {
  Movies toMovies() {
    return Movies(
      id: id,
      url: url,
      imdbCode: imdbCode,
      title: title,
      titleEnglish: titleEnglish,
      titleLong: titleLong,
      slug: slug,
      year: year,
      rating: rating,
      runtime: runtime,
      genres: genres,
      summary: summary,
      descriptionFull: descriptionFull,
      synopsis: synopsis,
      ytTrailerCode: ytTrailerCode,
      language: language,
      mpaRating: mpaRating,
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
      smallCoverImage: smallCoverImage,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: mediumCoverImage,
      state: state,
      torrents: torrents,
    );
  }
}