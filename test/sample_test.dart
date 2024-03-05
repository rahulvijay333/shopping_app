import 'dart:convert';

import 'package:shopping_app/core/products.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/domain/model/product_model.dart';
import 'package:test/test.dart';

void main() {
  test('test name', () async {
    List<dynamic> datas = jsonDecode(productList);

    List<ProductModel> products = [];
    List<ProductModel> testp = [];

    // print(datas);
    products = datas.map((product) {
      // print(product);
      final v = ProductModel.fromJson(product);
      // print(v);
      return v;
    }).toList();

    testp.add(products[0]);
    //  print(testp);

    print(testp[0].cartStatus);

    if (testp.contains(products[0])) {
      print('contains value');
      testp[0].cartStatus = true;
    }

    print(testp[0].cartStatus);
  });
}
