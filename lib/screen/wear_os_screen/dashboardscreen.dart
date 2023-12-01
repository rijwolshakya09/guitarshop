import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/wpf.dart';
import 'package:wear/wear.dart';

class DashboardScreenState extends StatefulWidget {
  const DashboardScreenState({Key? key}) : super(key: key);

  @override
  State<DashboardScreenState> createState() => _DashboardScreenStateState();
}

class _DashboardScreenStateState extends State<DashboardScreenState> {
  // @override
  // void initState() {
  //   getGuitarDetails();
  //   super.initState();
  // }

  // GuitarResponse guitarResponse;

  // void getGuitarDetails() async {
  //   GuitarResponse? guitar = await GuitarRepository().getProducts();

  //   setState(() {
  //     user = user1!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Guitar Shop Dashboard",
                      style: TextStyle(
                        fontFamily: "Merienda",
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 50,
                  color: const Color(0xFFbdbfe9),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Iconify(
                              Ph.list_bullets_bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 120,
                          height: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/showcatwearos");
                            },
                            child: const Text(
                              "Categories",
                              style: TextStyle(
                                  fontFamily: "Merienda", fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "5",
                              style: TextStyle(
                                  fontFamily: "Merienda",
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  color: const Color(0xFFbdbfe9),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Iconify(
                              Wpf.guitar,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 120,
                          height: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/showguitarwearos");
                            },
                            child: const Text(
                              "Guitars",
                              style: TextStyle(
                                  fontFamily: "Merienda", fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "5",
                                style: TextStyle(
                                    fontFamily: "Merienda",
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  color: const Color(0xFFbdbfe9),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Iconify(
                              Fluent.cart_24_filled,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 120,
                          height: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/showcart");
                            },
                            child: const Text(
                              "Add To Cart",
                              style: TextStyle(
                                  fontFamily: "Merienda", fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontFamily: "Merienda",
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  color: const Color(0xFFbdbfe9),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Iconify(
                              Ic.round_shopping_bag,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 120,
                          height: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/showorderwearos");
                            },
                            child: const Text(
                              "My Order",
                              style: TextStyle(
                                  fontFamily: "Merienda", fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF535699),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontFamily: "Merienda",
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 120,
                  height: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF535699),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/");
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontFamily: "Merienda", fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
