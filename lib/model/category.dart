class Category {
  String? image;
  String? title;

  Category({this.image, this.title});
}

List<Category> lstCategory = [
  Category(image: "assets/images/categories/acoustic.png", title: "Acoustic"),
  Category(
      image: "assets/images/categories/semiacoustic.png",
      title: "SemiAcoustic"),
  Category(image: "assets/images/categories/base.png", title: "Bass"),
  Category(image: "assets/images/categories/electric.png", title: "Electric"),
  Category(image: "assets/images/categories/ukelele.png", title: "Ukulele"),
];
