import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/response/review_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class ReviewAPI {
  Future<bool> addReview(guitarId, String comment, int rating) async {
    bool isAdded = false;
    try {
      Response response;
      var url = baseUrl + addreviewUrl;
      var dio = HttpServices().getDioInstance();
      response = await dio.post(
        url,
        data: {
          "guitar_id": guitarId,
          "comment": comment,
          "rating": rating,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        return isAdded = true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return isAdded;
  }

  Future<ReviewResponse?> getReview(String guitarId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    ReviewResponse? reviewResponse;
    debugPrint("GUITAR ID:   " + guitarId);
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(getreviewUrl + guitarId);
      if (response.statusCode == 201) {
        reviewResponse = ReviewResponse.fromJson(response.data);
      } else {
        reviewResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return reviewResponse;
  }

  Future<bool> deleteReview(String reviewId) async {
    bool isDeleted = false;
    String url = baseUrl + deletereviewUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.delete(
        url + reviewId,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    return isDeleted;
  }
}
