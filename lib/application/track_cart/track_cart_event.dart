part of 'track_cart_bloc.dart';

abstract class TrackCartEvent {}

class TrackAddToCart extends TrackCartEvent {
  final ProductModel product;

  TrackAddToCart({required this.product});
}
