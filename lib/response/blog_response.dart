import 'package:guitarshop/model/show_blog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_response.g.dart';

@JsonSerializable()
class BlogResponse {
  bool? success;
  List<ShowBlog>? data;

  BlogResponse({
    this.success,
    this.data,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}
