import 'package:json_annotation/json_annotation.dart';

part 'category_tab_model.g.dart';


List<CategoryTabModel> getCategoryTabModelList(List<dynamic> list){
  List<CategoryTabModel> result = [];
  list.forEach((item){
    result.add(CategoryTabModel.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class CategoryTabModel extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'coverImageUrl')
  String coverImageUrl;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  CategoryTabModel(this.id,this.coverImageUrl,this.desc,this.title,this.type,);

  factory CategoryTabModel.fromJson(Map<String, dynamic> srcJson) => _$CategoryTabModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryTabModelToJson(this);

}


