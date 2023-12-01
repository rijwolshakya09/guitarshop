import 'package:flutter/material.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/model/order.dart';
import 'package:guitarshop/repository/order_repository.dart';
import 'package:guitarshop/response/order_response.dart';
import 'package:guitarshop/utils/show_message.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wear/wear.dart';

class ShowOrderWear extends StatefulWidget {
  const ShowOrderWear({Key? key}) : super(key: key);

  @override
  State<ShowOrderWear> createState() => _ShowOrderWearState();
}

class _ShowOrderWearState extends State<ShowOrderWear> {
  _cancelOrder(String orderId) async {
    bool isCancel = await OrderRepository().cancelOrder(orderId);
    if (isCancel) {
      _displayMessage(isCancel);
      setState(() {});
    } else {
      _displayMessage(isCancel);
    }
  }

  _displayMessage(bool isCancel) {
    if (isCancel) {
      MotionToast.success(
              description: const Text("Order Cancelled Successfully"))
          .show(context);
    } else {
      MotionToast.error(
              description:
                  const Text("Something Went Wrong!!! Please Try Again!!!"))
          .show(context);
    }
  }

  _deleteOrder(String orderId) async {
    bool isDeleted = await OrderRepository().deleteOrder(orderId);
    if (isDeleted) {
      displaySuccessMessage(
          context, "Something Went Wrong!!! Please Try Again!!!");
      setState(() {});
    } else {
      displayErrorMessage(context, "Order Deleted Successfully");
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
                "My Order",
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
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    width: double.infinity,
                    child: FutureBuilder<OrderResponse?>(
                      future: OrderRepository().getOrder(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            // ProductResponse productResponse = snapshot.data!;
                            List<Order> lstOrder = snapshot.data!.data!;
                            return ListView.builder(
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  List<AddToCart> lstitems =
                                      lstOrder[index].order_item!;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 50,
                                          shadowColor: Colors.black,
                                          color: const Color(0xFF535699),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: lstitems.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(2, 4, 2, 4),
                                                      height: 100,
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xFF535699),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(children: [
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            CircleAvatar(
                                                              radius: 40,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFbdbfe9),
                                                              // backgroundImage:
                                                              //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                                                              child: ClipRect(
                                                                child: Image.network(
                                                                    "$baseUrl${lstitems[index].guitar_id!["guitar_image"]}",
                                                                    height: 120,
                                                                    width: 120),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    lstitems[index]
                                                                            .guitar_id![
                                                                        "guitar_name"],
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          'Merienda',
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Text(
                                                                    "Rs. " +
                                                                        lstitems[index]
                                                                            .guitar_id!["guitar_price"]
                                                                            .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          'Merienda',
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Text(
                                                                    "Quantity: " +
                                                                        lstitems[index]
                                                                            .quantity!
                                                                            .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          'Merienda',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(
                                                width: 300,
                                                height: 444,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        lstOrder[index]
                                                            .order_status!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Merienda',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        lstOrder[index]
                                                            .payment_method!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Merienda',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        lstOrder[index]
                                                            .payment_status!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Merienda',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        lstOrder[index]
                                                            .address!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Merienda',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        lstOrder[index]
                                                            .contact_no!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Merienda',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      lstOrder[index]
                                                                  .order_status ==
                                                              "Requested"
                                                          ? SizedBox(
                                                              width: 148,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _cancelOrder(
                                                                        lstOrder[index]
                                                                            .id!);
                                                                  });
                                                                },
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            const Color(0xFFbdbfe9))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(4),
                                                                  child: Row(
                                                                    children: const [
                                                                      Icon(Icons
                                                                          .cancel),
                                                                      Text(
                                                                          'Cancel Order')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      lstOrder[index]
                                                                  .order_status ==
                                                              "Cancelled"
                                                          ? SizedBox(
                                                              width: 148,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _deleteOrder(
                                                                        lstOrder[index]
                                                                            .id!);
                                                                  });
                                                                },
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            const Color(0xFFbdbfe9))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(4),
                                                                  child: Row(
                                                                    children: const [
                                                                      Icon(Icons
                                                                          .cancel),
                                                                      Text(
                                                                          'Delete Order')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
        );
      });
    });
  }
}
