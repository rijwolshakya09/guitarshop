import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:guitarshop/response/category_guitar_response.dart';
import 'package:guitarshop/response/guitar_single_response.dart';
import 'package:guitarshop/utils/url.dart';
// ignore: depend_on_referenced_packages

import 'http_services.dart';

class GuitarAPI {
  Future<GuitarResponse?> getProducts() async {
    Future.delayed(const Duration(seconds: 2), () {});
    GuitarResponse? guitarResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        guitarUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      if (response.statusCode == 201) {
        guitarResponse = GuitarResponse.fromJson(response.data);
      } else {
        guitarResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return guitarResponse;
  }

  Future<GuitarSingleResponse?> getSingleProducts(productId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    GuitarSingleResponse? guitarSingleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(guitarSingleUrl + productId);
      if (response.statusCode == 201) {
        debugPrint(response.data.toString());
        guitarSingleResponse = GuitarSingleResponse.fromJson(response.data);
      } else {
        guitarSingleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return guitarSingleResponse;
  }
}
