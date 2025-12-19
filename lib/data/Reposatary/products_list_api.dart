import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as https;

import '../Models/products_model.dart';

const String baseUrl = 'https://publicapi.dev/fake-store-api/';
class ProductRepository {
  Future<List<Product>> GetProductList() async {
      log("🌐 Cache empty → Calling API");
        final respond = await https.get(
          Uri.parse('https://fakestoreapi.com/products'),
          headers: {'Content-Type': 'application/json'},
        );
      log("📡 API Status Code: ${respond.statusCode}");
        if (respond.statusCode == 200) {
          final List<dynamic> decodeData = jsonDecode(respond.body);
          List<Product> products = decodeData
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();
          return products;
        }
        return [];

  }}

