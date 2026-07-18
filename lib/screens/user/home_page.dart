// import 'package:buy_it/constants.dart';
// import 'package:buy_it/models/product_model.dart';
// import 'package:buy_it/screens/user/cart_page.dart';
// import 'package:buy_it/screens/user/product_info.dart';
// import 'package:buy_it/screens/user/user_info_page.dart';
// import 'package:buy_it/services/auth_service%20.dart';
// import 'package:buy_it/services/store.dart';
// import 'package:buy_it/widgets/custom_product_card.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   static String id = 'HomePage';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _tapBarIndex = 0;
//   int _bottomBarIndex = 0;
//   List<ProductModel> _products = [];
//   final _store = Store();
//   @override
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)!.settings.arguments
//             as Map<String, dynamic>;

//     return Stack(
//       children: [
//         DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             backgroundColor: ksecondcolor,
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               currentIndex: _bottomBarIndex,
//               onTap: (value) {
//                 if (value == 2) {
//                   showLogoutDialog(context);
//                 }
//                 setState(() {
//                   _bottomBarIndex = value;
//                 });
//               },
//               fixedColor: Colors.blue,
//               items: [
//                 BottomNavigationBarItem(
//                   label: 'Products',
//                   icon: Icon(Icons.list),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'User info',
//                   icon: Icon(Icons.person),
//                 ),
//                 BottomNavigationBarItem(
//                   label: 'SignOut',
//                   icon: Icon(Icons.close, color: Colors.red),
//                 ),
//               ],
//             ),
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               bottom: TabBar(
//                 indicatorColor: kmaincolor,
//                 onTap: (value) {
//                   setState(() {
//                     _tapBarIndex = value;
//                   });
//                 },
//                 tabs: [
//                   Text(
//                     'jackets',
//                     style: TextStyle(
//                       color: _tapBarIndex == 0
//                           ? Colors.black
//                           : kunactivcolor,
//                       fontSize: _tapBarIndex == 0 ? 16 : null,
//                     ),
//                   ),
//                   Text(
//                     'shows',
//                     style: TextStyle(
//                       color: _tapBarIndex == 1
//                           ? Colors.black
//                           : kunactivcolor,
//                       fontSize: _tapBarIndex == 1 ? 16 : null,
//                     ),
//                   ),
//                   Text(
//                     'bental',
//                     style: TextStyle(
//                       color: _tapBarIndex == 2
//                           ? Colors.black
//                           : kunactivcolor,
//                       fontSize: _tapBarIndex == 2 ? 16 : null,
//                     ),
//                   ),
//                   Text(
//                     'fostan',
//                     style: TextStyle(
//                       color: _tapBarIndex == 3
//                           ? Colors.black
//                           : kunactivcolor,
//                       fontSize: _tapBarIndex == 3 ? 16 : null,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: _bottomBarIndex == 1
//                 ? UserInfoPage(
//                     email: args['email'],
//                     password: args['password'],
//                   )
//                 : TabBarView(
//                     children: [
//                       jacketsView(),
//                       productView(kshoes),
//                       productView(ktrouser),
//                       productView(ktshirt),
//                     ],
//                   ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
//           child: Material(
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * .1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'DISCOVER',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, CartPage.id);
//                     },
//                     child: Icon(Icons.shopping_cart),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget jacketsView() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _store.getproducts(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<ProductModel> products = [];

//           for (var doc in snapshot.data!.docs) {
//             products.add(
//               ProductModel(
//                 id: doc.id,
//                 name: doc[kproductname],
//                 price: doc[kproductprice],
//                 category: doc[kproductcategory],
//                 desc: doc[kproductdescription],
//                 location: doc[kproductlocation],
//               ),
//             );
//           }

//           _products = [...products];
//           products.clear();
//           products = getProductsByCategory(kjackets);
//           return GridView.builder(
//             clipBehavior: Clip.none,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               // mainAxisSpacing: 20,
//               childAspectRatio: .8,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     ProductInfo.id,
//                     arguments: products[index],
//                   );
//                 },
//                 child: CustomProductCard(
//                   products: products,
//                   index: index,
//                 ),
//               );
//             },
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return Center(child: Text('There is an error'));
//         }
//       },
//     );
//   }

//   List<ProductModel> getProductsByCategory(String pcategory) {
//     List<ProductModel> products = [];
//     for (var product in _products) {
//       if (product.category == pcategory) {
//         products.add(product);
//       }
//     }
//     return products;
//   }

//   Widget productView(pcategory) {
//     List<ProductModel> products = getProductsByCategory(pcategory);
//     return GridView.builder(
//       clipBehavior: Clip.none,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         // mainAxisSpacing: 20,
//         childAspectRatio: .8,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               ProductInfo.id,
//               arguments: products[index],
//             );
//           },
//           child: CustomProductCard(products: products, index: index),
//         );
//       },
//     );
//   }

//   void showLogoutDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text(
//             'Logout',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to log out?',
//             style: TextStyle(fontSize: 16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _bottomBarIndex = 0;
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 AuthService().logout();
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/user/products_page.dart';
import 'package:buy_it/screens/user/user_info_page.dart';
import 'package:buy_it/services/auth_service%20.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>;
    final List<Widget> pages = [
      ProductsPage(),
      UserInfoPage(email: args['email'], password: args['password']),
    ];
    return Scaffold(
      body: pages[_bottomBarIndex],
      backgroundColor: ksecondcolor,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomBarIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: kmaincolor,

        onTap: (index) {
          if (index == 2) {
            showLogoutDialog(context);
            return;
          }

          setState(() {
            _bottomBarIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.red),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                AuthService().logout();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
