import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';

import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/presentation/main/screen_main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({
    super.key,
  });

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      //-------------------------------------------------load existing data to user 
      BlocProvider.of<ProductBloc>(context).add(LoadProducts());
      BlocProvider.of<CartBloc>(context).add(GetCartItemsEvent());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return ScreenMain();
        },
      ));
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Shopping App',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
