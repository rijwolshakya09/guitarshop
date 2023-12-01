import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/response/order_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';

class OrderAPI {
  Future<bool> addOrder(
    orderItem,
    int totalPrice,
    String paymentMethod,
    String? address,
    String? contactNo,
  ) async {
    bool isAdded = false;
    String? paymentStatus;
    if (paymentMethod == "Cash on Delivery") {
      paymentStatus = "Pending";
    } else {
      paymentStatus = "Paid";
    }
    try {
      Response response;
      var url = baseUrl + addorderUrl;
      var dio = HttpServices().getDioInstance();
      response = await dio.post(
        url,
        data: {
          "order_item": orderItem,
          "total_price": totalPrice,
          "payment_method": paymentMethod,
          "payment_status": paymentStatus,
          "address": address,
          "contact_no": contactNo,
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

  Future<OrderResponse?> getOrder() async {
    Future.delayed(const Duration(seconds: 2), () {});
    OrderResponse? orderResponse;
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(
        getorderUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 201) {
        orderResponse = OrderResponse.fromJson(response.data);
      } else {
        orderResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return orderResponse;
  }

  Future<bool> cancelOrder(String orderId) async {
    bool isCancel = false;
    String url = baseUrl + cancelorderUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.put(
        url,
        data: {"id": orderId},
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      // debugPrint(response.toString());
      if (response.statusCode == 201) {
        return isCancel = true;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    return isCancel;
  }

  Future<bool> deleteOrder(String orderId) async {
    bool isDeleted = false;
    String url = baseUrl + deleteorderUrl;
    Dio dio = HttpServices().getDioInstance();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Response response = await dio.delete(
        url + orderId,
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
