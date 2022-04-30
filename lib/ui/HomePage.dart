
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodmoji/logic/product-cubit/product_cubit.dart';
import 'package:foodmoji/model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void searchProducts(String keyword){
    if(keyword == '') BlocProvider.of<ProductCubit>(context).getCurrentProducts();
    else BlocProvider.of<ProductCubit>(context).searchProducts(keyword);
  }

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getProducts();
    BlocProvider.of<ProductCubit>(context).runEverySec();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      // appBar: AppBar(
      //   title: Text("FoodMoji"),
      // ),
      body: CustomScrollView(
        slivers: [
           SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: Text('FoodMoji.com'),
            backgroundColor: Colors.purple,
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
             bottom: AppBar(
               backgroundColor: Colors.purple,
              title: Container(
                width: double.infinity,
                height: 45,
                // color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                      searchProducts(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Search for something',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white
                        // suffixIcon: Icon(Icons.camera_alt)
                      ),
                  ),
                ),
              ),
            ),
           ),

           // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Container(height: 200,
                // child: Text("Product List"),),
                Container(
                  height: MediaQuery.of(context).size.height-140,
                  child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if(state is ProductsLoaded){
                      List<Product> productList = state.productList;
                      return ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (ctxt, index) {
                          return Container(
                            height: 100,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Image.asset('assets/icons/producticon.png')
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(index.toString()),
                                    Text(productList[index].name.toUpperCase()),
                                    Text(productList[index].description),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text("Qty"),
                                  Text(int.parse(productList[index].quantity)<=0? "Sold out": productList[index].quantity,
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                    onPressed: (){}, 
                                    style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.white)
                                      )
                                    )
                                ),
                                    child: Text("Buy Now")),
                                  )
                                ],
                              ),
                            ],
                          ));
                        });
                    }else if(state is ProductNotFound){
                      String key = state.keyword;
                      return Container(
                        height: 20,
                        alignment: Alignment.center,
                        child: Text("No product found for your search '$key'"),
                      );
                    }
                    
                    else{
                      return Container(
                        child: Text("Products not loaded"),
                      );
                    }
                  
                  },
                ),
                ),
                // Container(
                //   height: 1000,
                //   color: Colors.pink,
                // ),
            //   Expanded(
            //   // height: 200,
            //   child: BlocBuilder<ProductCubit, ProductState>(
            //     builder: (context, state) {
            //       if(state is ProductsLoaded){
            //         List<Product> productList = state.productList;
            //          return ListView.builder(
            //           itemCount: productList.length,
            //           itemBuilder: (ctxt, index) {
            //             return Container(
            //               height: 100,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(productList[index].name),
            //                     Text(productList[index].description),
            //                   ],
            //                 ),
            //                 Column(
            //                   children: [
            //                     Text("Qty"),
            //                     Text(productList[index].quantity),
            //                   ],
            //                 ),
            //               ],
            //             ));
            //           });
            //       }else{
            //         return Container(
            //           child: Text("Products not loaded"),
            //         );
            //       }
                 
            //     },
            //   ),
            // )
            ]),
          ),
        ]
        // child: Container(
        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     ElevatedButton(onPressed: getData, child: Text("press")),
        //     Expanded(
        //       // height: 200,
        //       child: BlocBuilder<ProductCubit, ProductState>(
        //         builder: (context, state) {
        //           if(state is ProductsLoaded){
        //             List<Product> productList = state.productList;
        //              return ListView.builder(
        //               itemCount: productList.length,
        //               itemBuilder: (ctxt, index) {
        //                 return Container(
        //                   height: 100,
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(productList[index].name),
        //                         Text(productList[index].description),
        //                       ],
        //                     ),
        //                     Column(
        //                       children: [
        //                         Text("Qty"),
        //                         Text(productList[index].quantity),
        //                       ],
        //                     ),
        //                   ],
        //                 ));
        //               });
        //           }else{
        //             return Container(
        //               child: Text("Products not loaded"),
        //             );
        //           }
                 
        //         },
        //       ),
        //     )
        //   ],
        // )),
      ),
    );
  }
}
