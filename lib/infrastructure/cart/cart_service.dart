import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app/domain/db/hive_model.dart';

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

  Future<void> deleteFromDb({required int key}) async {
    final db = await Hive.openBox<CartHiveDb>(cartDbname);

    await db.delete(key);
  }

  Future<void> addToCartDb(
      {required int key, required CartHiveDb product}) async {
    try {
      final db = await Hive.openBox<CartHiveDb>(cartDbname);

      await db.put(key, product);
    } catch (e) {
      log('Data not added');
    }
  }

  Future<void> deleteAllCart() async {
    final db = await Hive.openBox<CartHiveDb>(cartDbname);

    await db.clear();
  }
}
