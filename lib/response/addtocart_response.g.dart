// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtocart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) =>
    AddToCartResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AddToCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
