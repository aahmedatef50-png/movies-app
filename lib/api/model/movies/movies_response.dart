import 'data.dart';
import 'meta.dart';

class MoviesResponse {
  MoviesResponse({this.status, this.statusMessage, this.data, this.meta});

  MoviesResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MoviesResponse copyWith({
    String? status,
    String? statusMessage,
    Data? data,
    Meta? meta,
  }) => MoviesResponse(
    status: status ?? this.status,
    statusMessage: statusMessage ?? this.statusMessage,
    data: data ?? this.data,
    meta: meta ?? this.meta,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }
}
