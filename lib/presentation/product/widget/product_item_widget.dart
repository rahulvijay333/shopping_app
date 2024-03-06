import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/domain/db/hive_model.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.size,
    required this.product,
  });

  final ProductModel product;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${product.cost.toString()} Rs",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(product.name),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: product.cartStatus == false
                  ? SizedBox(
                      width: size.width * 0.2,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                                AddToCartEvent(
                                    product: product, key: product.id));
                            BlocProvider.of<ProductBloc>(context)
                                .add(UpdateProducts());
                          },
                          child: const Text('Add')),
                    )
                  : SizedBox(
                      width: size.width * 0.25,
                      height: 30,
                      child: TextButton.icon(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(RemoveFromCartEvent(key: product.id));
                            BlocProvider.of<ProductBloc>(context)
                                .add(UpdateProducts());
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          label: const Text('remove')),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
