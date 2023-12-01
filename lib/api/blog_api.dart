import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/response/blog_response.dart';
import 'package:guitarshop/response/blog_single_response.dart';

import '../utils/url.dart';
import 'http_services.dart';

class BlogAPI {
  Future<BlogResponse?> getBlog() async {
    Future.delayed(const Duration(seconds: 2), () {});
    BlogResponse? blogResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        blogUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      if (response.statusCode == 201) {
        blogResponse = BlogResponse.fromJson(response.data);
      } else {
        blogResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return blogResponse;
  }

  Future<BlogSingleResponse?> getSingleBlogs(blogId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    BlogSingleResponse? blogSingleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      debugPrint(blogId);
      Response response = await dio.get(blogSingleUrl + blogId);
      if (response.statusCode == 201) {
        debugPrint(response.data.toString());
        blogSingleResponse = BlogSingleResponse.fromJson(response.data);
      } else {
        blogSingleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return blogSingleResponse;
  }
}
