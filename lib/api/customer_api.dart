import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/api/http_services.dart';
import 'package:guitarshop/response/login_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer.dart';

class CustomerAPI {
  Future<bool> registerUser(Customer customer) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: customer.toJson(),
      );
      if (response.statusCode == 200) {
        return isRegister = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isRegister;
  }

  Future<bool> login(String username, password) async {
    bool isLogin = false;
    try {
      var url = baseUrl + loginUrl;
      var dio = HttpServices().getDioInstance();

      var response = await dio.post(url, data: {
        "username": username,
        "password": password,
      });
      if (response.statusCode == 201) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        token = loginResponse.token;
        _setDataToSharedPref(token!);
        if (token == null) {
          isLogin = false;
        } else {
          isLogin = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  _setDataToSharedPref(String text) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', text);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String data = '';

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
