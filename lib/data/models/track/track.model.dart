import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'track.model.freezed.dart';
part 'track.model.g.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required double lat,
    required double lng,
    required DateTime createdAt,
  }) = _Track;

  factory Track.fromJson(Map<String, Object?> json) => _$TrackFromJson(json);
}
