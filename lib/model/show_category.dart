import 'package:json_annotation/json_annotation.dart';
part 'show_category.g.dart';

@JsonSerializable()
class ShowCategory {
  @JsonKey(name: '_id')
  String? id;
  String? category_name;
  String? category_desc;
  String? category_pic;

  ShowCategory({
    this.id,
    this.category_name,
    this.category_desc,
    this.category_pic,
  });

  factory ShowCategory.fromJson(Map<String, dynamic> json) =>
      _$ShowCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ShowCategoryToJson(this);
}
