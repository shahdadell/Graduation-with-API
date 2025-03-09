// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/datum.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';
import 'package:graduation_project/home_screen/data/model/items_model.dart';

class HomeRepo {
  static Future<List<Datum>> fetchCategories() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.fetchHome);
      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        // List categoriesData = response.data['categories'];
        List categoriesData = response.data['categories']['data'];
        return categoriesData.map((e) => Datum.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error fetching categories');
    }
  }

  static Future<List<ItemModel>> fetchDiscountedItems() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.fetchHome);
      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List itemsData = response.data['items']['data']; 
        return itemsData.map((e) => ItemModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch discounted items');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error fetching discounted items');
    }
  }
}

