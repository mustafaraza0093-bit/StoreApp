import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_prefs.dart';
import 'package:store_app/modules/auth/view/login_view.dart';
import 'package:store_app/modules/detail/view/product_view.dart';
import 'package:store_app/modules/onboarding/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (AppPrefs.isFirstTime()) {
        Get.offAll(() => OnboardingView());
      } else if (AppPrefs.isLoggedIn()) {
        Get.offAll(() => Product());
      } else {
        Get.offAll(() => LoginView());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Center(child: Image.asset("assets/appLogo.jpeg", width: 200)),
      ),
    );
  }
}
