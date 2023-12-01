import 'package:guitarshop/model/addtocart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  String? id;
  List<AddToCart>? order_item;
  int? total_price;
  String? order_status;
  String? payment_method;
  String? payment_status;
  String? address;
  String? contact_no;

  Order({
    this.id,
    this.order_item,
    this.total_price,
    this.order_status,
    this.payment_method,
    this.payment_status,
    this.address,
    this.contact_no,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
