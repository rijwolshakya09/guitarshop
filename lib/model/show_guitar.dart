import 'package:guitarshop/model/show_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_guitar.g.dart';

@JsonSerializable()
class ShowGuitar {
  @JsonKey(name: '_id')
  String? id;
  String? guitar_name;
  String? guitar_rich_name;
  int? guitar_price;
  String? guitar_desc;
  String? guitar_image;
  ShowCategory? guitar_category;
  String? guitar_sku;
  bool? isFeatured;

  ShowGuitar({
    this.guitar_name,
    this.guitar_rich_name,
    this.guitar_price,
    this.guitar_desc,
    this.guitar_image,
    this.guitar_category,
    this.guitar_sku,
    this.isFeatured,
  });

  factory ShowGuitar.fromJson(Map<String, dynamic> json) {
    return _$ShowGuitarFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShowGuitarToJson(this);
}
