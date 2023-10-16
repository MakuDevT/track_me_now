import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'register.model.freezed.dart';
part 'register.model.g.dart';

@freezed
class Register with _$Register {
  const factory Register({
    required String? uid,
    required String? email,
    @Default('Cannot Fetch Data') String trialDue,
    required String token,
    required bool? isActive,
    required bool? isSubscribed,
    required bool? isAdmin,
  }) = _Register;

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);
}
