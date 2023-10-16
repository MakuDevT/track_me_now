// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterImpl _$$RegisterImplFromJson(Map<String, dynamic> json) =>
    _$RegisterImpl(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      trialDue: json['trialDue'] as String?,
      token: json['token'] as String?,
      isActive: json['isActive'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$$RegisterImplToJson(_$RegisterImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'trialDue': instance.trialDue,
      'token': instance.token,
      'isActive': instance.isActive,
      'isSubscribed': instance.isSubscribed,
      'isAdmin': instance.isAdmin,
    };
