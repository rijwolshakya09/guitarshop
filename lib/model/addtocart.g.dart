// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtocart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCart _$AddToCartFromJson(Map<String, dynamic> json) => AddToCart(
      id: json['_id'] as String?,
      guitar_id: json['guitar_id'],
      user_id: json['user_id'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$AddToCartToJson(AddToCart instance) => <String, dynamic>{
      '_id': instance.id,
      'guitar_id': instance.guitar_id,
      'user_id': instance.user_id,
      'quantity': instance.quantity,
    };
