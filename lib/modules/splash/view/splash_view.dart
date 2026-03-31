import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/modules/onboarding/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      print("hello print");
      Get.to(OnboardingView());
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
