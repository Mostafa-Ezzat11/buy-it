import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/admin/add_product_page.dart';
import 'package:buy_it/screens/admin/manage_product.dart';
import 'package:buy_it/screens/admin/orders_page.dart';
import 'package:buy_it/services/auth_service%20.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmaincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, AddProductPage.id),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 120,
              child: Center(child: Text('Add Product')),
            ),
          ),
          SizedBox(height: 20),

          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, ManageProduct.id),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 120,
              child: Center(child: Text('Manage Products')),
            ),
          ),
          SizedBox(height: 20),

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, OrdersPage.id),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 120,
              child: Center(child: Text('View Orders')),
            ),
          ),
          SizedBox(height: 100),

          GestureDetector(
            onTap: () {
              showLogoutDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 120,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
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
                Navigator.pop(context); // to pop logout screen
                Navigator.pop(context); // to pop AdminHome screen
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
