class UserModel {
  String email;

  int age;

  String gender;

  String gstNumber;

  String phone;

  String image;

  UserModel({
    required this.email,
    required this.image,
    required this.age,
    required this.phone,
    required this.gender,
    required this.gstNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'age': age,
      'phone': phone,
      'gender': gender,
      'GST': gstNumber,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      image: json['image'],
      age: int.parse(json['age'].toString()),
      phone: json['phone'],
      gender: json['gender'],
      gstNumber: json['GST'],
    );
  }
}
