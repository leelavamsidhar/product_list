import 'package:hive/hive.dart';

part 'products_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final double? price;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? category;

  @HiveField(5)
  final String? image;

  @HiveField(6)
  final Rating? rating;
  @HiveField(7)
  int? isCard = 0;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.isCard = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating:
      json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      isCard: json['isCard']
    );
  }
}

@HiveType(typeId: 1)
class Rating extends HiveObject {
  @HiveField(0)
  final double? rate;

  @HiveField(1)
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: json['count'],
    );
  }
}
