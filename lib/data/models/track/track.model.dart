import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'track.model.freezed.dart';
part 'track.model.g.dart';

@freezed
class Track with _$Track {
  const Track._();

  const factory Track({
    required String id,
    required String latitude,
    required String longitude,
    required DateTime dateCreated,
  }) = _Track;

  double get lat {
    return double.parse(latitude);
  }

  double get lng {
    return double.parse(longitude);
  }

  factory Track.fromJson(Map<String, Object?> json) => _$TrackFromJson(json);
}
