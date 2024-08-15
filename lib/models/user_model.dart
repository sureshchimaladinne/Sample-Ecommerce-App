// class UserModel {
//   String? uid;
//   String? name;
//   String? email;

//   UserModel({this.uid, this.name, this.email});

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'],
//       name: map['name'],
//       email: map['email'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'name': name,
//       'email': email,
//     };
//   }
// }
class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      price: json['price'].toDouble(),
    );
  }
}

class ProductList {
  final List<Product> products;

  ProductList({required this.products});

  factory ProductList.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> products =
        productList.map((product) => Product.fromJson(product)).toList();
    return ProductList(products: products);
  }
}
