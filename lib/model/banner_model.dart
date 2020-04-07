import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';


List<BannerModel> getBannerModelList(List<dynamic> list){
  List<BannerModel> result = new List();
  list.forEach((item){
    result.add(BannerModel.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class BannerModel extends Object {

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  BannerModel(this.image,this.title,this.url,);

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) => _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}


