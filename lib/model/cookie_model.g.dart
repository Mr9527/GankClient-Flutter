// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookieModel _$CookieModelFromJson(Map<String, dynamic> json) {
  return CookieModel(
    json['name'] as String,
    json['value'] as String,
    json['expires'] == null ? null : DateTime.parse(json['expires'] as String),
    json['maxAge'] as int,
    json['domain'] as String,
    json['path'] as String,
    json['secure'] as bool,
    json['httpOnly'] as bool,
  );
}

Map<String, dynamic> _$CookieModelToJson(CookieModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'expires': instance.expires?.toIso8601String(),
      'maxAge': instance.maxAge,
      'domain': instance.domain,
      'path': instance.path,
      'secure': instance.secure,
      'httpOnly': instance.httpOnly,
    };
