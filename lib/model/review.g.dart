// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['_id'] as String?,
      guitar_id: json['guitar_id'] as String?,
      user_id: json['user_id'] == null
          ? null
          : ShowProfile.fromJson(json['user_id'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      '_id': instance.id,
      'guitar_id': instance.guitar_id,
      'user_id': instance.user_id,
      'comment': instance.comment,
      'rating': instance.rating,
    };
