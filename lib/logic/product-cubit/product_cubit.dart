import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:foodmoji/model/product.dart';
import 'package:foodmoji/service/notification.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<Product> productList = [];
  List<Product> searchProductList = [];
  Random random = Random();
  Timer timer;
  bool searchEnabled = false;

  void getProducts(){
    List<dynamic> data = jsonDecode(jsonString);
    productList = data.map((e) => Product.fromJson(e)).toList();
    print(productList);
    emit(ProductsLoaded(productList: productList));
    // runEverySec();
  }

  void getCurrentProducts(){
    searchEnabled = false;
    emit(ProductsLoaded(productList: productList));
  }

  void searchProducts(String keyword){
    searchEnabled = true;
    searchProductList = productList.where((o) => o.name.startsWith(keyword)).toList();
    if(searchProductList.isEmpty)
    emit(ProductNotFound(keyword: keyword));
    else
    emit(ProductsLoaded(productList: searchProductList));
  }

  void runEverySec(){
    // int _start = 60;
    const oneSec = const Duration(seconds: 30);
    timer =  Timer.periodic(
      oneSec,
      (Timer timer){

            int randomIndex = random.nextInt(productList.length);
            int qty = int.parse(productList[randomIndex].quantity);
            print(productList[randomIndex].name);
            print(qty);
            qty = qty-1;
            productList[randomIndex].quantity = qty.toString();
            if (searchEnabled) emit(ProductsLoaded(productList: searchProductList));
            else emit(ProductsLoaded(productList: productList));

           String sQty = qty.toString();
           String name = productList[randomIndex].name.toUpperCase();
           String body = qty>=1? "Only $sQty $name Available" : "$name is sold out";
           NotificationWidget.showNotification(title: "Product alert", body: body);
      }
    );
  }

  
  // // int _start = 10;
  
  // void startTimer() {
  //   int _start = 10;
  //   const oneSec = const Duration(seconds: 1);
  //   timer =  Timer.periodic(
  //     oneSec,
  //     (Timer timer){
  //         if (_start < 1) {
  //           timer.cancel();
  //           print("Timer finished");
  //         } else {
  //           _start = _start - 1;
  //           print(_start);
  //         }
  //     }
  //   );
  // }

  // void cancelTimer() {
  //   timer.cancel();
  // }
}
