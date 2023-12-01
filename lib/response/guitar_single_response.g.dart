// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guitar_single_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuitarSingleResponse _$GuitarSingleResponseFromJson(
        Map<String, dynamic> json) =>
    GuitarSingleResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : ShowGuitar.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuitarSingleResponseToJson(
        GuitarSingleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
