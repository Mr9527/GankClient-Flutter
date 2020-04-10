// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetailModel _$ArticleDetailModelFromJson(Map<String, dynamic> json) {
  return ArticleDetailModel(
    json['_id'] as String,
    json['author'] as String,
    json['category'] as String,
    json['content'] as String,
    json['createdAt'] as String,
    json['desc'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['index'] as int,
    json['isOriginal'] as bool,
    json['likeCount'] as int,
    json['likeCounts'] as int,
    json['likes'] as List,
    json['markdown'] as String,
    json['publishedAt'] as String,
    json['stars'] as int,
    json['status'] as int,
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['title'] as String,
    json['type'] as String,
    json['updatedAt'] as String,
    json['url'] as String,
    json['views'] as int,
  );
}

Map<String, dynamic> _$ArticleDetailModelToJson(ArticleDetailModel instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'category': instance.category,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'index': instance.index,
      'isOriginal': instance.isOriginal,
      'likeCount': instance.likeCount,
      'likeCounts': instance.likeCounts,
      'likes': instance.likes,
      'markdown': instance.markdown,
      'publishedAt': instance.publishedAt,
      'stars': instance.stars,
      'status': instance.status,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'url': instance.url,
      'views': instance.views,
    };
