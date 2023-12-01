// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_single_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogSingleResponse _$BlogSingleResponseFromJson(Map<String, dynamic> json) =>
    BlogSingleResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : ShowBlog.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogSingleResponseToJson(BlogSingleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
