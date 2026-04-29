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
          Container(
            height: 150,
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
                  child: Form(
                    key: viewModel.formKey,
                    child: Obx(
                      () => Column(
                        children: [
                          // for Email
                          if (viewModel.loginType.value == LoginType.email) ...[
                            AppTextfield(
                              lableText: "Email",
                              controller: viewModel.email.value,
                              textFieldType: AppTextFieldType.email,
                            ),
                            SizedBox(height: 20),
                            // for password
                            AppTextfield(
                              lableText: "Password",
                              textFieldType: AppTextFieldType.password,
                              controller: viewModel.password.value,
                            ),
                            SizedBox(height: 10),
                          ] else ...[
                            AppTextfield(
                              lableText: "Phone",
                              controller: viewModel.email.value,
                            ),

                            SizedBox(height: 10),
                          ],

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
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
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
                          SizedBox(height: 10),
                          AppButton(
                            title: "Log in",
                            callback: () {
                              viewModel.toNavigate();
                            },
                          ),
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
                          Text("Or"),
                          SizedBox(height: 20),
                          Obx(
                            () => Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSocialButton(
                                        isSelected:
                                            viewModel.loginType.value ==
                                            LoginType.email,
                                        bgColor: Color(
                                          0xFF169CE8,
                                        ), // Email (blue)
                                        title: "Email",
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: _buildSocialButton(
                                        isSelected:
                                            viewModel.loginType.value ==
                                            LoginType.phone,
                                        bgColor: Color(
                                          0xFF25D366,
                                        ), // Phone (WhatsApp green style)
                                        title: "Phone",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSocialButton(
                                        isSelected:
                                            viewModel.loginType.value ==
                                            LoginType.google,
                                        bgColor: Color(
                                          0xFFDB4437,
                                        ), // Google (official red)
                                        title: "Google",
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: _buildSocialButton(
                                        isSelected:
                                            viewModel.loginType.value ==
                                            LoginType.guest,
                                        bgColor: Color(
                                          0xFF6C757D,
                                        ), // Guest (neutral grey)
                                        title: "Guest",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required Color bgColor,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        if (title == "Google") {
          viewModel.loginType.value = LoginType.google;
        } else if (title == "Phone") {
          viewModel.loginType.value = LoginType.phone;
        } else if (title == "Email") {
          viewModel.loginType.value = LoginType.email;
        } else if (title == "Guest") {
          viewModel.loginType.value = LoginType.guest;
        }
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: bgColor.withValues(alpha: isSelected ? 1.0 : 0.35),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? bgColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
