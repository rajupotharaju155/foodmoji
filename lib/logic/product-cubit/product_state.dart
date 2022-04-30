part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsLoaded extends ProductState {
  List<Product> productList;
  ProductsLoaded({this.productList});
}

class ProductLoadingError extends ProductState {}

class ProductNotFound extends ProductState {
  String keyword;
  ProductNotFound({this.keyword});
}


