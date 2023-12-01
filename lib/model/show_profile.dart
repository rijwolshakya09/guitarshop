import 'package:json_annotation/json_annotation.dart';
part 'show_profile.g.dart';

@JsonSerializable()
class ShowProfile {
  @JsonKey(name: '_id')
  String? id;
  String? full_name;
  String? address;
  String? contact_no;
  String? gender;
  String? username;
  String? email;
  String? profile_pic;

  ShowProfile({
    this.id,
    this.full_name,
    this.address,
    this.contact_no,
    this.gender,
    this.username,
    this.email,
    this.profile_pic,
  });

  factory ShowProfile.fromJson(Map<String, dynamic> json) =>
      _$ShowProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ShowProfileToJson(this);
}
