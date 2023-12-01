import 'package:flutter/material.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/repository/addtocart_repository.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wear/wear.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  _deleteCart(String cartId) async {
    bool isDeleted = await AddToCartRepository().deleteCart(cartId);
    if (isDeleted) {
      _displayMessage(isDeleted);
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushNamed(context, "/addtocart");
      });
    } else {
      _displayMessage(isDeleted);
    }
  }

  _displayMessage(bool isDeleted) {
    if (isDeleted) {
      MotionToast.success(
        description: const Text("Cart Deleted Successfully"),
        toastDuration: const Duration(seconds: 1),
      ).show(context);
    } else {
      MotionToast.error(
              description:
                  const Text("Something Went Wrong!!! Please Try Again!!!"))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: AppBar(
              title: const Text(
                "Cart",
                style: TextStyle(
                  color: Color(0xFF535699),
                  fontSize: 12,
                  fontFamily: "Merienda",
                  // fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: const Color(0xFF535699),
                  child: IconButton(
                    icon: const Iconify(
                      Ic.round_arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              // leadingWidth: 100,
              toolbarHeight: 30,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
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
                      height: MediaQuery.of(context).size.height * 0.60,
                      width: double.infinity,
                      child: FutureBuilder<List<AddToCart?>>(
                        future: AddToCartRepository().getCart(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              if (snapshot.data!.isNotEmpty) {
                                List<AddToCart?> lstCart = snapshot.data!;
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: addtocartmain(lstCart[index]!),
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: Text("Cart Is Empty"),
                                );
                              }
                              // ProductResponse productResponse = snapshot.data!;

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
          ),
        );
      });
    });
  }

  Widget addtocartmain(AddToCart cart) {
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
                    "$baseUrl${cart.guitar_id!["guitar_image"]}",
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
                    cart.guitar_id!["guitar_name"],
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
                    "Rs. " + cart.guitar_id!["guitar_price"].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Quantity: " + cart.quantity!.toString(),
                    style: const TextStyle(
                      fontSize: 12,
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
                        _deleteCart(cart.id!);
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
