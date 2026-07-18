import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/admin/edit_product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatelessWidget {
  ManageProduct({super.key});
  static String id = 'ManageProduct';
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        backgroundColor: ksecondcolor,
      ),
      backgroundColor: ksecondcolor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.getproducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = [];

            for (var doc in snapshot.data!.docs) {
              products.add(
                ProductModel(
                  id: doc.id,
                  name: doc[kproductname],
                  price: doc[kproductprice],
                  category: doc[kproductcategory],
                  desc: doc[kproductdescription],
                  location: doc[kproductlocation],
                ),
              );
            }
            return GridView.builder(
              clipBehavior: Clip.none,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 20,
                childAspectRatio: .8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 =
                        MediaQuery.of(context).size.width - dx;
                    double dy2 =
                        MediaQuery.of(context).size.height - dy;

                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        dx,
                        dy,
                        dx2,
                        dy2,
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text('Edit'),
                          onTap: () => Navigator.pushNamed(
                            context,
                            EditProduct.id,
                            arguments: products[index].id,
                          ),
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          onTap: () => _store.deleteproduct(
                            products[index].id,
                          ),
                        ),
                      ],
                    );
                  },
                  child: CustomProductCard(
                    products: products,
                    index: index,
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('There is an error'));
          }
        },
      ),
    );
  }
}
