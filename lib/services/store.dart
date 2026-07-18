import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addproduct(ProductModel product) {
    firestore.collection(kproductcollection).add({
      kproductname: product.name,
      kproductcategory: product.category,
      kproductdescription: product.desc,
      kproductlocation: product.location,
      kproductprice: product.price,
    });
  }

  Stream<QuerySnapshot> getproducts() {
    var snapshot = firestore
        .collection(kproductcollection)
        .snapshots();
    return snapshot;
  }

  void deleteproduct(productId) {
    firestore.collection(kproductcollection).doc(productId).delete();
  }

  void editproduct(data, productId) {
    firestore
        .collection(kproductcollection)
        .doc(productId)
        .update(data);
  }

  void storeorders(data, List<ProductModel> products) {
    var docref = firestore.collection(korders).doc();
    docref.set(data);
    for (var product in products) {
      docref.collection(korderdetails).doc().set({
        kproductname: product.name,
        kproductprice: product.price,
        kproductlocation: product.location,
        kproductquantity: product.quantity,
        kproductcategory: product.category,
        kproductdescription: product.desc,
      });
    }
  }

  Stream<QuerySnapshot> loudorders() {
    var snapshot = firestore.collection(korders).snapshots();
    return snapshot;
  }

  Stream<QuerySnapshot> loudordersdetails(docid) {
    var snapshot = firestore
        .collection(korders)
        .doc(docid)
        .collection(korderdetails)
        .snapshots();
    return snapshot;
  }
}
