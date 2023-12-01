import 'package:guitarshop/response/category_guitar_response.dart';
import 'package:guitarshop/response/guitar_single_response.dart';

import '../api/guitar_api.dart';

class GuitarRepository {
  Future<GuitarResponse?> getProducts() async {
    return GuitarAPI().getProducts();
  }

  Future<GuitarSingleResponse?> getSingleProducts(productId) async {
    return GuitarAPI().getSingleProducts(productId);
  }
}
