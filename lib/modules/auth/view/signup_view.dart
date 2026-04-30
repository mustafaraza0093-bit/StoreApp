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
                  child: Form(
                    key: viewModel.formKey,
                    child: Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  isSelected:
                                      viewModel.signupType.value ==
                                      SignupType.email,
                                  bgColor: Color(0xFF169CE8), // Email blue
                                  title: "Email",
                                  onTap: () {
                                    viewModel.signupType.value =
                                        SignupType.email;
                                  },
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: _buildSocialButton(
                                  isSelected:
                                      viewModel.signupType.value ==
                                      SignupType.phone,
                                  bgColor: Color(0xFF25D366), // Phone green
                                  title: "Phone",
                                  onTap: () {
                                    viewModel.signupType.value =
                                        SignupType.phone;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          AppTextfield(
                            lableText: "Name",
                            hintText: "jhon",
                            controller: viewModel.name.value,
                          ),
                          SizedBox(height: 20),
                          if (viewModel.signupType.value == SignupType.email)
                            AppTextfield(
                              lableText: "Email",
                              hintText: "jhon@example.com",
                              controller: viewModel.email.value,
                              textFieldType: AppTextFieldType.email,
                            )
                          else ...[
                            AppTextfield(
                              lableText: "Phone",
                              hintText: "+92 312 3456789",
                              controller: viewModel.phone.value,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            if (viewModel.isOtpSent.value) ...[
                              SizedBox(height: 20),
                              AppTextfield(
                                lableText: "OTP Code",
                                hintText: "123456",
                                controller: viewModel.otpController.value,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the OTP code';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ],

                          if (viewModel.signupType.value ==
                              SignupType.email) ...[
                            SizedBox(height: 20),
                            // for password
                            AppTextfield(
                              lableText: "Password",
                              hintText: "**********",
                              textFieldType: AppTextFieldType.password,
                              controller: viewModel.password.value,
                            ),
                            SizedBox(height: 20),
                            // for retype password
                            AppTextfield(
                              lableText: "Retype Password",
                              hintText: "**********",
                              textFieldType: AppTextFieldType.password,
                              controller: viewModel.retypePassword.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please retype your password';
                                }
                                if (value != viewModel.password.value.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                          SizedBox(height: 30),
                          AppButton(
                            title: "Sign up",
                            callback: () {
                              viewModel.performSignup();
                            },
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
