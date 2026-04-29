import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/modules/detail/view/product_view.dart';

class LoginViewmodel extends GetxController {
  RxBool isRememberMe = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  void toNavigate() {
    if (formKey.currentState!.validate()) {
      Get.to(Product());
    }
    // // // For Email Validation
    // // if (email.value.text.isEmpty) {
    // //   AppSnakbar.error("Error", "Please enter your email address");
    // //   return;
    // // }

    // // final bool emailValid = RegExp(
    // //   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    // // ).hasMatch(email.value.text);

    // // if (!emailValid) {
    // //   AppSnakbar.error("Error", "Please enter a valid email address");
    // //   return;
    // // }

    // // // For Password Validation
    // // if (password.value.text.isEmpty) {
    // //   AppSnakbar.error("Error", "Please enter your password");
    // //   return;
    // // }
    // // final passwordRegex = RegExp(
    // //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    // // ).hasMatch(password.value.text);

    // // if (!passwordRegex) {
    // //   AppSnakbar.error(
    // //     "Error",
    // //     "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character",
    // //   );
    // //   return;
    // // }

    // print("this is forgot password");
    // Get.to(Product());
  }
}
