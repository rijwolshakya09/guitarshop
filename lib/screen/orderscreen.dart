import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/addtocart.dart';
import 'package:guitarshop/repository/addtocart_repository.dart';
import 'package:guitarshop/repository/order_repository.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:motion_toast/motion_toast.dart';

class OrderScreenState extends StatefulWidget {
  const OrderScreenState({Key? key}) : super(key: key);

  @override
  State<OrderScreenState> createState() => _OrderScreenStateState();
}

class _OrderScreenStateState extends State<OrderScreenState> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  int counter = 1;

  final _addressController = TextEditingController();
  final _contactNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Initial Selected Value
  String dropdownvalue = 'Cash on Delivery';

  // List of items in our dropdown menu
  var items = [
    'Cash on Delivery',
    'eSewa',
    'Khalti',
  ];

  _orderGuitar(
    orderItem,
    int totalPrice,
    String paymentMethod,
    String? address,
    String? contactNo,
  ) async {
    bool isAdded = await OrderRepository().addOrder(
      orderItem,
      totalPrice,
      paymentMethod,
      address,
      contactNo,
    );
    if (isAdded) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: counter,
          channelKey: 'basic_channel',
          title: 'Order Success',
          body: 'Your Order Has Been Placed Successfully',
        ),
      );
      setState(() {
        counter++;
      });
      Navigator.pushNamed(context, "/layout");
      _displayMessage(isAdded);
    } else {
      _displayMessage(isAdded);
    }
  }

  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(
              description: const Text("Guitar Order Made Successfully"))
          .show(context);
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            title: const Text(
              "Checkout Process",
              style: TextStyle(
                color: Color(0xFF535699),
                fontFamily: "Merienda",
                fontWeight: FontWeight.bold,
              ),
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
                    Navigator.of(context).pop();
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
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFbdbfe9),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Guitars",
                        style: TextStyle(
                          color: Color(0xFF535699),
                          fontFamily: "Merienda",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: FutureBuilder<List<AddToCart?>>(
                          future: AddToCartRepository().getCart(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                // ProductResponse productResponse = snapshot.data!;
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
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color(0xFF535699),
                  indent: 4,
                  endIndent: 4,
                  thickness: 2,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFbdbfe9),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Shipping And Payment",
                          style: TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: "Merienda",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF535699),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            // color: const Color(0xFF535699),
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _addressController,
                            cursorColor: const Color(0xFF535699),
                            style: const TextStyle(
                              color: Color(0xFF535699),
                              fontFamily: 'Merienda',
                            ),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              icon: Iconify(
                                Ph.address_book_fill,
                                color: Color(0xFF535699),
                                size: 34,
                              ),
                              // labelText: 'Shipping Address',
                              hintText: 'Enter Shipping Address',
                              labelStyle: TextStyle(fontSize: 18),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Shipping Address';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF535699),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            // color: const Color(0xFF535699),
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _contactNoController,
                            cursorColor: const Color(0xFF535699),
                            style: const TextStyle(
                              color: Color(0xFF535699),
                              fontFamily: 'Merienda',
                            ),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              icon: Iconify(
                                Ic.round_phone,
                                color: Color(0xFF535699),
                                size: 34,
                              ),
                              // labelText: 'Contact No.',
                              hintText: 'Enter Contact No.',
                              labelStyle: TextStyle(fontSize: 18),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Contact No.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF535699), width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF535699), width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              // fillColor: Colors.blueAccent,
                              hintText: "Select Payment Method"),
                          style: const TextStyle(
                              fontFamily: "Merienda",
                              color: Color(0xFF535699),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color(0xFF535699),
                  indent: 4,
                  endIndent: 4,
                  thickness: 2,
                ),
                // Container(
                //   decoration: const BoxDecoration(
                //     color: Color(0xFFbdbfe9),
                //     borderRadius: BorderRadius.all(Radius.circular(12)),
                //   ),
                //   child: Column(
                //     children: const [
                //       Text(
                //         "Total Price",
                //         style: TextStyle(
                //           color: Color(0xFF535699),
                //           fontFamily: "Merienda",
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          height: 122,
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
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

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
          Row(
            children: [
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
            ],
          ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total Price: Rs." + totalprice.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Merienda',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _orderGuitar(
                    lstCart,
                    totalprice,
                    dropdownvalue,
                    _addressController.text,
                    _contactNoController.text,
                  );
                }
              },
              icon: const Iconify(
                Mdi.shopping,
                color: Color(0xFF535699),
                size: 30,
              ),
              label: const Text(
                "Place Order",
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
          )
        ],
      ),
    );
  }
}
