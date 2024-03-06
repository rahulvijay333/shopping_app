import 'package:flutter/material.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/track_cart/track_cart_bloc.dart';
import 'package:shopping_app/presentation/product/view_product/screeen_view_product.dart';
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
              } else if (state is ProductsShowFailure) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is ProductsShowSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: SizedBox(
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
                        padding: const EdgeInsets.all(15.0),
                        child: GridView.builder(
                          physics:
                              const BouncingScrollPhysics(), // Enable scrolling physics
                          itemCount: state.produclist.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: size.height * 0.3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<TrackCartBloc>(context).add(
                                    TrackAddToCart(
                                        product: state.produclist[index]));
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ScreenViewProduct(
                                      productName: state.produclist[index].name,
                                      product: state.produclist[index],
                                    );
                                  },
                                ));
                              },
                              child: ProductItemWidget(
                                size: size,
                                product: state.produclist[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No Products'),
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
        width: size.width,
        height: 90,
        color: const Color.fromRGBO(33, 150, 243, 1),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Shopping App',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.shopping_cart_outlined, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
