import 'package:buy_it/constants.dart';
import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  EditProduct({super.key});
  static String id = 'EditProduct';
  final GlobalKey<FormState> formstate = GlobalKey();
  String? _name, _price, _desc, _category, _location;

  @override
  Widget build(BuildContext context) {
    var productId = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
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
            SizedBox(height: 25),

            GestureDetector(
              onTap: () {
                if (formstate.currentState!.validate()) {
                  try {
                    Store().editproduct({
                      kproductname: _name!,
                      kproductprice: _price!,
                      kproductcategory: _category!,
                      kproductdescription: _desc!,
                      kproductlocation: _location!,
                    }, productId);
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
                child: Center(child: Text('Edit Product')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
