import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String email,
    required String userId,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
