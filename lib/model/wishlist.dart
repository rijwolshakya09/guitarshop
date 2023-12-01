import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class Wishlist {
  @JsonKey(name: '_id')
  String? id;
  dynamic guitar_id;
  String? user_id;

  Wishlist({
    this.id,
    this.guitar_id,
    this.user_id,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
