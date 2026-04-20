import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:store_app/common/app_snakbar.dart';
import 'package:store_app/modules/detail/model/product_model.dart';

class ProductViewmodel extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[
    ProductModel(
      userImage:
          "https://i.pinimg.com/736x/05/64/a4/0564a4e380a71e20d32f4e73336654c2.jpg",
      userName: "Ali Khan",
      fatherName: "Ahmed Khan",
      cnic: "35202-1234567-2",
      phoneNumber: "0301-2345678",
    ),
  ].obs;

  // Text Editing Controller
  Rx<TextEditingController> userImage = TextEditingController().obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> userFatherName = TextEditingController().obs;
  Rx<TextEditingController> userCNIC = TextEditingController().obs;
  Rx<TextEditingController> userPhone = TextEditingController().obs;

  void addUser() {
    //-------------------------- Image validation --------------------------
    if (userImage.value.text.isEmpty) {
      AppSnakbar.error("Validation Error", "Please add User Image");
      return;
    }
    if (!userImage.value.text.contains("http")) {
      AppSnakbar.error("Validation Error", "Please add valid image url");
      return;
    }
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
    var myData = ProductModel(
      userName: userName.value.text,
      fatherName: userFatherName.value.text,
      cnic: userCNIC.value.text,
      phoneNumber: userPhone.value.text,
      userImage: userImage.value.text,
    );
    productList.insert(0, myData);
    Get.back();
    AppSnakbar.success("Success", "Every Validation Pass");
  }

  void removeAllData() {
    userImage.value.clear();
    userName.value.clear();
    userFatherName.value.clear();
    userCNIC.value.clear();
    userPhone.value.clear();
  }

  // Delete Product
  void deleteProduct(ProductModel data) {
    productList.remove(data);
    AppSnakbar.success("Success", "User Deleted Successfully");
  }

  void updateUser(ProductModel productModel) {
    var index = productList.indexOf(productModel);
    productList[index].userName = userName.value.text;
    productList[index].fatherName = userFatherName.value.text;
    productList[index].cnic = userCNIC.value.text;
    productList[index].phoneNumber = userPhone.value.text;
    productList[index].userImage = userImage.value.text;

    // To update the UI
    productList[index] = productList[index];

    Get.back();
    AppSnakbar.success("Success", "User Updated Successfully");
  }
}
