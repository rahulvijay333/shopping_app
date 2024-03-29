import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/presentation/cart/screen_cart.dart';
import 'package:shopping_app/presentation/product/screen_products.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  final List _pages = [const ScreenProducts(), const ScreenCart()];

  final ValueNotifier<int> pageIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndexNotifier,
        builder: (context, index, child) {
          return Scaffold(
            body: _pages[index],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                  backgroundColor: Colors.blue,
                  currentIndex: index,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.black,
                  onTap: (value) {
                    pageIndexNotifier.value = value;

                    if (value == 0) {
                      BlocProvider.of<ProductBloc>(context)
                          .add(LoadProducts());
                    } else {
                      BlocProvider.of<CartBloc>(context)
                          .add(GetCartItemsEvent());
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                        ),
                        label: 'products'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.shopping_bag,
                        ),
                        label: 'shopping cart')
                  ]),
            ),
          );
        });
  }
}
