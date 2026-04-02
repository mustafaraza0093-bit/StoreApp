import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_TextField.dart';
import 'package:store_app/common/app_button.dart';
import 'package:store_app/modules/auth/view/forgot_view.dart';
import 'package:store_app/modules/auth/view/signup_view.dart';
import 'package:store_app/modules/auth/viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  LoginViewmodel viewModel = Get.put(LoginViewmodel());

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome back! Please login to your account.",
                    style: TextStyle(color: Colors.white),
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
                      // for Email
                      AppTextfield(lableText: "Email"),
                      SizedBox(height: 20),
                      // for password
                      AppTextfield(
                        lableText: "Password",
                        textFieldType: AppTextFieldType.password,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.isRememberMe.value =
                                  !viewModel.isRememberMe.value;
                            },
                            child: Obx(
                              () => Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: viewModel.isRememberMe.value
                                      ? const Color(0xFFFF7622)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: viewModel.isRememberMe.value
                                        ? const Color(0xFFFF7622)
                                        : Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                child: viewModel.isRememberMe.value
                                    ? Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Remember me",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Get.to(ForgotView());
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: const Color(0xFFFF7622),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        title: "Log in",
                        callback: () {
                          print("this is login");
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Get.to(SignupView());
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: const Color(0xFFFF7622),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Or"),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialButton(color: Color(0xFF395998)),
                          _buildSocialButton(color: Color(0xFF169CE8)),
                          _buildSocialButton(color: Color(0xFF1B1F2F)),
                        ],
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
