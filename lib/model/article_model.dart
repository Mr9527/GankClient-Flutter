import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';


List<ArticleModel> getArticleModelList(List<dynamic> list){
  List<ArticleModel> result = [];
  list.forEach((item){
    result.add(ArticleModel.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class ArticleModel extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'likeCounts')
  int likeCounts;

  @JsonKey(name: 'publishedAt')
  String publishedAt;

  @JsonKey(name: 'stars')
  int stars;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'views')
  int views;

  ArticleModel(this.id,this.author,this.category,this.createdAt,this.desc,this.images,this.likeCounts,this.publishedAt,this.stars,this.title,this.type,this.url,this.views,);

  factory ArticleModel.fromJson(Map<String, dynamic> srcJson) => _$ArticleModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

}


