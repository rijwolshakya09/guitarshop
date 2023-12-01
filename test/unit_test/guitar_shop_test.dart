import 'package:flutter_test/flutter_test.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/model/customer.dart';
import 'package:guitarshop/model/wishlist.dart';
import 'package:guitarshop/repository/addtocart_repository.dart';
import 'package:guitarshop/repository/blog_repository.dart';
import 'package:guitarshop/repository/customer_repository.dart';
import 'package:guitarshop/repository/guitar_repository.dart';
import 'package:guitarshop/repository/profile_repository.dart';
import 'package:guitarshop/repository/wishlist_repository.dart';
import 'package:guitarshop/response/blog_response.dart';
import 'package:guitarshop/response/category_guitar_response.dart';

void main() {
  late CustomerRepository? customerRepository;
  late ProfileRepository? profileRepository;
  late GuitarRepository? guitarRepository;
  late BlogRepository? blogRepository;
  late AddToCartRepository? addToCartRepository;
  late WishlistRepository? wishlistRepository;

  setUp(() {
    customerRepository = CustomerRepository();
    profileRepository = ProfileRepository();
    guitarRepository = GuitarRepository();
    blogRepository = BlogRepository();
    addToCartRepository = AddToCartRepository();
    wishlistRepository = WishlistRepository();
  });

  group("User API Test", () {
    test("User Registration Test", () async {
      bool expectedResult = true;
      Customer customer = Customer(
        full_name: "Rijwol Shakya",
        contact_no: "9861291534",
        username: "rijwol09",
        email: "shakya@gmail.com",
        password: "shakya09",
      );
      bool actualResult = await (CustomerRepository().registerUser(customer));

      expect(expectedResult, actualResult);
    });

    test("User Login Test", () async {
      bool expectedResult = true;

      String username = "rijwol09";
      String password = "shakya09";

      bool actualResult =
          await (CustomerRepository().login(username, password));

      expect(expectedResult, actualResult);
    });
  });

  group("Get Guitars From API", () {
    test("Get Guitar Test", () async {
      bool expectedResult = true;
      bool actualResult = false;
      GuitarResponse? guitarResponse = await guitarRepository!.getProducts();
      if (guitarResponse != null) actualResult = guitarResponse.success!;
      expect(expectedResult, actualResult);
    });
  });

  group("Get Blogs From API", () {
    test("Get Blogs Test", () async {
      bool expectedResult = true;
      bool actualResult = false;
      BlogResponse? blogResponse = await blogRepository!.getBlog();
      if (blogResponse != null) actualResult = blogResponse.success!;
      expect(expectedResult, actualResult);
    });
  });

  group('Add To Cart API Test', () {
    test("Add To Cart Test", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String guitarId = "62d95136f6ae0884a474539e";
      int quantity = 1;
      actualResult = await addToCartRepository!.addCart(guitarId, quantity);
      expect(expectedResult, actualResult);
    });
    test("Get Cart User Id Check Test", () async {
      // bool expectedResult = true;
      String actualResult = "";
      String expectedResult = "62c26c318804a0abc8545943";
      List<AddToCart?> cartRes = await addToCartRepository!.getCart();
      actualResult = cartRes[0]!.user_id!;
      expect(expectedResult, actualResult);
    });
    test("Get Cart User Id Check Test Wrong ID", () async {
      // bool expectedResult = true;
      String actualResult = "";
      String expectedResult = "62ea2845dde36abf886052ad";
      List<AddToCart?> cartRes = await addToCartRepository!.getCart();
      actualResult = cartRes[0]!.user_id!;
      expect(expectedResult, actualResult);
    });
    test("Delete Add To Cart", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String cartId = "62ea2845dde36abf886052ad";
      actualResult = await addToCartRepository!.deleteCart(cartId);
      expect(expectedResult, actualResult);
    });
  });

  group('Wishlist API Test', () {
    test("Add Wishlist", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String guitarId = "62d95136f6ae0884a474539e";
      actualResult = await wishlistRepository!.addWishlist(guitarId);
      expect(expectedResult, actualResult);
    });
    test("Get Wishlist User Id Check Test", () async {
      // bool expectedResult = true;
      String actualResult = "";
      String expectedResult = "62c26c318804a0abc8545943";
      List<Wishlist?> wishlistRes = await wishlistRepository!.getWishlist();
      actualResult = wishlistRes[0]!.user_id!;
      expect(expectedResult, actualResult);
    });
    test("Get Wishlist User Id Check Test Wrong ID", () async {
      // bool expectedResult = true;
      String actualResult = "";
      String expectedResult = "62ea4250dde36abf886055d3";
      List<Wishlist?> wishlistRes = await wishlistRepository!.getWishlist();
      actualResult = wishlistRes[0]!.user_id!;
      expect(expectedResult, actualResult);
    });
    test("Delete Wishlist", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String wishlistId = "62ea4250dde36abf886055d3";
      actualResult = await wishlistRepository!.deleteWishlist(wishlistId);
      expect(expectedResult, actualResult);
    });
  });

  // group('Review API test', () {
  //   test("Add Review", () async {
  //     bool expectedResult = true;
  //     bool actualResult = false;
  //     String vehicleId = "`62bd57a6bdc155ba1c6f70c43";
  //     Review review = Review(
  //         rating: "4",
  //         review: "It was easy to drive and there was no any problems.");
  //     actualResult = await reviewRepository!.addReview(review, vehicleId);
  //     expect(expectedResult, actualResult);
  //   });
  //   test("Get Reviews", () async {
  //     bool expectedResult = true;
  //     bool actualResult = false;
  //     String vehicleId = "62bd57a6bdc155ba1c6f70c4";
  //     ReviewResponse? reviewRes = await reviewRepository!.getReview(vehicleId);
  //     if (reviewRes != null) actualResult = reviewRes.success!;
  //     expect(expectedResult, actualResult);
  //   });
  // });

  tearDown(() {
    customerRepository = null;
    guitarRepository = null;
    blogRepository = null;
    addToCartRepository = null;
  });
}
