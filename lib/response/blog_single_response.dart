import 'package:guitarshop/model/show_blog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_single_response.g.dart';

@JsonSerializable()
class BlogSingleResponse {
  bool? success;
  ShowBlog? data;

  BlogSingleResponse({
    this.success,
    this.data,
  });

  factory BlogSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogSingleResponseToJson(this);
}
