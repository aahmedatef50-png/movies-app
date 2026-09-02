import 'package:cloud_firestore/cloud_firestore.dart';

class WatchHistory {
  static const String collectionName = 'WatchHistory';

  String historyId;
  num movieId;
  num rating;
  String largeCoverImage;
  String userId;
  DateTime? watchedAt;

  WatchHistory({
    this.historyId = '',
    required this.movieId,
    required this.rating,
    required this.largeCoverImage,
    required this.userId,
    this.watchedAt,
  });

  WatchHistory.fromJson(Map<String, dynamic> data)
      : this(
    historyId: data['historyId'] ?? '',
    movieId: data['movieId'],
    rating: data['rating'],
    largeCoverImage: data['largeCoverImage'],
    userId: data['userId'],
    watchedAt: data['watchedAt'] != null
        ? (data['watchedAt'] as Timestamp).toDate()
        : null,
  );

  Map<String, dynamic> toJson() {
    return {
      'historyId': historyId,
      'movieId': movieId,
      'rating': rating,
      'largeCoverImage': largeCoverImage,
      'userId': userId,
      'watchedAt': watchedAt,
    };
  }
}