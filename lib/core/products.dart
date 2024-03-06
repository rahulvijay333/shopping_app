import 'dart:convert';

import 'package:shopping_app/domain/db/hive_model.dart';

const productList = '''[
  {
    "id": 1,
    "name": "Laptop",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 999.99
  },
  {
    "id": 2,
    "name": "Smartphone",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 599.99
  },
  {
    "id": 3,
    "name": "Tablet",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 399.99
  },
  {
    "id": 4,
    "name": "Headphones",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 149.99
  },
  {
    "id": 5,
    "name": "Smartwatch",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 19
  },
  {
    "id": 6,
    "name": "Laptop",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 99
  },
  {
    "id": 7,
    "name": "Smartphone",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 599
  },
  {
    "id": 8,
    "name": "Tablet",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 399.99
  },
  {
    "id": 9,
    "name": "Headphones",
    "imageUrl": "assets/laptop.jpg",
    "addedToCart": false,
    "price": 149
  },
  {
    "id": 10,
    "name": "Smartwatch",
    "imageUrl":
        "assets/laptop.jpg",
    "addedToCart": false,
    "price": 199
  }
]''';

class SampleProducts {
  List<dynamic> datas = jsonDecode(productList);

  List<ProductModel> getSampleProducts() {
    List<ProductModel> products = [];

    products = datas.map((product) {
      final v = ProductModel.fromJson(product);

      return v;
    }).toList();

    return products;
  }
}
