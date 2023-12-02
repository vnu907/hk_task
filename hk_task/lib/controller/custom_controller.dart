import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hk_task/screen/dashboard.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomController {
  final dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));

  Future login(String email, String password, context) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    try {
      await dio.post('/login', data: {"email": email, "password": password});
    } catch (error) {
      log(error.toString());
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Dashboard();
    }));
  }

  Future<List> getProducts() async {
    List list = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.get('products');
    if (data != null) {
      list.addAll(jsonDecode(data.toString()));
    }
    return list;
  }
}
