class Cast {
  Cast({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Cast copyWith({
    String? name,
    String? characterName,
    String? urlSmallImage,
    String? imdbCode,
  }) => Cast(
    name: name ?? this.name,
    characterName: characterName ?? this.characterName,
    urlSmallImage: urlSmallImage ?? this.urlSmallImage,
    imdbCode: imdbCode ?? this.imdbCode,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }
}
