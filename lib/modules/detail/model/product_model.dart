import 'dart:io';

class ProductModel {
  String userName;
  String fatherName;
  String cnic;
  String phoneNumber;
  File userImage;

  ProductModel({
    required this.userName,
    required this.fatherName,
    required this.cnic,
    required this.phoneNumber,
    required this.userImage,
  });
}
