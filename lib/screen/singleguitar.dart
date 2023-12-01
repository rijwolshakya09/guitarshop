import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guitarshop/model/review.dart';
import 'package:guitarshop/model/show_guitar.dart';
import 'package:guitarshop/repository/addtocart_repository.dart';
import 'package:guitarshop/repository/guitar_repository.dart';
import 'package:guitarshop/repository/review_repository.dart';
import 'package:guitarshop/response/guitar_single_response.dart';
import 'package:guitarshop/response/review_response.dart';
import 'package:guitarshop/utils/show_message.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shake/shake.dart';

import '../utils/url.dart';

class SingleGuitarScreen extends StatefulWidget {
  const SingleGuitarScreen({Key? key}) : super(key: key);

  @override
  State<SingleGuitarScreen> createState() => _SingleGuitarScreenState();
}

class _SingleGuitarScreenState extends State<SingleGuitarScreen> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          Navigator.pushNamed(context, '/addtocart');
        });
      },
    );
  }

  @override
  void dispose() {
    detector.stopListening();

    super.dispose();
  }

  int _guitarQuantity = 1;

  void _incrementCount() {
    setState(() {
      _guitarQuantity++;
    });
  }

  void _decrementCount() {
    setState(() {
      _guitarQuantity--;
    });
  }

  _addtocart(guitarId, int? quantity) async {
    if (quantity! > 0) {
      bool isAdded = await AddToCartRepository().addCart(guitarId, quantity);
      if (isAdded) {
        Navigator.pushNamed(context, "/addtocart");
        _displayMessage(isAdded);
      } else {
        _displayMessage(isAdded);
      }
    } else {
      (e) {
        debugPrint(e);
      };
    }
  }

  _addreview(guitarId, String comment, int rating) async {
    bool isAdded =
        await ReviewRepository().addReview(guitarId, comment, rating);
    if (isAdded) {
      setState(() {});
      displaySuccessMessage(
          context, "Something Went Wrong!!! Please Try Again");
    } else {
      displayErrorMessage(context, "Review Added Successfully");
    }
  }

  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(
              description: const Text("Guitar Added To Cart Successfully"))
          .show(context);
    } else {
      MotionToast.error(
              description:
                  const Text("Something Went Wrong!!! Please Try Again!!!"))
          .show(context);
    }
  }

  final _commentController = TextEditingController();

  double value = 3.5;
  String? guitarId = "";
  int? grating;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String?;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            title: const Text(
              "Guitar Details",
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
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.98,
                  width: double.infinity,
                  child: FutureBuilder<GuitarSingleResponse?>(
                    future: GuitarRepository().getSingleProducts(productId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // debugPrint(snapshot.data.toString());
                        if (snapshot.data != null) {
                          // ProductResponse productResponse = snapshot.data!;
                          ShowGuitar lstGuitarCategory = snapshot.data!.data!;
                          // guitarId = lstGuitarCategory.id;
                          // debugPrint("GuitarId : in front : " + guitarId!);
                          return guitarmain(lstGuitarCategory);
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
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0)),
                    color: Color(0xFFbdbfe9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ratings & Reviews",
                              style: TextStyle(
                                color: Color(0xFF535699),
                                fontFamily: "Merienda",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 300,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(24.0),
                                                bottomLeft:
                                                    Radius.circular(24.0)),
                                            color: Color(0xFFbdbfe9),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  // const TextField(
                                                  //   keyboardType:
                                                  //       TextInputType.multiline,
                                                  //   textInputAction:
                                                  //       TextInputAction.newline,
                                                  //   minLines: 1,
                                                  //   maxLines: 5,
                                                  // ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(4, 0, 0, 0),
                                                    height: 80,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF535699),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: const Color(0xFF535699),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      controller:
                                                          _commentController,
                                                      cursorColor: const Color(
                                                          0xFF535699),
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF535699),
                                                        fontFamily: 'Merienda',
                                                      ),
                                                      minLines: 1,
                                                      maxLines: 5,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      textInputAction:
                                                          TextInputAction
                                                              .newline,
                                                      decoration:
                                                          const InputDecoration(
                                                        icon: Iconify(
                                                          Ic.baseline_insert_comment,
                                                          color:
                                                              Color(0xFF535699),
                                                          size: 34,
                                                        ),
                                                        // labelText: 'Comment',
                                                        hintText:
                                                            'Write Your Comment',
                                                        labelStyle: TextStyle(
                                                            fontSize: 18),
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Please Enter Your Comment';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      setState(() {
                                                        grating =
                                                            rating.toInt();
                                                      });
                                                      print(rating);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (grating != null) {
                                                            _addreview(
                                                                productId,
                                                                _commentController
                                                                    .text,
                                                                grating!);
                                                          } else {
                                                            _addreview(
                                                                productId,
                                                                _commentController
                                                                    .text,
                                                                0);
                                                          }
                                                        });
                                                      },
                                                      child: const Text(
                                                        "Post Review",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF535699),
                                                            fontFamily:
                                                                "Merienda",
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Text(
                                  "Add Review",
                                  style: TextStyle(
                                      color: Color(0xFF535699),
                                      fontFamily: "Merienda",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: FutureBuilder<ReviewResponse?>(
                            future: ReviewRepository().getReview(productId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // debugPrint(snapshot.data.toString());
                                debugPrint(snapshot.data.toString());
                                if (snapshot.data != null) {
                                  // ProductResponse productResponse = snapshot.data!;
                                  List<Review> lstReview = snapshot.data!.data!;
                                  return ListView.builder(
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: reviewmain(lstReview[index]),
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
                ),
              ],
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
          child: FutureBuilder<GuitarSingleResponse?>(
            future: GuitarRepository().getSingleProducts(productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // debugPrint(snapshot.data.toString());
                if (snapshot.data != null) {
                  // ProductResponse productResponse = snapshot.data!;
                  ShowGuitar lstGuitarCategory = snapshot.data!.data!;
                  return bottomnav(lstGuitarCategory);
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

  //===================Widget For Guitars Section=================================
  Widget guitarmain(ShowGuitar guitar) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            RotationTransition(
              turns: const AlwaysStoppedAnimation(30 / 360),
              child: CircleAvatar(
                radius: 200,
                backgroundColor: const Color(0xFFbdbfe9),
                // backgroundImage:
                //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                child: ClipRect(
                  child: Image.network(
                    "$baseUrl${guitar.guitar_image!}",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    topLeft: Radius.circular(24.0)),
                color: Color(0xFFbdbfe9),
              ),
              // height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    guitar.guitar_rich_name!,
                    style: const TextStyle(
                      color: Color(0xFF535699),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  // const SizedBox(height: 4),
                  Text(
                    guitar.guitar_desc!,
                    style: const TextStyle(
                      color: Color(0xFF535699),
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Merienda',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(
                    color: Color(0xFF535699),
                    indent: 0,
                    endIndent: 0,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Guitar Category: ",
                        style: TextStyle(
                          color: Color(0xFF535699),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'Merienda',
                        ),
                      ),
                      Text(
                        guitar.guitar_category!.category_name!,
                        style: const TextStyle(
                          color: Color(0xFF535699),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Merienda',
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFF535699),
                    indent: 0,
                    endIndent: 0,
                    thickness: 2,
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF535699)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                            ),
                            child: const Icon(Icons.remove),
                            onPressed: _decrementCount,
                          ),
                          Text(
                            " $_guitarQuantity",
                            style: const TextStyle(
                              fontFamily: "Merienda",
                              color: Color(0xFF535699),
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF535699),
                            ),
                            child: const Icon(Icons.add),
                            onPressed: _incrementCount,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //===================Widget For Guitars Section=================================
  Widget reviewmain(Review review) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xFF535699),
      ),
      height: 115,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFbdbfe9),
                backgroundImage:
                    NetworkImage("$baseUrl${review.user_id!.profile_pic}"),
                // child: ClipRect(
                //   child: Image.network("$baseUrl${review.user_id!.profile_pic}",
                //       height: 120, width: 120),
                // ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                review.user_id!.full_name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Merienda',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    review.comment!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  itemSize: 20,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 8,
                  ),
                  onRatingUpdate: (rating) {
                    rating:
                    5;
                    // rating:
                    // review.rating!;
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomnav(ShowGuitar guitar) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rs." + guitar.guitar_price!.toString(),
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
              key: const ValueKey("addtocart"),
              onPressed: () {
                _addtocart(guitar.id, _guitarQuantity);
              },
              icon: const Iconify(
                Fluent.cart_24_filled,
                color: Color(0xFF535699),
                size: 60,
              ),
              label: const Text(
                "Add To Cart",
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
