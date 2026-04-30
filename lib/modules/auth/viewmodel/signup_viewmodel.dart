import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/loader.dart';
import 'package:store_app/modules/auth/service/auth_service.dart';

import 'package:store_app/modules/detail/view/product_view.dart';

enum SignupType { email, phone }

class SignupViewmodel extends GetxController with AuthService {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<SignupType> signupType = SignupType.email.obs;

  // Controllers
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> retypePassword = TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController(text: "").obs;

  // State Management
  // RxBool isLoading = false.obs;

  // Phone Auth Specific
  RxBool isOtpSent = false.obs;
  RxString verificationId = ''.obs;

  Future<void> performSignup() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    AppLoader.show(Get.context!);

    try {
      if (signupType.value == SignupType.email) {
        await signUpWithEmail(
          email.value.text.trim(),
          password.value.text.trim(),
        );
        _navigateForward();
      } else {
        // Phone Signup
        if (isOtpSent.value) {
          // Step 2: Verify OTP
          await verifyPhoneOtp(
            verificationId.value,
            otpController.value.text.trim(),
          );
          _navigateForward();
        } else {
          // Step 1: Send OTP
          await sendPhoneOtp(phone.value.text.trim(), (vid) {
            verificationId.value = vid;
            isOtpSent.value = true;
            AppLoader.hide();
            Get.snackbar(
              "OTP Sent",
              "Please check your messages",
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          });
        }
      }
    } catch (e) {
      Get.snackbar(
        "Signup Error",
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      AppLoader.hide();
    }
  }

  void _navigateForward() {
    Get.offAll(() => Product());
  }
}
