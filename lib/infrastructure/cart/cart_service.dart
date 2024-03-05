import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/domain/model/product_model.dart';

class CartService {
  Future<List<ProductModel>> getDataFromDb() async {
    final List<ProductModel> prodlist = [];
    final db = await Hive.openBox<CartHiveDb>(cartDbname);
    
    final lists = db.values.toList();
    for (var prod in lists) {
      prodlist.add(prod.product);
    }
    return prodlist;
  }

  Future<bool> checkDbState() async {
    final db = await Hive.openBox<CartHiveDb>(cartDbname);

    if (db.values.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  deleteFromDb({required int key}) async {
    final db = await Hive.openBox<CartHiveDb>(cartDbname);

    await db.delete(key);
    log('product deleted');
  }

  addToCartDb({required int key, required CartHiveDb product}) async {
    try {
      final db = await Hive.openBox<CartHiveDb>(cartDbname);

      db.put(key, product);
      log('product added');
    } catch (e) {
      log('Data not added');
    }
  }
}
