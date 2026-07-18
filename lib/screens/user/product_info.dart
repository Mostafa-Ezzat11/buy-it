import 'package:buy_it/constants.dart';
import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/provider/cart.dart';
import 'package:buy_it/screens/user/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              image: AssetImage(product.location),
            ),
          ),

          Positioned(
            bottom: 70,
            child: Column(
              children: <Widget>[
                Opacity(
                  opacity: .6,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.desc,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kmaincolor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 25),

                              Text(
                                counter.toString(),
                                style: TextStyle(fontSize: 60),
                              ),
                              SizedBox(width: 25),

                              ClipOval(
                                child: Material(
                                  color: kmaincolor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Cart cart = Provider.of<Cart>(context, listen: false);
                bool exist = false;
                List<ProductModel> productsfound = cart.products;
                for (ProductModel productfound in productsfound) {
                  if (productfound.id == product.id) {
                    exist = true;
                  }
                }
                if (exist) {
                  showSnackBar(
                    context,
                    'You Have Added This product Before',
                  );
                } else {
                  product.quantity = counter;
                  cart.addproduct(product);
                  showSnackBar(context, 'Added to Cart');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kmaincolor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Add to card'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                    child: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void subtract() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }

  void add() {
    setState(() {
      counter++;
    });
  }
}
