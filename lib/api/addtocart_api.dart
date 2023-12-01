import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/response/addtocart_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class AddToCartAPI {
  Future<bool> addCart(guitarId, int? quantity) async {
    bool isAdded = false;
    try {
      Response response;
      var url = baseUrl + addcartUrl;
      var dio = HttpServices().getDioInstance();
      response = await dio.post(
        url,
        data: {
          "guitar_id": guitarId,
          "quantity": quantity,
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

  Future<List<AddToCart?>> getCart() async {
    List<AddToCart?> addToCartResponseList = [];
    Response response;
    String? url = baseUrl + cartUrl;
    Dio dio = HttpServices().getDioInstance();

    Future.delayed(const Duration(seconds: 2), () {});
    AddToCartResponse? addToCartResponse;
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
        addToCartResponse = AddToCartResponse.fromJson(response.data);
        for (var data in addToCartResponse.data!) {
          addToCartResponseList.add(AddToCart(
            id: data.id,
            guitar_id: data.guitar_id,
            user_id: data.user_id,
            quantity: data.quantity,
          ));
        }
      } else {
        addToCartResponse = null;
      }
    } catch (e) {
      // throw Exception(e);
      debugPrint("error" + e.toString());
    }
    return addToCartResponseList;
  }

  Future<bool> deleteCart(String cartId) async {
    bool isDeleted = false;
    String url = baseUrl + deleteCartUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.delete(
        url + cartId,
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
