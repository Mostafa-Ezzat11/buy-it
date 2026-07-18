import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/user/cart_page.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({
    super.key,
    required this.email,
    required this.password,
  });
  final String email, password;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome', style: TextStyle(fontSize: 25)),
              SizedBox(height: 50),
              Text(
                'Your Email is : $email',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
          child: Material(
            color: ksecondcolor,
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
    );
  }
}
