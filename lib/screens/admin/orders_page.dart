import 'package:buy_it/constants.dart';
import 'package:buy_it/models/order.dart';
import 'package:buy_it/screens/admin/order_detail_page.dart';
import 'package:buy_it/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  static String id = 'OrderPage';

  const OrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: StreamBuilder<QuerySnapshot>(
        stream: Store().loudorders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orders = [];
            for (var doc in snapshot.data!.docs) {
              orders.add(
                OrderModel(
                  id: doc.id,
                  totalPrice: doc[ktotalprice],
                  address: doc[kaddress],
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailPage.id,
                        arguments: orders[index].id,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: .5),
                            blurRadius: 10,
                            offset: const Offset(10, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: ksecondcolor,
                      ),
                      height:
                          MediaQuery.of(context).size.height * .13,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price : ${orders[index].totalPrice}',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Address is : ${orders[index].address}',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            );
          } else {
            return Center(child: Text('there is no orders'));
          }
        },
      ),
    );
  }
}
