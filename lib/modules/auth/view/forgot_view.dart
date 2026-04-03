import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_TextField.dart';
import 'package:store_app/common/app_button.dart';
import 'package:store_app/modules/auth/view/verfication_view.dart';
import 'package:store_app/modules/auth/viewmodel/forgot_viewmodel.dart';

class ForgotView extends StatelessWidget {
  ForgotView({super.key});

  ForgotViewmodel viewModel = Get.put(ForgotViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121223),
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Enter your email address and we'll send you a link to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextfield(
                      controller: viewModel.email.value,
                      lableText: "Email",
                      hintText: "jhon@example.com",
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      title: "Forgot Password",
                      callback: () {
                        viewModel.toNavigate();
                       
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
