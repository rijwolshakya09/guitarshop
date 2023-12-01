// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowProfile _$ShowProfileFromJson(Map<String, dynamic> json) => ShowProfile(
      id: json['_id'] as String?,
      full_name: json['full_name'] as String?,
      address: json['address'] as String?,
      contact_no: json['contact_no'] as String?,
      gender: json['gender'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      profile_pic: json['profile_pic'] as String?,
    );

Map<String, dynamic> _$ShowProfileToJson(ShowProfile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.full_name,
      'address': instance.address,
      'contact_no': instance.contact_no,
      'gender': instance.gender,
      'username': instance.username,
      'email': instance.email,
      'profile_pic': instance.profile_pic,
    };
