import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/domain/model/product_model.dart';
import 'package:shopping_app/infrastructure/cart/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc(this.cartService) : super(CartInitial()) {
    on<AddToCartEvent>((event, emit) {
      try {
        final item = CartHiveDb(id: event.key, product: event.product);
        cartService.addToCartDb(key: event.key, product: item);
        add(GetCartItemsEvent());
      } catch (e) {}
    });

    on<GetCartItemsEvent>((event, emit) async {
      try {
        final List<ProductModel> items = await cartService.getDataFromDb();
        emit(CartSuccess(cartlist: items));
      } catch (e) {
        emit(CartFailure(error: 'error happened - B01'));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      try {
        await cartService.deleteFromDb(key: event.key);
        add(GetCartItemsEvent());
      } catch (e) {
        emit(CartFailure(error: 'error happened B01'));
      }
    });
  }
}
