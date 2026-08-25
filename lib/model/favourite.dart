class Favourite {
  static const String CollictionName ="Favourites";

  String favouriteId;
  num movieId;
  num rating;
  String url;
  String userId;

  Favourite({
    this.favouriteId='',
    required this.url,
    required this.rating,
    required this.movieId,
    required this.userId
});


  // json=> object
  Favourite.FromJson(Map<String,dynamic> data):this(
      rating:data['rating'],
      url: data['url'],
    movieId:data['movieId'],
    userId: data['userId'],
    favouriteId:data['favouriteId']

  );



  // object=> json

  Map<String,dynamic> toJson(){
    return {
      "favouriteId":favouriteId,
      "url":url,
      "rating":rating,
      "movieId":movieId,
      "userId":userId,
    };
  }

}