class Guitar {
  String? guitarImage;
  String? guitarName;
  String? guitarPrice;

  Guitar({this.guitarImage, this.guitarName, this.guitarPrice});
}

List<Guitar> lstGuitar = [
  Guitar(
      guitarImage: 'assets/images/categoriespng/Acoustic.png',
      guitarName: "Acoustic",
      guitarPrice: "Rs. 7500"),
  Guitar(
      guitarImage: 'assets/images/categoriespng/Ukelele.png',
      guitarName: "Ukulele",
      guitarPrice: "Rs. 5000"),
  Guitar(
      guitarImage: 'assets/images/categoriespng/Base.png',
      guitarName: "Bass",
      guitarPrice: "Rs. 12000"),
  Guitar(
      guitarImage: 'assets/images/categoriespng/Electric.png',
      guitarName: "Electric",
      guitarPrice: "Rs. 15000"),
];
