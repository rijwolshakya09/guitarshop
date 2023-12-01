import 'package:guitarshop/model/show_guitar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addtocart.g.dart';

@JsonSerializable()
class AddToCart {
  @JsonKey(name: '_id')
  String? id;
  dynamic guitar_id;
  String? user_id;
  int? quantity;

  AddToCart({
    this.id,
    this.guitar_id,
    this.user_id,
    this.quantity,
  });

  factory AddToCart.fromJson(Map<String, dynamic> json) =>
      _$AddToCartFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartToJson(this);
}
