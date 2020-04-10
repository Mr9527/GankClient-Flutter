import 'package:json_annotation/json_annotation.dart';

part 'article_detail_model.g.dart';


@JsonSerializable()
class ArticleDetailModel extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'index')
  int index;

  @JsonKey(name: 'isOriginal')
  bool isOriginal;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'likeCounts')
  int likeCounts;

  @JsonKey(name: 'likes')
  List<dynamic> likes;

  @JsonKey(name: 'markdown')
  String markdown;

  @JsonKey(name: 'publishedAt')
  String publishedAt;

  @JsonKey(name: 'stars')
  int stars;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'tags')
  List<String> tags;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'views')
  int views;

  ArticleDetailModel(this.id,this.author,this.category,this.content,this.createdAt,this.desc,this.images,this.index,this.isOriginal,this.likeCount,this.likeCounts,this.likes,this.markdown,this.publishedAt,this.stars,this.status,this.tags,this.title,this.type,this.updatedAt,this.url,this.views,);

  factory ArticleDetailModel.fromJson(Map<String, dynamic> srcJson) => _$ArticleDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleDetailModelToJson(this);

}


