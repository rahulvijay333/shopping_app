import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';
import 'package:shopping_app/application/products/product_bloc.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
            width: size.width,
            height: 90,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Cart',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Expanded(
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartSuccess) {
              if (state.cartlist.isEmpty) {
                return Center(
                    child: Image.asset(
                  'assets/empty_cart.png',
                  width: size.width * 0.6,
                ));
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 50,
                        color: Colors.amber.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Bill :',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${state.cost} Rs',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              log('clear button');
                              BlocProvider.of<CartBloc>(context)
                                  .add(ClearCartEvent());
                            },
                            child: const Text(
                              'Delete All',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.blue.shade50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          width: size.width * 0.2,
                                          height: size.width * 0.15,
                                          child: Image.asset(
                                            state.cartlist[index].imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.cartlist[index].name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${state.cartlist[index].cost.toString()} Rs',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(RemoveFromCartEvent(
                                                    key: state
                                                        .cartlist[index].id));
                                            BlocProvider.of<ProductBloc>(
                                                    context)
                                                .add(UpdateProducts());
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: state.cartlist.length),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox(
              child: Center(child: Text('Cart is Empty')),
            );
          }),
        )
      ],
    );
  }
}
