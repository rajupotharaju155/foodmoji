import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product{
  String name, description, quantity;

  Product({
    this.name, this.description, this.quantity
  });

  factory Product.fromJson(Map<String, dynamic> data)=> _$ProductFromJson(data);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}