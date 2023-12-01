import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/blogs.dart';
import 'package:guitarshop/model/show_category.dart';
import 'package:guitarshop/repository/category_repository.dart';
import 'package:guitarshop/response/category_response.dart';
import 'package:guitarshop/model/guitar_model.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/url.dart';
import '../components/search_bar.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    'https://images.unsplash.com/photo-1471478331149-c72f17e33c73?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169',
    'https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
    'https://images.unsplash.com/photo-1559466170-72a11c6586c3?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032',
    'https://images.unsplash.com/photo-1462965326201-d02e4f455804?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
    'https://images.unsplash.com/photo-1464375117522-1311d6a5b81f?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170'
  ];

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    );
    return SafeArea(
      child: Scaffold(
//=====================Main Body Section========================================
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              children: [
//========================Search Bar Container==================================
                const SearchBar(outlineInputBorder: outlineInputBorder),

//==============================Carousel Section================================
                const SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    buildImageSlider(),
                    const SizedBox(
                      height: 12,
                    ),
                    buildIndicator(),
                  ],
                ),
                const SizedBox(height: 12),

//==============================Category Section================================
                const Text(
                  "Categories",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                // Row(
                //   children: [
                //     Expanded(
                //       child: SizedBox(
                //         height: 100,
                //         child: ListView.builder(
                //           shrinkWrap: true,
                //           scrollDirection: Axis.horizontal,
                //           itemCount: lstCategory.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             return GestureDetector(
                //               onTap: () {
                //                 setState(() {
                //                   Navigator.pushNamed(context, '/profile');
                //                 });
                //               },
                //               child: category(
                //                 lstCategory[index],
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
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

//==============================Guitars Section================================
                const Text(
                  "Guitars",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // childAspectRatio: 50 / 60,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 220,
                    ),
                    itemCount: lstGuitar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return guitarmain(lstGuitar[index]);
                    },
                  ),
                ),

//==============================Blog Section====================================
                const Text(
                  "Blogs",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: lstBlogs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.pushNamed(context, '/layout');
                                });
                              },
                              child: blogs(
                                lstBlogs[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

//===================Widget For Image Carousel Section==========================
  Widget buildImageSlider() => CarouselSlider.builder(
        carouselController: controller,
        itemCount: urlImages.length,
        options: CarouselOptions(
            height: 160,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 6),
            onPageChanged: (index, reason) {
              setState(
                () => activeIndex = index,
              );
            }),
        itemBuilder: (context, index, realIndex) {
          final urlImage = urlImages[index];

          return buildImage(urlImage, index);
        },
      );
//===================Widget For Image Section For Carousel======================
  Widget buildImage(String urlImage, int index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 8),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/guitars/guitar$index.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );

//===================Widget for Image Carousel Dots=============================
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const ExpandingDotsEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xFF535699),
        ),
      );

//===================Widget For Category Section================================
  // Widget category(Category category) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
  //     child: Column(
  //       children: [
  //         CircleAvatar(
  //           radius: 36,
  //           backgroundImage: AssetImage(category.image!),
  //         ),
  //         const SizedBox(
  //           height: 2,
  //         ),
  //         Text(
  //           category.title!,
  //           style: const TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 12,
  //             fontFamily: 'Merienda',
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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

//===================Widget For Guitars Section=================================
  Widget guitarmain(Guitar guitar) {
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
                backgroundImage: AssetImage(guitar.guitarImage!),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                guitar.guitarName!,
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
                guitar.guitarPrice!,
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
        const Positioned(
          child: Iconify(
            Ph.heart_fill,
            color: Colors.white,
            size: 24,
          ),
          top: 8,
          right: 8,
        ),
      ],
    );
  }

  //===================Widget For Blogs Section=================================
  Widget blogs(Blogs blogs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(
        children: [
          Container(
            height: 136,
            width: 260,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(blogs.blogImage!),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                blogs.blogName!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Merienda',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
