import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/domain/db/hive_model.dart';
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
        final double cost = items.fold(
            0, (previousValue, element) => previousValue + element.cost);

        emit(CartSuccess(cartlist: items,cost: cost));
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

    on<ClearCartEvent>((event, emit) async {
      await cartService.deleteAllCart();
      emit(CartSuccess(cartlist: []));
    });
  }
}
