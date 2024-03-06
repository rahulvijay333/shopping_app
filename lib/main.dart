import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/application/cart/cart_bloc.dart';
import 'package:shopping_app/application/products/product_bloc.dart';
import 'package:shopping_app/application/track_cart/track_cart_bloc.dart';
import 'package:shopping_app/core/products.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/infrastructure/cart/cart_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app/presentation/splash/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CartHiveDbAdapter().typeId)) {
    Hive.registerAdapter(CartHiveDbAdapter());
  }
  if (!Hive.isAdapterRegistered(ProductModelAdapter().typeId)) {
    Hive.registerAdapter(ProductModelAdapter());
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final CartService cartService = CartService();
  final SampleProducts sampleProducts = SampleProducts();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(cartService, sampleProducts),
        ),
        BlocProvider(
          create: (context) => CartBloc(cartService),
        ),
        BlocProvider(
          create: (context) => TrackCartBloc(cartService),
        ),
      ],
      child: const MaterialApp(
        home: ScreenSplash(),
      ),
    );
  }
}
