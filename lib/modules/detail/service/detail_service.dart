import 'package:cloud_firestore/cloud_firestore.dart';

mixin DetailService {
  final userRef = FirebaseFirestore.instance.collection('user');

  Future<void> addUserService({
    required String fullName,
    required String fatherName,
    required String cnic,
    required String phone,
  }) async {
    userRef.add({
      'fullName': fullName,
      'fatherName': fatherName,
      'cnic': cnic,
      'phone': phone,
      'createAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }
}
