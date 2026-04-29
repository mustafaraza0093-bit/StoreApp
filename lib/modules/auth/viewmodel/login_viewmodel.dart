import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/modules/detail/view/product_view.dart';

enum LoginType { email, phone, google, guest }

class LoginViewmodel extends GetxController {
  RxBool isRememberMe = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<LoginType> loginType = LoginType.email.obs;

  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  void toNavigate() {
    if (formKey.currentState!.validate()) {
      Get.to(Product());
    }
  }
}
