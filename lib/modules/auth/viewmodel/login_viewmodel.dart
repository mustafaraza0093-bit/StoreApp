import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/loader.dart';
import 'package:store_app/modules/auth/service/auth_service.dart';
import 'package:store_app/modules/detail/view/product_view.dart';

enum LoginType { email, phone, google, guest }

class LoginViewmodel extends GetxController with AuthService {
  RxBool isRememberMe = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<LoginType> loginType = LoginType.email.obs;
  // Controllers
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  // State Management

  // Phone Auth Specific
  RxBool isOtpSent = false.obs;
  RxString verificationId = ''.obs;

  Future<void> performLogin() async {
    if ((loginType.value == LoginType.email ||
            loginType.value == LoginType.phone) &&
        !formKey.currentState!.validate()) {
      return;
    }

    AppLoader.show(Get.context!);

    try {
      switch (loginType.value) {
        case LoginType.email:
          await signInWithEmail(
            email.value.text.trim(),
            password.value.text.trim(),
          );
          _navigateForward();
          break;

        case LoginType.phone:
          if (isOtpSent.value) {
            // Step 2: Verify the code
            await verifyPhoneOtp(
              verificationId.value,
              otpController.value.text.trim(),
            );
            _navigateForward();
          } else {
            // Step 1: Send the code
            await sendPhoneOtp(email.value.text.trim(), (vid) {
              verificationId.value = vid;
              isOtpSent.value = true;
              AppLoader.hide();
              Get.snackbar("OTP Sent", "Please check your messages");
            });
          }
          break;

        case LoginType.google:
          final user = await signInWithGoogle();
          if (user != null) _navigateForward();
          break;

        case LoginType.guest:
          await signInAsGuest();
          _navigateForward();
          break;
      }
    } catch (e) {
      Get.snackbar(
        "Login Error",
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      log("Login Error (${loginType.value}): $e");
    } finally {
      AppLoader.hide();
    }
  }

  void _navigateForward() {
    Get.offAll(() => Product());
  }
}
