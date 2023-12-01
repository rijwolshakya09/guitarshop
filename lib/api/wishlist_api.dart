import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/wishlist.dart';
import 'package:guitarshop/response/wishlist_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class WishlistAPI {
  Future<bool> addWishlist(guitarId) async {
    bool isAdded = false;
    try {
      Response response;
      var url = baseUrl + wishlistUrl;
      var dio = HttpServices().getDioInstance();
      response = await dio.post(
        url,
        data: {
          "guitar_id": guitarId,
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

  Future<List<Wishlist?>> getWishlist() async {
    List<Wishlist?> wishListResponseList = [];
    Response response;
    String? url = baseUrl + getwishlistUrl;
    Dio dio = HttpServices().getDioInstance();

    Future.delayed(const Duration(seconds: 2), () {});
    WishlistResponse? wishlistResponse;
    debugPrint(token);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      response = await dio.get(
        url,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      debugPrint(response.data!.toString());
      if (response.statusCode == 201) {
        wishlistResponse = WishlistResponse.fromJson(response.data);
        for (var data in wishlistResponse.data!) {
          wishListResponseList.add(Wishlist(
            id: data.id,
            guitar_id: data.guitar_id,
            user_id: data.user_id,
          ));
        }
      } else {
        wishlistResponse = null;
      }
    } catch (e) {
      // throw Exception(e);
      debugPrint("error" + e.toString());
    }
    return wishListResponseList;
  }

  Future<bool> deleteWishlist(String wishlistId) async {
    bool isDeleted = false;
    String url = baseUrl + deleteWishlistUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.delete(
        url + wishlistId,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      // debugPrint(response.toString());
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    return isDeleted;
  }
}
