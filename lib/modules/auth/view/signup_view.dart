import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_TextField.dart';
import 'package:store_app/common/app_button.dart';
import 'package:store_app/modules/auth/viewmodel/signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  SignupViewmodel viewModel = Get.put(SignupViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121223),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },

                      child: Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.only(left: 20, top: 45),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Welcome! Please sign up to create your account.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextfield(lableText: "Name", hintText: "jhon"),
                      SizedBox(height: 20),
                      AppTextfield(
                        lableText: "Email",
                        hintText: "jhon@example.com",
                      ),
                      SizedBox(height: 20),
                      // for password
                      AppTextfield(
                        lableText: "Password",
                        hintText: "**********",
                        textFieldType: AppTextFieldType.password,
                      ),
                      SizedBox(height: 20),
                      // for password
                      AppTextfield(
                        lableText: "Retype Password",
                        hintText: "**********",
                        textFieldType: AppTextFieldType.password,
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        title: "Sign up",
                        callback: () {
                          print("this is signup");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({required Color color}) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
