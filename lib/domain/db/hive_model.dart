import 'package:hive/hive.dart';
import 'package:shopping_app/domain/model/product_model.dart';
part 'hive_model.g.dart';

const cartDbname = 'cartdb';

@HiveType(typeId: 0)
class CartHiveDb {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final ProductModel product;

  CartHiveDb({required this.id, required this.product});
}

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final num cost;

  @HiveField(4)
  bool cartStatus;


  ProductModel(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.cost,
       this.cartStatus = false});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['name'],
        id: json['id'],
        imageUrl: json['imageUrl'],
        cost: json['price'],
        cartStatus: json['addedToCart']);
  }
}


