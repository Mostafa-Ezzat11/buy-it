import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  static String id = 'OrderDetailPage';

  const OrderDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    var docid = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: StreamBuilder(
        stream: Store().loudordersdetails(docid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = [];
            for (var doc in snapshot.data!.docs) {
              products.add(
                ProductModel(
                  id: doc.id,
                  name: doc[kproductname],
                  price: doc[kproductprice],
                  quantity: doc[kproductquantity],
                  category: doc[kproductcategory],
                  desc: doc[kproductdescription],
                  location: doc[kproductlocation],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(
                                  alpha: .5,
                                ),
                                blurRadius: 10,
                                offset: const Offset(10, 10),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: ksecondcolor,
                          ),
                          height:
                              MediaQuery.of(context).size.height *
                              .13,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name : ${products[index].name}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Quantity : ${products[index].quantity}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Price : ${products[index].price}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},

                        child: Container(
                          decoration: BoxDecoration(
                            color: kmaincolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 50,
                          width: 120,
                          child: Center(child: Text('Confirm')),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {},

                        child: Container(
                          decoration: BoxDecoration(
                            color: kmaincolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 50,
                          width: 120,
                          child: Center(child: Text('Delete')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
