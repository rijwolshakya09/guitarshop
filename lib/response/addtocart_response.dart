import 'package:guitarshop/model/addtocart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addtocart_response.g.dart';

@JsonSerializable()
class AddToCartResponse {
  bool? success;
  List<AddToCart>? data;

  AddToCartResponse({
    this.success,
    this.data,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddToCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}
