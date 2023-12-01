// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_guitar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowGuitar _$ShowGuitarFromJson(Map<String, dynamic> json) => ShowGuitar(
      guitar_name: json['guitar_name'] as String?,
      guitar_rich_name: json['guitar_rich_name'] as String?,
      guitar_price: json['guitar_price'] as int?,
      guitar_desc: json['guitar_desc'] as String?,
      guitar_image: json['guitar_image'] as String?,
      guitar_category: json['guitar_category'] == null
          ? null
          : ShowCategory.fromJson(
              json['guitar_category'] as Map<String, dynamic>),
      guitar_sku: json['guitar_sku'] as String?,
      isFeatured: json['isFeatured'] as bool?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$ShowGuitarToJson(ShowGuitar instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'guitar_name': instance.guitar_name,
      'guitar_rich_name': instance.guitar_rich_name,
      'guitar_price': instance.guitar_price,
      'guitar_desc': instance.guitar_desc,
      'guitar_image': instance.guitar_image,
      'guitar_category': instance.guitar_category,
      'guitar_sku': instance.guitar_sku,
      'isFeatured': instance.isFeatured,
    };
