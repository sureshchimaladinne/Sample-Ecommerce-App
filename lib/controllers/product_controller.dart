import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_ecommerce_app/models/product_model.dart';
import 'package:dio/dio.dart';

import '../dio_exception/dio_exception.dart';

class ProductController {
  final String ApiUrl = "https://dummyjson.com/products";
  Future<List<Product>> fetchProducts() async {
    try {
      final dio = Dio();
      var response = await dio.get(ApiUrl);
      print("Raw API Response: ${response.data}");
      if (response.statusCode == 200) {
        ProductModel model = ProductModel.fromJson(response.data);
        return model.products;
      } else {
        throw Exception("Failed to load products");
      }
    } on DioError catch (e) {
      print("@@@${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw Exception(errorMessage);
    }
  }
}
