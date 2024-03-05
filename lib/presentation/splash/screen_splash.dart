import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/presentation/main/screen_main.dart';
import 'package:shopping_app/presentation/product/screen_products.dart';

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
      BlocProvider.of<ProductBloc>(context).add(LoadProducts());

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
          decoration: BoxDecoration(
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
