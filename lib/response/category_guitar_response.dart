// ignore: depend_on_referenced_packages
import 'package:guitarshop/model/show_guitar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_guitar_response.g.dart';

@JsonSerializable()
class GuitarResponse {
  bool? success;
  List<ShowGuitar>? data;

  GuitarResponse({this.success, this.data});

  factory GuitarResponse.fromJson(Map<String, dynamic> json) =>
      _$GuitarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuitarResponseToJson(this);
}
