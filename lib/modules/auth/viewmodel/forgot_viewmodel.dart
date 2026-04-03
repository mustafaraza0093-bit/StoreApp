import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_snakbar.dart';
import 'package:store_app/modules/auth/view/verfication_view.dart';

class ForgotViewmodel extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;

  void toNavigate() {
    if (email.value.text.isEmpty) {
      AppSnakbar.error("Error", "Please enter your email address");
      return;
    }

    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email.value.text);

    if (!emailValid) {
      AppSnakbar.error("Error", "Please enter a valid email address");
      return;
    }

    print("this is forgot password");
    Get.to(VerficationView());
  }
}
