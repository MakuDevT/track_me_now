import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'register.model.freezed.dart';
part 'register.model.g.dart';

@freezed
class Register with _$Register {
  const factory Register({
    String? uid,
    String? email,
    String? trialDue,
    String? token,
    bool? isActive,
    bool? isSubscribed,
    bool? isAdmin,
  }) = _Register;

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);
}
