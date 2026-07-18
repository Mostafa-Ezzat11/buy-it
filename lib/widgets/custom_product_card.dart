import 'package:buy_it/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  final List<ProductModel> products;
  final int index;

  const CustomProductCard({
    super.key,
    required this.products,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(products[index].location),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: .9,
              child: Container(
                color: Colors.white,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${products[index].price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
}
