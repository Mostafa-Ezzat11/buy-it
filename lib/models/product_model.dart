class ProductModel {
  String name;
  String price;
  String desc;
  String category;
  String location;
  String? id;
  int? quantity;

  ProductModel({
    this.id,
    this.quantity,
    required this.name,
    required this.price,
    required this.category,
    required this.desc,
    required this.location,
  });
}
