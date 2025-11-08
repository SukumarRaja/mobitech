import 'package:json_annotation/json_annotation.dart';

part 'products_list_model.g.dart';

@JsonSerializable()
class ProductResponse {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class Rating {
  @JsonKey(name: 'rate')
  double rate;
  @JsonKey(name: 'count')
  int count;

  Rating({required this.rate, required this.count});
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
