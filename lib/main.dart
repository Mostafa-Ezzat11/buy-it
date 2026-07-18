import 'package:buy_it/firebase_options.dart';
import 'package:buy_it/provider/cart.dart';
import 'package:buy_it/screens/admin/add_product_page.dart';
import 'package:buy_it/screens/admin/admin_home.dart';
import 'package:buy_it/screens/admin/edit_product.dart';
import 'package:buy_it/screens/admin/manage_product.dart';
import 'package:buy_it/screens/admin/order_detail_page.dart';
import 'package:buy_it/screens/admin/orders_page.dart';
import 'package:buy_it/screens/user/cart_page.dart';
import 'package:buy_it/screens/login_page.dart';
import 'package:buy_it/screens/sign_up_page.dart';
import 'package:buy_it/screens/user/home_page.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BuyIt());
}

class BuyIt extends StatelessWidget {
  const BuyIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(create: (context) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          AdminHome.id: (context) => AdminHome(),
          AddProductPage.id: (context) => AddProductPage(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          HomePage.id: (context) => HomePage(),
          ProductInfo.id: (context) => ProductInfo(),
          CartPage.id: (context) => CartPage(),
          OrdersPage.id: (context) => OrdersPage(),
          OrderDetailPage.id: (context) => OrderDetailPage(),
        },
      ),
    );
  }
}
