import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_app/modules/detail/model/product_model.dart';

mixin DetailService {
  final userRef = FirebaseFirestore.instance.collection('user');
  final storageRef = FirebaseStorage.instance.ref().child('user_images');

  Future<String> addUserService({
    required String fullName,
    required String fatherName,
    required String cnic,
    required String phone,
  }) async {
    try {
      var docRef = await userRef.add({
        'fullName': fullName,
        'fatherName': fatherName,
        'cnic': cnic,
        'phone': phone,
        'createAt': FieldValue.serverTimestamp(),
        'updateAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      return "";
    }
  }

  Future<String> uploadImageService(String uuid, String imagePath) async {
    try {
      final file = await storageRef.child(uuid).putFile(File(imagePath));
      final imageUrl = await file.ref.getDownloadURL();
      await userRef.doc(uuid).update({'imageUrl': imageUrl});
      return imageUrl;
    } catch (e) {
      print("uploadImageService Error: $e");
      return '';
    }
  }

  Future<List<ProductModel>> getUserService() async {
    List<ProductModel> userList = [];
    QuerySnapshot snapshot = await userRef.get();
    for (var doc in snapshot.docs) {
      userList.add(
        ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
      );
    }
    return userList;
  }

  Future<bool> deleteUserService(String uuid) async {
    try {
      await userRef.doc(uuid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserService({
    required String uuid,
    required String fullName,
    required String fatherName,
    required String cnic,
    required String phone,
  }) async {
    try {
      await userRef.doc(uuid).update({
        'fullName': fullName,
        'fatherName': fatherName,
        'cnic': cnic,
        'phone': phone,
        'updateAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
