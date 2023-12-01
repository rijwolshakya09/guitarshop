import 'package:guitarshop/api/blog_api.dart';
import 'package:guitarshop/response/blog_response.dart';
import 'package:guitarshop/response/blog_single_response.dart';

class BlogRepository {
  Future<BlogResponse?> getBlog() async {
    return BlogAPI().getBlog();
  }

  Future<BlogSingleResponse?> getSingleBlogs(blogId) async {
    return BlogAPI().getSingleBlogs(blogId);
  }
}
