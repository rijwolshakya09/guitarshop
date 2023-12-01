import 'package:guitarshop/api/wishlist_api.dart';
import 'package:guitarshop/model/wishlist.dart';

class WishlistRepository {
  Future<List<Wishlist?>> getWishlist() async {
    return WishlistAPI().getWishlist();
  }

  Future<bool> addWishlist(guitarId) async {
    return WishlistAPI().addWishlist(guitarId);
  }

  Future<bool> deleteWishlist(String wishlistId) async {
    return WishlistAPI().deleteWishlist(wishlistId);
  }
}
