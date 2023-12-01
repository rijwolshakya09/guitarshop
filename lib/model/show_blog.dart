import 'package:json_annotation/json_annotation.dart';
part 'show_blog.g.dart';

@JsonSerializable()
class ShowBlog {
  @JsonKey(name: '_id')
  String? id;
  String? blog_title;
  String? blog_description;
  String? blog_rich_description;
  String? blog_image;
  bool? isFeatured;
  String? dateCreated;
  String? blog_SKU;

  ShowBlog({
    this.id,
    this.blog_title,
    this.blog_description,
    this.blog_rich_description,
    this.blog_image,
    this.isFeatured,
    this.dateCreated,
    this.blog_SKU,
  });

  factory ShowBlog.fromJson(Map<String, dynamic> json) =>
      _$ShowBlogFromJson(json);

  Map<String, dynamic> toJson() => _$ShowBlogToJson(this);
}
