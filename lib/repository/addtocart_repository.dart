import 'package:guitarshop/api/addtocart_api.dart';
import 'package:guitarshop/model/addtocart.dart';

class AddToCartRepository {
  Future<List<AddToCart?>> getCart() async {
    return AddToCartAPI().getCart();
  }

  Future<bool> addCart(guitarId, int? quantity) async {
    return AddToCartAPI().addCart(guitarId, quantity);
  }

  Future<bool> deleteCart(String cartId) async {
    return AddToCartAPI().deleteCart(cartId);
  }
}
