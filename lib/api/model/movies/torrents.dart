class Torrents {
  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  num? seeds;
  num? peers;
  String? size;
  num? sizeBytes;
  String? dateUploaded;
  num? dateUploadedUnix;

  Torrents copyWith({
    String? url,
    String? hash,
    String? quality,
    String? type,
    String? isRepack,
    String? videoCodec,
    String? bitDepth,
    String? audioChannels,
    num? seeds,
    num? peers,
    String? size,
    num? sizeBytes,
    String? dateUploaded,
    num? dateUploadedUnix,
  }) => Torrents(
    url: url ?? this.url,
    hash: hash ?? this.hash,
    quality: quality ?? this.quality,
    type: type ?? this.type,
    isRepack: isRepack ?? this.isRepack,
    videoCodec: videoCodec ?? this.videoCodec,
    bitDepth: bitDepth ?? this.bitDepth,
    audioChannels: audioChannels ?? this.audioChannels,
    seeds: seeds ?? this.seeds,
    peers: peers ?? this.peers,
    size: size ?? this.size,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    dateUploaded: dateUploaded ?? this.dateUploaded,
    dateUploadedUnix: dateUploadedUnix ?? this.dateUploadedUnix,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}
