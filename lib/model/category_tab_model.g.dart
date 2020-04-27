// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryTabModel _$CategoryTabModelFromJson(Map<String, dynamic> json) {
  return CategoryTabModel(
    json['_id'] as String,
    json['coverImageUrl'] as String,
    json['desc'] as String,
    json['title'] as String,
    json['type'] as String,
    json['categoryIndex'] as int,
  );
}

Map<String, dynamic> _$CategoryTabModelToJson(CategoryTabModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'coverImageUrl': instance.coverImageUrl,
      'desc': instance.desc,
      'title': instance.title,
      'type': instance.type,
      'categoryIndex': instance.categoryIndex,
    };
