import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_category.dart';
import 'package:guitarshop/repository/category_repository.dart';
import 'package:guitarshop/response/category_response.dart';
import 'package:guitarshop/utils/url.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:wear/wear.dart';

class ShowCategoryWearos extends StatefulWidget {
  const ShowCategoryWearos({Key? key}) : super(key: key);

  @override
  State<ShowCategoryWearos> createState() => _ShowCategoryWearosState();
}

class _ShowCategoryWearosState extends State<ShowCategoryWearos> {
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
                "Categories",
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
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: FutureBuilder<CategoryResponse?>(
                            future: CategoryRepository().getCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data != null) {
                                  // ProductResponse productResponse = snapshot.data!;
                                  List<ShowCategory> categoryList =
                                      snapshot.data!.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pushNamed(
                                                context, '/profile');
                                          });
                                        },
                                        child: category(
                                          categoryList[index],
                                        ),
                                      );
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
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
              ],
            ),
          ),
        );
      });
    });
  }

  Widget category(ShowCategory category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage("$baseUrl${category.category_pic!}"),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            category.category_name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'Merienda',
            ),
          )
        ],
      ),
    );
  }
}
