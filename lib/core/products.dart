import 'dart:convert';

import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/domain/model/product_model.dart';

final productList = '''[
  {
    "id": 1,
    "name": "Laptop",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 999.99
  },
  {
    "id": 2,
    "name": "Smartphone",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 599.99
  },
  {
    "id": 3,
    "name": "Tablet",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 399.99
  },
  {
    "id": 4,
    "name": "Headphones",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 149.99
  },
  {
    "id": 5,
    "name": "Smartwatch",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 199.99
  },
  {
    "id": 6,
    "name": "Laptop",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 999.99
  },
  {
    "id": 7,
    "name": "Smartphone",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 599.99
  },
  {
    "id": 8,
    "name": "Tablet",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 399.99
  },
  {
    "id": 9,
    "name": "Headphones",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 149.99
  },
  {
    "id": 10,
    "name": "Smartwatch",
    "imageUrl":
        "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/pdp/laptop-g16-7630-intel-pdp-hero.psd?qlt=95&fit=constrain,1&hei=400&wid=570&fmt=png-alpha",
    "addedToCart": false,
    "price": 199.99
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
