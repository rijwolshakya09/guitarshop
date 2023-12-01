// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowBlog _$ShowBlogFromJson(Map<String, dynamic> json) => ShowBlog(
      id: json['_id'] as String?,
      blog_title: json['blog_title'] as String?,
      blog_description: json['blog_description'] as String?,
      blog_rich_description: json['blog_rich_description'] as String?,
      blog_image: json['blog_image'] as String?,
      isFeatured: json['isFeatured'] as bool?,
      dateCreated: json['dateCreated'] as String?,
      blog_SKU: json['blog_SKU'] as String?,
    );

Map<String, dynamic> _$ShowBlogToJson(ShowBlog instance) => <String, dynamic>{
      '_id': instance.id,
      'blog_title': instance.blog_title,
      'blog_description': instance.blog_description,
      'blog_rich_description': instance.blog_rich_description,
      'blog_image': instance.blog_image,
      'isFeatured': instance.isFeatured,
      'dateCreated': instance.dateCreated,
      'blog_SKU': instance.blog_SKU,
    };
