import 'package:flutter/material.dart';
import 'package:guitarshop/model/wishlist.dart';
import 'package:guitarshop/repository/wishlist_repository.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:motion_toast/motion_toast.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  _deleteWishlist(String wishlistId) async {
    bool isDeleted = await WishlistRepository().deleteWishlist(wishlistId);
    if (isDeleted) {
      _displayMessage(isDeleted);
      setState(() {});
      // Navigator.pushNamed(context, "/layout[3]");
    } else {
      _displayMessage(isDeleted);
    }
  }

  _displayMessage(bool isDeleted) {
    if (isDeleted) {
      MotionToast.success(
              description: const Text("Wishlist Removed Successfully"))
          .show(context);
    } else {
      MotionToast.error(
              description:
                  const Text("Something Went Wrong!!! Please Try Again!!!"))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFbdbfe9),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  width: double.infinity,
                  child: FutureBuilder<List<Wishlist?>>(
                    future: WishlistRepository().getWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          // ProductResponse productResponse = snapshot.data!;
                          List<Wishlist?> lstWishlist = snapshot.data!;
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: wishlistmain(lstWishlist[index]!),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text("No data"),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget wishlistmain(Wishlist wishlist) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      height: 100,
      decoration: const BoxDecoration(
          color: Color(0xFF535699),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            const SizedBox(
              width: 6,
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFbdbfe9),
              // backgroundImage:
              //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
              child: ClipRect(
                child: Image.network(
                    "$baseUrl${wishlist.guitar_id!["guitar_image"]}",
                    height: 120,
                    width: 120),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wishlist.guitar_id!["guitar_name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Rs. " + wishlist.guitar_id!["guitar_price"].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: Row(
              children: [
                const VerticalDivider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 0,
                  thickness: 2,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFbdbfe9),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _deleteWishlist(wishlist.id!);
                      });
                    },
                    icon: const Iconify(
                      Ion.md_trash,
                      color: Color(0xFF535699),
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
