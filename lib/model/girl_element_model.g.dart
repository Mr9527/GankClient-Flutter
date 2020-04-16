// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'girl_element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GirlElementModel _$GirlElementModelFromJson(Map<String, dynamic> json) {
  return GirlElementModel(
    json['_id'] as String,
    json['author'] as String,
    json['category'] as String,
    json['createdAt'] as String,
    json['desc'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['likeCounts'] as int,
    json['publishedAt'] as String,
    json['stars'] as int,
    json['title'] as String,
    json['type'] as String,
    json['url'] as String,
    json['views'] as int,
  );
}

Map<String, dynamic> _$GirlElementModelToJson(GirlElementModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'category': instance.category,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'likeCounts': instance.likeCounts,
      'publishedAt': instance.publishedAt,
      'stars': instance.stars,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
      'views': instance.views,
    };
