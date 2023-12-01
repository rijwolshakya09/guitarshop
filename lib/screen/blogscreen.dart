import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_blog.dart';
import 'package:guitarshop/repository/blog_repository.dart';
import 'package:guitarshop/response/blog_response.dart';

import '../utils/url.dart';

class BlogScreenState extends StatefulWidget {
  const BlogScreenState({Key? key}) : super(key: key);

  @override
  State<BlogScreenState> createState() => _BlogScreenStateState();
}

class _BlogScreenStateState extends State<BlogScreenState> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
            children: [
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                child: FutureBuilder<BlogResponse?>(
                  future: BlogRepository().getBlog(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        // ProductResponse productResponse = snapshot.data!;
                        List<ShowBlog> lstBlog = snapshot.data!.data!;
                        return ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.pushNamed(
                                          context, "/singleblog",
                                          arguments: lstBlog[index].id);
                                    });
                                  },
                                  child: blogs(lstBlog[index]));
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
      )),
    );
  }

  Widget blogs(ShowBlog blogs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: const Color(0xFF535699),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 360,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 136,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage("$baseUrl${blogs.blog_image!}"),
                          fit: BoxFit.cover,
                          // opacity: 5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          blogs.blog_title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Merienda',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   blogs.blog_title!,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //     fontFamily: 'Merienda',
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      blogs.blog_description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Merienda',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 128,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, '/singleblog',
                                arguments: blogs.id);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFbdbfe9))),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: const [
                              Icon(Icons.touch_app),
                              Text('See More')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
