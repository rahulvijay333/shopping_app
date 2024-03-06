import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/domain/db/hive_model.dart';
import 'package:shopping_app/infrastructure/cart/cart_service.dart';

part 'track_cart_event.dart';
part 'track_cart_state.dart';

class TrackCartBloc extends Bloc<TrackCartEvent, TrackCartState> {
  final CartService cartService;
  TrackCartBloc(this.cartService) : super(TrackCartInitial()) {
    on<TrackAddToCart>((event, emit) async {
      final cartProducts = await cartService.getDataFromDb();

      if (cartProducts.isNotEmpty) {
        if (cartProducts.any((element) => element.id == event.product.id)) {
          emit(TracksShowSuccess(show: true));
        } else {
          emit(TracksShowSuccess(show: false));
        }
      } else {
        emit(TracksShowSuccess(show: false));
      }
    });
  }
}
