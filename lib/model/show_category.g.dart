// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowCategory _$ShowCategoryFromJson(Map<String, dynamic> json) => ShowCategory(
      id: json['_id'] as String?,
      category_name: json['category_name'] as String?,
      category_desc: json['category_desc'] as String?,
      category_pic: json['category_pic'] as String?,
    );

Map<String, dynamic> _$ShowCategoryToJson(ShowCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'category_name': instance.category_name,
      'category_desc': instance.category_desc,
      'category_pic': instance.category_pic,
    };
