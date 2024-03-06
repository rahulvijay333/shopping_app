part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<ProductModel> cartlist;
  final double cost;

  CartSuccess({
    required this.cartlist,
    this.cost = 0,
  });
}

class CartFailure extends CartState {
  final String error;

  CartFailure({required this.error});
}
