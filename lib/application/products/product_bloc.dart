
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/products.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/infrastructure/cart/cart_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CartService cartService;
  final SampleProducts sampleProducts;

  ProductBloc(this.cartService, this.sampleProducts) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        List<ProductModel> products = sampleProducts.getSampleProducts();

        if (products.isNotEmpty) {
          final cartProducts = await cartService.getDataFromDb();

          for (var prod in products) {
            if (cartProducts.any((element) => element.id == prod.id)) {
              prod.cartStatus = true;
            }
          }
          emit(ProductsShowSuccess(produclist: products));
        } else {
          emit(ProductsShowSuccess(produclist: products));
        }
      } catch (e) {
        emit(ProductsShowFailure(error: 'Error connecting server B01'));
      }
    });

    on<UpdateProducts>((event, emit) async {
      try {
        List<ProductModel> products = sampleProducts.getSampleProducts();

        if (products.isNotEmpty) {
          final cartProducts = await cartService.getDataFromDb();

          for (var prod in products) {
            if (cartProducts.any((element) => element.id == prod.id)) {
              prod.cartStatus = true;
            }
          }
        }
        emit(ProductsShowSuccess(produclist: products));
      } catch (e) {
        emit(ProductsShowFailure(error: 'Error connecting server B01'));
      }
    });
  }
}
