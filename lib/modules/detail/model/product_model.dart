import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uuid;
  String userName;
  String fatherName;
  String cnic;
  String phoneNumber;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  ProductModel({
    required this.uuid,
    required this.userName,
    required this.fatherName,
    required this.cnic,
    required this.phoneNumber,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String uuid) {
    return ProductModel(
      uuid: uuid,
      userName: json['fullName'] ?? "",
      fatherName: json['fatherName'] ?? "",
      cnic: json['cnic'] ?? "",
      phoneNumber: json['phone'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      createdAt: json['createAt'] != null
          ? (json['createAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: json['updateAt'] != null
          ? (json['updateAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  factory ProductModel.fromEmpty() {
    return ProductModel(
      uuid: "",
      userName: "",
      fatherName: "",
      cnic: "",
      phoneNumber: "",
      imageUrl: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
