import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProductPage extends StatelessWidget {
  static String id = 'AddProduct';
  AddProductPage({super.key});
  final GlobalKey<FormState> formstate = GlobalKey();

  String? _name, _price, _desc, _category, _location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Form(
        key: formstate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: 'Product Name',
              onchange: (data) => _name = data,
            ),
            SizedBox(height: 10),

            CustomTextFormField(
              hintText: 'Product Price',
              onchange: (data) => _price = data,
            ),
            SizedBox(height: 10),

            CustomTextFormField(
              hintText: 'Product Description',
              onchange: (data) => _desc = data,
            ),
            SizedBox(height: 10),

            CustomTextFormField(
              hintText: 'Product Category',
              onchange: (data) => _category = data,
            ),
            SizedBox(height: 10),

            CustomTextFormField(
              hintText: 'Product Location',
              onchange: (data) => _location = data,
            ),
            SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                if (formstate.currentState!.validate()) {
                  try {
                    Store().addproduct(
                      ProductModel(
                        name: _name!,
                        price: _price!,
                        category: _category!,
                        desc: _desc!,
                        location: _location!,
                      ),
                    );
                    showSnackBar(context, 'Done !');
                    //formstate.currentState!.reset();
                  } on Exception {
                    showSnackBar(
                      context,
                      'There is an error try again later',
                    );
                  }
                }
              },
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
          ],
        ),
      ),
    );
  }
}
