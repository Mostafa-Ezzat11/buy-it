import 'package:buy_it/models/product_model.dart';
import 'package:flutter/widgets.dart';

class Cart extends ChangeNotifier {
  List<ProductModel> products = [];

  void addproduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void deleteproduct(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }
}
