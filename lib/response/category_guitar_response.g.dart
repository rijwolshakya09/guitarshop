// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_guitar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuitarResponse _$GuitarResponseFromJson(Map<String, dynamic> json) =>
    GuitarResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ShowGuitar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuitarResponseToJson(GuitarResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
