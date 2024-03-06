import 'dart:convert';

import 'package:shopping_app/core/products.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:test/test.dart';

void main() {
  test('test name', () async {
    List<dynamic> datas = jsonDecode(productList);

    List<ProductModel> products = [];
    List<ProductModel> testp = [];

    products = datas.map((product) {
      final v = ProductModel.fromJson(product);

      return v;
    }).toList();

    testp.add(products[0]);

    if (testp.contains(products[0])) {
      testp[0].cartStatus = true;
    }
  });
}
