import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/common/app_snakbar.dart';
import 'package:store_app/common/loader.dart';
import 'package:store_app/modules/detail/model/product_model.dart';
import 'package:store_app/modules/detail/service/detail_service.dart';

class ProductViewmodel extends GetxController with DetailService {
  RxList<ProductModel> productList = <ProductModel>[].obs;

  // Variables for Add User
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  Rx<bool> isLoading = false.obs;

  Rx<File> userImageFile = File("").obs;
  Rx<String> imageURL = "".obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> userFatherName = TextEditingController().obs;
  Rx<TextEditingController> userCNIC = TextEditingController().obs;
  Rx<TextEditingController> userPhone = TextEditingController().obs;

  void addUser() async {
    if (userImageFile.value.path.isEmpty) {
      AppSnakbar.error("Validation Error", "Please select your image");
      return;
    }
    // //-------------------------- userName validation --------------------------
    // if (userName.value.text.isEmpty) {
    //   AppSnakbar.error("Validation Error", "Please Enter your name");
    //   return;
    // }
    // //-------------------------- userFatherName validation--------------------
    // if (userFatherName.value.text.isEmpty) {
    //   AppSnakbar.error("Validation Error", "Please Enter your father name");
    //   return;
    // }
    // //-------------------------- userCNIC validation --------------------------
    // if (userCNIC.value.text.isEmpty) {
    //   AppSnakbar.error("Validation Error", "Please Enter your CNIC");
    //   return;
    // }

    // if (userCNIC.value.text.length != 13) {
    //   AppSnakbar.error(
    //     "Validation Error",
    //     "Please enter your valid CNIC Number",
    //   );
    //   return;
    // }
    // //-------------------------- userPhoneNumber validation ------------------
    // if (userPhone.value.text.isEmpty) {
    //   AppSnakbar.error("Validation Error", "Please Enter your Phone Number");
    //   return;
    // }

    // if (!userPhone.value.text.contains("03")) {
    //   AppSnakbar.error(
    //     "Validation Error",
    //     "Please enter your valid Phone Number",
    //   );
    //   return;
    // }

    // if (userPhone.value.text.length != 11) {
    //   AppSnakbar.error(
    //     "Validation Error",
    //     "Please enter your valid Phone Number",
    //   );
    //   return;
    // }

    // // -------------------------- Success Area --------------------------

    try {
      AppLoader.show(Get.context!);

      String uuID = await addUserService(
        fullName: userName.value.text,
        fatherName: userFatherName.value.text,
        cnic: userCNIC.value.text,
        phone: userPhone.value.text,
      );

      if (uuID.isNotEmpty) {
        await uploadImageService(uuID, userImageFile.value.path);
        AppLoader.hide();
        Get.back(result: true);
        AppSnakbar.success("Success", "User Added Successfully");
      } else {
        AppLoader.hide();
        AppSnakbar.error("Error", "Failed to add user");
      }
    } catch (e) {
      AppLoader.hide();
      print("Error $e");
    }
  }

  void removeAllData() {
    userImageFile.value = File("");
    imageURL.value = "";
    userName.value.clear();
    userFatherName.value.clear();
    userCNIC.value.clear();
    userPhone.value.clear();
  }

  // Delete Product
  void deleteProduct(ProductModel data) async {
    try {
      AppLoader.show(Get.context!);
      bool isDeleted = await deleteUserService(data.uuid);
      AppLoader.hide();
      if (isDeleted) {
        productList.remove(data);
        Get.back();
        AppSnakbar.success("Success", "User Deleted Successfully");
      }
    } catch (e) {
      AppLoader.hide();
      print("Error $e");
    }
  }

  Future<void> updateUser(ProductModel user) async {
    try {
      AppLoader.show(Get.context!);
      bool isUpdated = await updateUserService(
        uuid: user.uuid,
        fullName: userName.value.text,
        fatherName: userFatherName.value.text,
        cnic: userCNIC.value.text,
        phone: userPhone.value.text,
      );
      AppLoader.hide();
      if (isUpdated) {
        if (userImageFile.value.path.isNotEmpty) {
          await uploadImageService(user.uuid, userImageFile.value.path);
        }
        Get.back(result: true);
        AppSnakbar.success("Success", "User Updated Successfully");
      }
    } catch (e) {
      AppLoader.hide();
      print("Error $e");
    }
  }

  void cameraAndPhotoMethod(bool isCamera) async {
    Get.back();
    var fileImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (fileImage != null) {
      userImageFile.value = File(fileImage.path);
    }
  }

  Future<void> getUser() async {
    try {
      isLoading.value = true;
      productList.value = await getUserService();
      productList.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error $e");
    }
  }
}
