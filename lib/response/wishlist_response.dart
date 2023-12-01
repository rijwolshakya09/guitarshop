import 'package:guitarshop/model/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_response.g.dart';

@JsonSerializable()
class WishlistResponse {
  bool? success;
  List<Wishlist>? data;

  WishlistResponse({
    this.success,
    this.data,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistResponseToJson(this);
}
