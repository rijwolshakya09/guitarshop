import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_category.dart';

import '../response/category_response.dart';
import '../utils/url.dart';
import 'http_services.dart';

class CategoryAPI {
  Future<List<ShowCategory?>> loadCategory() async {
    List<ShowCategory?> categoryList = [];
    Response response;
    var url = baseUrl + categoryUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.get(
        url,
      );

      if (response.statusCode == 201) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(response.data);

        for (var data in categoryResponse.data!) {
          categoryList.add(
            ShowCategory(
              id: data.id,
              category_name: data.category_name,
              category_desc: data.category_desc,
              category_pic: data.category_pic,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to get category $e');
    }

    return categoryList;
  }

  Future<CategoryResponse?> getCategory() async {
    Future.delayed(const Duration(seconds: 2), () {});
    CategoryResponse? categoryResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        categoryUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      if (response.statusCode == 201) {
        categoryResponse = CategoryResponse.fromJson(response.data);
      } else {
        categoryResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return categoryResponse;
  }
}
