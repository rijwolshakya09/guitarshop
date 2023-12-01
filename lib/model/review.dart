import 'package:guitarshop/model/show_guitar.dart';
import 'package:guitarshop/model/show_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: '_id')
  String? id;
  String? guitar_id;
  ShowProfile? user_id;
  String? comment;
  int? rating;

  Review({
    this.id,
    this.guitar_id,
    this.user_id,
    this.comment,
    this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
