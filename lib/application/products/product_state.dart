part of 'product_bloc.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsShowSuccess extends ProductState {

  final List<ProductModel> produclist;

  ProductsShowSuccess({required this.produclist});
}

class ProductsShowFailure extends ProductState {
  final String error;

  ProductsShowFailure({required this.error});
}
