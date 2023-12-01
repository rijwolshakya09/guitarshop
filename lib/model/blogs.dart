class Blogs {
  String? blogImage;
  String? blogName;

  Blogs({this.blogImage, this.blogName});
}

List<Blogs> lstBlogs = [
  Blogs(
      blogImage:
          'https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
      blogName: "New Electric Guitars"),
  Blogs(
      blogImage:
          'https://images.unsplash.com/photo-1605020420620-20c943cc4669?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      blogName: "New Acoustic Guitars"),
];
