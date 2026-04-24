import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/common/app_snakbar.dart';
import 'package:store_app/modules/detail/model/product_model.dart';
import 'package:store_app/modules/detail/service/detail_service.dart';

class ProductViewmodel extends GetxController with DetailService {
  RxList<ProductModel> productList = <ProductModel>[].obs;

  // Text Editing Controller
  Rx<File> userImageFile = File("").obs;
  ImagePicker _imagePicker = ImagePicker();
  // Rx<TextEditingController> userImage = TextEditingController().obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> userFatherName = TextEditingController().obs;
  Rx<TextEditingController> userCNIC = TextEditingController().obs;
  Rx<TextEditingController> userPhone = TextEditingController().obs;

  void addUser() async {
    // //-------------------------- Image validation --------------------------
    // if (userImageFile.value.path.isEmpty) {
    //   AppSnakbar.error("Validation Error", "Please select User Image");
    //   return;
    // }

    //-------------------------- userName validation --------------------------
    if (userName.value.text.isEmpty) {
      AppSnakbar.error("Validation Error", "Please Enter your name");
      return;
    }
    //-------------------------- userFatherName validation--------------------
    if (userFatherName.value.text.isEmpty) {
      AppSnakbar.error("Validation Error", "Please Enter your father name");
      return;
    }
    //-------------------------- userCNIC validation --------------------------
    if (userCNIC.value.text.isEmpty) {
      AppSnakbar.error("Validation Error", "Please Enter your CNIC");
      return;
    }

    if (userCNIC.value.text.length != 13) {
      AppSnakbar.error(
        "Validation Error",
        "Please enter your valid CNIC Number",
      );
      return;
    }
    //-------------------------- userPhoneNumber validation ------------------
    if (userPhone.value.text.isEmpty) {
      AppSnakbar.error("Validation Error", "Please Enter your Phone Number");
      return;
    }

    if (!userPhone.value.text.contains("03")) {
      AppSnakbar.error(
        "Validation Error",
        "Please enter your valid Phone Number",
      );
      return;
    }

    if (userPhone.value.text.length != 11) {
      AppSnakbar.error(
        "Validation Error",
        "Please enter your valid Phone Number",
      );
      return;
    }

    // -------------------------- Success Area --------------------------
    // var myData = ProductModel(
    //   userName: userName.value.text,
    //   fatherName: userFatherName.value.text,
    //   cnic: userCNIC.value.text,
    //   phoneNumber: userPhone.value.text,
    //   userImage: userImageFile.value,
    // );
    await addUserService(
      fullName: userName.value.text,
      fatherName: userFatherName.value.text,
      cnic: userCNIC.value.text,
      phone: userPhone.value.text,
    );
    // productList.insert(0, myData);
    Get.back();
    AppSnakbar.success("Success", "Every Validation Pass");
  }

  void removeAllData() {
    userImageFile.value = File("");
    userName.value.clear();
    userFatherName.value.clear();
    userCNIC.value.clear();
    userPhone.value.clear();
  }

  // Delete Product
  void deleteProduct(ProductModel data) {
    productList.remove(data);
    Get.back();
    AppSnakbar.success("Success", "User Deleted Successfully");
  }

  void updateUser(ProductModel productModel) {
    var index = productList.indexOf(productModel);
    productList[index].userName = userName.value.text;
    productList[index].fatherName = userFatherName.value.text;
    productList[index].cnic = userCNIC.value.text;
    productList[index].phoneNumber = userPhone.value.text;
    productList[index].userImage = userImageFile.value;

    // To update the UI
    productList[index] = productList[index];

    Get.back();
    AppSnakbar.success("Success", "User Updated Successfully");
  }

  void cameraAndPhotoMethod(bool isCamera) async {
    Get.back();
    var fileImage = await _imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (fileImage != null) {
      userImageFile.value = File(fileImage.path);
    }
  }
}
