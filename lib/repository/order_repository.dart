import 'package:guitarshop/api/order_api.dart';
import 'package:guitarshop/response/order_response.dart';

class OrderRepository {
  Future<OrderResponse?> getOrder() async {
    return OrderAPI().getOrder();
  }

  Future<bool> addOrder(
    orderItem,
    int totalPrice,
    String paymentMethod,
    String? address,
    String? contactNo,
  ) async {
    return OrderAPI().addOrder(
      orderItem,
      totalPrice,
      paymentMethod,
      address,
      contactNo,
    );
  }

  Future<bool> deleteOrder(String orderId) async {
    return OrderAPI().deleteOrder(orderId);
  }

  Future<bool> cancelOrder(String orderId) async {
    return OrderAPI().cancelOrder(orderId);
  }
}
