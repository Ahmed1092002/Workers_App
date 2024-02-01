class UserModel {
  String ?id;
  String?name;
  String?address;
  String?country;
  String?email;
  String?phone;
  String ?workingField;
  String ?jobField;
  String ?fcmToken;
  String ?date;
  String? gender;
  String ?userType;
  String ?image;
  String ?info;



  UserModel({
    this.id,
    this.name,
    this.address,
    this.fcmToken,
    this.gender,
    this.info,
    this.jobField,

    this.country,
    this.email,
    this.phone,
    this.workingField,
    this.date,
    this.userType,
    this.image,


  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      fcmToken: json['fcmToken'],
      gender: json['gender'],
      info: json['info'],
      jobField: json['jobField'],

      country: json['country'],
      email: json['email'],
      phone: json['phone'],
      workingField: json['workingField'],
      date: json['date'],
      userType: json['userType'],
      image: json['image'],

    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'fcmToken': fcmToken,
        'gender': gender,
        'info': info,
        'jobField': jobField,
        'country': country,
        'email': email,
        'phone': phone,
        'workingField': workingField,
        'date': date,
        'userType': userType,
        'image': image,
      };


}