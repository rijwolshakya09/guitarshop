// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      order_item: (json['order_item'] as List<dynamic>?)
          ?.map((e) => AddToCart.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_price: json['total_price'] as int?,
      order_status: json['order_status'] as String?,
      payment_method: json['payment_method'] as String?,
      payment_status: json['payment_status'] as String?,
      address: json['address'] as String?,
      contact_no: json['contact_no'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'order_item': instance.order_item,
      'total_price': instance.total_price,
      'order_status': instance.order_status,
      'payment_method': instance.payment_method,
      'payment_status': instance.payment_status,
      'address': instance.address,
      'contact_no': instance.contact_no,
    };
