
import 'package:guitarshop/model/show_guitar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guitar_single_response.g.dart';

@JsonSerializable()
class GuitarSingleResponse {
  bool? success;
  ShowGuitar? data;

  GuitarSingleResponse({
    this.success,
    this.data,
  });

  factory GuitarSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$GuitarSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuitarSingleResponseToJson(this);
}
