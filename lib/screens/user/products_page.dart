import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/user/cart_page.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _tapBarIndex = 0;
  List<ProductModel> _products = [];
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ksecondcolor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicatorColor: kmaincolor,
                onTap: (value) {
                  setState(() {
                    _tapBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'jackets',
                    style: TextStyle(
                      fontSize: 17,
                      color: _tapBarIndex == 0
                          ? Colors.black
                          : kunactivcolor,
                    ),
                  ),
                  Text(
                    'shows',
                    style: TextStyle(
                      fontSize: 17,

                      color: _tapBarIndex == 1
                          ? Colors.black
                          : kunactivcolor,
                    ),
                  ),
                  Text(
                    'trousers',
                    style: TextStyle(
                      fontSize: 17,

                      color: _tapBarIndex == 2
                          ? Colors.black
                          : kunactivcolor,
                    ),
                  ),
                  Text(
                    't-shirts',
                    style: TextStyle(
                      fontSize: 17,

                      color: _tapBarIndex == 3
                          ? Colors.black
                          : kunactivcolor,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketsView(),
                productView(kshoes),
                productView(ktrouser),
                productView(ktshirt),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: Material(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'DISCOVER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartPage.id);
                      },
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jacketsView() {
    return StreamBuilder<QuerySnapshot>(
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

          _products = [...products];
          products = getProductsByCategory(kjackets);

          return GridView.builder(
            clipBehavior: Clip.none,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductInfo.id,
                    arguments: products[index],
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
        }

        return const Center(child: Text("There is an error"));
      },
    );
  }

  List<ProductModel> getProductsByCategory(String category) {
    List<ProductModel> products = [];

    for (var product in _products) {
      if (product.category == category) {
        products.add(product);
      }
    }

    return products;
  }

  Widget productView(String category) {
    List<ProductModel> products = getProductsByCategory(category);

    return GridView.builder(
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductInfo.id,
              arguments: products[index],
            );
          },
          child: CustomProductCard(products: products, index: index),
        );
      },
    );
  }
}
