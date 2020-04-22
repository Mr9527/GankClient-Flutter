import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'cookie_model.g.dart';

List<CookieModel> getGirlElementModelList(List<dynamic> list) {
  List<CookieModel> result = [];
  list.forEach((item) {
    result.add(CookieModel.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class CookieModel extends Object implements Cookie  {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  String value;

  @JsonKey(name: 'expires')
  DateTime expires;

  @JsonKey(name: 'maxAge')
  int maxAge;

  @JsonKey(name: 'domain')
  String domain;

  @JsonKey(name: 'path')
  String path;

  @JsonKey(name: 'secure')
  bool secure;

  @JsonKey(name: 'httpOnly')
  bool httpOnly;

  CookieModel(this.name, this.value, this.expires, this.maxAge, this.domain,
      this.path, this.secure, this.httpOnly);

  factory CookieModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CookieModelToJson(this);
}
