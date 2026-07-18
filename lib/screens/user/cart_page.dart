import 'package:buy_it/constants.dart';
import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/provider/cart.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static String id = 'CartPage';

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double statbar = MediaQuery.of(context).padding.top;
    List<ProductModel> products = Provider.of<Cart>(context).products;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (products.isEmpty) {
                return SizedBox(
                  height:
                      screenheight -
                      (screenheight * 0.12) -
                      statbar -
                      56,
                  child: Center(child: Text('The Cart is Empty')),
                );
              } else {
                return SizedBox(
                  height:
                      screenheight -
                      (screenheight * 0.12) -
                      statbar -
                      56,
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Container(
                          height: screenheight * 0.12,
                          color: const Color.fromARGB(
                            255,
                            255,
                            223,
                            149,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: (screenheight * .12) / 2,
                                backgroundImage: AssetImage(
                                  products[index].location,
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            products[index].name,
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '\$ ${products[index].price}',
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          Cart cart =
                                              Provider.of<Cart>(
                                                context,
                                                listen: false,
                                              );
                                          cart.deleteproduct(
                                            products[index],
                                          );
                                        },
                                        icon: Icon(Icons.delete),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                            context,
                                            ProductInfo.id,
                                            arguments:
                                                products[index],
                                          );
                                          Cart cart =
                                              Provider.of<Cart>(
                                                context,
                                                listen: false,
                                              );
                                          cart.deleteproduct(
                                            products[index],
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),

                                      Text(
                                        products[index].quantity
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),

          GestureDetector(
            onTap: () {
              showCustomDialog(products, context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: kmaincolor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              height: screenheight * .12,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'order'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(List<ProductModel> products, context) async {
    var price = getTotalPrice(products);
    String? address;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    AlertDialog alertDialog = AlertDialog(
      title: Text('Total Price = \$$price'),
      actions: [
        MaterialButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              try {
                Store().storeorders({
                  ktotalprice: price,
                  kaddress: address!.trim(),
                }, products);

                showSnackBar(context, 'Done!');
                Navigator.pop(context);
              } catch (e) {
                print(e.toString());
              }
            }
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      content: Form(
        key: formKey,
        child: TextFormField(
          onChanged: (value) => address = value,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: 'Enter Your Address',
            errorStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    await showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  int getTotalPrice(List<ProductModel> products) {
    var price = 0;
    for (var product in products) {
      price += product.quantity! * (int.parse(product.price));
    }
    return price;
  }
}
