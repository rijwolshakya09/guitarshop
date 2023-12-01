import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_guitar.dart';
import 'package:guitarshop/repository/guitar_repository.dart';
import 'package:guitarshop/repository/wishlist_repository.dart';
import 'package:guitarshop/response/category_guitar_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wear/wear.dart';

class GuitarShowWearOs extends StatefulWidget {
  const GuitarShowWearOs({Key? key}) : super(key: key);

  @override
  State<GuitarShowWearOs> createState() => _GuitarShowWearOsState();
}

class _GuitarShowWearOsState extends State<GuitarShowWearOs> {
  _wishlist(guitarId) async {
    bool isAdded = await WishlistRepository().addWishlist(guitarId);
    if (isAdded) {
      _displayMessage(isAdded);
      Navigator.pushNamed(context, "/layout[3]");
    } else {
      _displayMessage(isAdded);
    }
  }

  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(
              description: const Text("Guitar Added To Wishlist Successfully"))
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
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: AppBar(
              title: const Text(
                "Guitars",
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
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FutureBuilder<GuitarResponse?>(
                      future: GuitarRepository().getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            // ProductResponse productResponse = snapshot.data!;
                            List<ShowGuitar> lstGuitarCategory =
                                snapshot.data!.data!;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                // childAspectRatio: 50 / 60,
                                crossAxisCount: 1,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 20,
                                mainAxisExtent: 220,
                              ),
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pushNamed(
                                            context, "/singleguitar",
                                            arguments:
                                                lstGuitarCategory[index].id);
                                      });
                                    },
                                    child:
                                        guitarmain(lstGuitarCategory[index]));
                              },
                            );
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
              ],
            ),
          ),
        );
      });
    });
  }

  Widget guitarmain(ShowGuitar guitar) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // height: double.infinity,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF535699),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFbdbfe9),
                // backgroundImage:
                //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                child: ClipRect(
                  child: Image.network("$baseUrl${guitar.guitar_image!}",
                      height: 120, width: 120),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                guitar.guitar_name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 20,
                  fontFamily: 'Merienda',
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Rs." + guitar.guitar_price!.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 20,
                  fontFamily: 'Merienda',
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _wishlist(guitar.id);
              });
            },
            child: const Iconify(
              Ph.heart_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
