// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  final int id;
  final String title;
  final String description;
  final Category category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  // final String brand;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final AvailabilityStatus availabilityStatus;
  final List<Review> reviews;
  final ReturnPolicy returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    // required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: categoryValues.map[json["category"]]!,
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        //brand: json["brand"],
        sku: json["sku"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        warrantyInformation: json["warrantyInformation"],
        shippingInformation: json["shippingInformation"],
        availabilityStatus:
            availabilityStatusValues.map[json["availabilityStatus"]]!,
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        returnPolicy: returnPolicyValues.map[json["returnPolicy"]]!,
        minimumOrderQuantity: json["minimumOrderQuantity"],
        meta: Meta.fromJson(json["meta"]),
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": categoryValues.reverse[category],
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        //"brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformation,
        "availabilityStatus":
            availabilityStatusValues.reverse[availabilityStatus],
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "returnPolicy": returnPolicyValues.reverse[returnPolicy],
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
      };
}

enum AvailabilityStatus { IN_STOCK, LOW_STOCK }

final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.IN_STOCK,
  "Low Stock": AvailabilityStatus.LOW_STOCK
});

enum Category { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES
});

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
      };
}

class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        barcode: json["barcode"],
        qrCode: json["qrCode"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "barcode": barcode,
        "qrCode": qrCode,
      };
}

enum ReturnPolicy {
  NO_RETURN_POLICY,
  THE_30_DAYS_RETURN_POLICY,
  THE_60_DAYS_RETURN_POLICY,
  THE_7_DAYS_RETURN_POLICY,
  THE_90_DAYS_RETURN_POLICY
}

final returnPolicyValues = EnumValues({
  "No return policy": ReturnPolicy.NO_RETURN_POLICY,
  "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
  "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
  "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
  "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY
});

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}





//
//
//
//
// class ProductModel {
//   int id;
//   String title;
//   String price;
//   String discountPercentage;
//   String thumbnail;
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.discountPercentage,
//     required this.thumbnail,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//   return ProductModel(
//       id: json['id'],
//       title: json['title'],
//       price: json['price'],
//       discountPercentage: json['discountPercentage'].toDouble(),
//       thumbnail: json['thumbnail'],
//   );
// }
// }
//
