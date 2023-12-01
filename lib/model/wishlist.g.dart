// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => Wishlist(
      id: json['_id'] as String?,
      guitar_id: json['guitar_id'],
      user_id: json['user_id'] as String?,
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      '_id': instance.id,
      'guitar_id': instance.guitar_id,
      'user_id': instance.user_id,
    };
