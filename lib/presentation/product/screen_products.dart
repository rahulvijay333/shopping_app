import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/presentation/product/widget/product_item_widget.dart';

class ScreenProducts extends StatelessWidget {
  const ScreenProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(size: size),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsShowSuccess) {
                
          
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        height: size.height * 0.030,
                        child: Text(
                          'Discover Products',
                          style: TextStyle(
                              fontSize:
                                  size.width > 500 ? 23 : size.width * 0.055,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics:
                              const BouncingScrollPhysics(), // Enable scrolling physics
                          itemCount: state.produclist.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: size.height * 0.3,
                            crossAxisSpacing: 10.0, // Adjust spacing between items
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return ProductItemWidget(
                              size: size,
                              product: state.produclist[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Offline'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 70,
      color: const Color.fromRGBO(33, 150, 243, 1),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shopping App',
              style: TextStyle(
                  fontSize: size.width > 500 ? 23 : size.width * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.shopping_cart_outlined, color: Colors.white)
          ],
        ),
      ),
    );
  }
}