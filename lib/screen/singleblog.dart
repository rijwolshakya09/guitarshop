import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_blog.dart';
import 'package:guitarshop/repository/blog_repository.dart';
import 'package:guitarshop/response/blog_single_response.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../utils/url.dart';

class SingleBlogScreen extends StatefulWidget {
  const SingleBlogScreen({Key? key}) : super(key: key);

  @override
  State<SingleBlogScreen> createState() => _SingleBlogScreenState();
}

class _SingleBlogScreenState extends State<SingleBlogScreen> {
  @override
  Widget build(BuildContext context) {
    final blogId = ModalRoute.of(context)!.settings.arguments as String?;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            title: const Text(
              "Blogs",
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
                  height: MediaQuery.of(context).size.height * 1.2,
                  width: double.infinity,
                  child: FutureBuilder<BlogSingleResponse?>(
                    future: BlogRepository().getSingleBlogs(blogId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // debugPrint(snapshot.data.toString());
                        if (snapshot.data != null) {
                          // ProductResponse productResponse = snapshot.data!;
                          ShowBlog lstBlog = snapshot.data!.data!;
                          return blogmain(lstBlog);
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
  }

  //===================Widget For Guitars Section=================================
  Widget blogmain(ShowBlog blog) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 200,
              backgroundColor: const Color(0xFFbdbfe9),
              // backgroundImage:
              //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
              child: ClipRect(
                child: Image.network(
                  "$baseUrl${blog.blog_image!}",
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
                    blog.blog_title!,
                    style: const TextStyle(
                      color: Color(0xFF535699),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  // const SizedBox(height: 4),
                  Text(
                    blog.blog_rich_description!,
                    style: const TextStyle(
                      color: Color(0xFF535699),
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Merienda',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
