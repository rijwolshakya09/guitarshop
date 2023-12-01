class Customer {
  String? full_name;
  String? contact_no;
  String? username;
  String? email;
  String? password;

  Customer({
    this.full_name,
    this.contact_no,
    this.username,
    this.email,
    this.password,
  });

  //Converting Json Data to Dart Object
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        full_name: json["full_name"],
        contact_no: json["contact_no"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  //Converting Dart Object to Json Data
  Map<String, dynamic> toJson() => {
        "full_name": full_name,
        "contact_no": contact_no,
        "username": username,
        "email": email,
        "password": password,
      };
}
