import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guitarshop/components/layout.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/repository/addtocart_repository.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/foundation.dart' as foundation;

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({Key? key}) : super(key: key);

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
    });
  }

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

  List<AddToCart?>? lstCart;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isNear
          ? const SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
              ),
            )
          : SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: AppBar(
                    title: const Text(
                      "Add To Cart",
                      style: TextStyle(
                        color: Color(0xFF535699),
                        fontFamily: "Merienda",
                        fontWeight: FontWeight.bold,
                      ),
                      key: ValueKey("addtocarttitle"),
                    ),
                    centerTitle: true,
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: const Color(0xFF535699),
                        child: IconButton(
                          icon: const Iconify(
                            Ic.round_arrow_back_ios_new,
                            color: Colors.white,
                            size: 100,
                          ),
                          iconSize: 100,
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LayoutScreen()));
                          },
                        ),
                      ),
                    ),
                    // leadingWidth: 100,
                    toolbarHeight: 100,
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: addtocartmain(
                                                  lstCart[index]!),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
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
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  height: 72,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22.0),
                        topLeft: Radius.circular(22.0)),
                    color: Color(0xFF535699),
                  ),
                  width: double.infinity,
                  child: FutureBuilder<List<AddToCart?>>(
                    future: AddToCartRepository().getCart(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // debugPrint(snapshot.data.toString());
                        if (snapshot.data != null) {
                          // ProductResponse productResponse = snapshot.data!;
                          lstCart = snapshot.data!;
                          return bottomnav();
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
              ),
            ),
    );
  }

  // Widget addtocart(AddToCart cart) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
  //     child: Column(
  //       children: [
  //         Card(
  //           elevation: 50,
  //           shadowColor: Colors.black,
  //           color: const Color(0xFF535699),
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(12)),
  //           ),
  //           child: SizedBox(
  //             width: 300,
  //             height: 444,
  //             child: Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     height: 136,
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       // border: Border.all(color: Colors.black),
  //                       borderRadius: BorderRadius.circular(12),
  //                       image: DecorationImage(
  //                         image: NetworkImage(
  //                             "$baseUrl${cart.guitar_id!["guitar_image"]}"),
  //                         fit: BoxFit.contain,
  //                         // opacity: 5,
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         cart.guitar_id!["guitar_name"],
  //                         style: const TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                           fontFamily: 'Merienda',
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   // Text(
  //                   //   blogs.blog_title!,
  //                   //   style: const TextStyle(
  //                   //     color: Colors.white,
  //                   //     fontWeight: FontWeight.bold,
  //                   //     fontSize: 20,
  //                   //     fontFamily: 'Merienda',
  //                   //   ),
  //                   // ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     cart.guitar_id!["guitar_price"].toString(),
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: Colors.white,
  //                       fontFamily: 'Merienda',
  //                     ),
  //                     textAlign: TextAlign.justify,
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     cart.quantity!.toString(),
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: Colors.white,
  //                       fontFamily: 'Merienda',
  //                     ),
  //                     textAlign: TextAlign.justify,
  //                   ),
  //                   // SizedBox(
  //                   //   width: 128,
  //                   //   child: ElevatedButton(
  //                   //     onPressed: () {},
  //                   //     style: ButtonStyle(
  //                   //         backgroundColor: MaterialStateProperty.all(
  //                   //             const Color(0xFFbdbfe9))),
  //                   //     child: Padding(
  //                   //       padding: const EdgeInsets.all(4),
  //                   //       child: Row(
  //                   //         children: const [
  //                   //           Icon(Icons.touch_app),
  //                   //           Text('See More')
  //                   //         ],
  //                   //       ),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//Add To Cart Main Widget Design
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

//BottomCard Design
  Widget bottomnav() {
    var totalprice = lstCart!.fold(
        0,
        (int sum, item) =>
            sum +
            int.parse(item!.guitar_id["guitar_price"].toString()) *
                item.quantity!);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rs." + totalprice.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Merienda',
            ),
          ),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/order');
              },
              icon: const Iconify(
                Fluent.cart_24_filled,
                color: Color(0xFF535699),
                size: 40,
              ),
              label: const Text(
                "Checkout",
                style: TextStyle(
                    color: Color(0xFF535699),
                    fontFamily: "Merienda",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
