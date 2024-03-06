import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/application/track_cart/track_cart_bloc.dart';
import 'package:shopping_app/core/sample_description.dart';
import 'package:shopping_app/domain/db/hive_model.dart';

class ScreenViewProduct extends StatelessWidget {
  const ScreenViewProduct(
      {super.key, required this.productName, required this.product});
  final String productName;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(productName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Product1Widget(productName: productName, cost: product.cost,),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(discription)
                ],
              ),
            ),
            const Spacer(),
            BlocBuilder<TrackCartBloc, TrackCartState>(
              builder: (context, state) {
                if (state is TracksShowSuccess) {
                  if (state.show == true) {
                    return SizedBox(
                      
                      width: double.maxFinite,
                      height: 30,
                      child: TextButton.icon(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(RemoveFromCartEvent(key: product.id));
                            BlocProvider.of<TrackCartBloc>(context)
                                .add(TrackAddToCart(product: product));
                            BlocProvider.of<ProductBloc>(context)
                                .add(UpdateProducts());
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          label: const Text('remove')),
                    );
                  } else {
                    return SizedBox(
                      
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                                AddToCartEvent(
                                    product: product, key: product.id));
                            BlocProvider.of<TrackCartBloc>(context)
                                .add(TrackAddToCart(product: product));
                            BlocProvider.of<ProductBloc>(context)
                                .add(UpdateProducts());
                          },
                          child: const Text('Add to Cart')),
                    );
                  }
                }

                return Container();
              },
            ),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

class Product1Widget extends StatelessWidget {
  const Product1Widget({
    super.key,
    required this.productName, required this.cost,
  });

  final String productName;
  final num cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
          Center(
              child: Container(
            height: 150,
            width: 200,
            color: Colors.amber,
            child: Image.asset('assets/laptop.jpg',fit: BoxFit.cover,),
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            productName,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
           Text('${cost.toString()} Rs')
        ],
      ),
    );
  }
}
