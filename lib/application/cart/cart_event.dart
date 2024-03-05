part of 'cart_bloc.dart';

class CartEvent {}

class GetCartItemsEvent extends CartEvent {
 
}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  final int key;

  AddToCartEvent({required this.product, required this.key});
}

class RemoveFromCartEvent extends CartEvent {
  final int key;

  RemoveFromCartEvent({required this.key});
}
