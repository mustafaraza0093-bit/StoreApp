import 'package:flutter/material.dart';

enum AppTextFieldType { normal, email, password }

class AppTextfield extends StatefulWidget {
  final String? hintText;
  final String? lableText;
  final AppTextFieldType textFieldType;
  final TextEditingController? controller;

  const AppTextfield({
    super.key,
    this.hintText,
    this.lableText,
    this.textFieldType = AppTextFieldType.normal,
    this.controller,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  // local Varables.
  bool isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.lableText ?? "", style: TextStyle(fontSize: 14)),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.textFieldType == AppTextFieldType.password
              ? !isVisiblePassword
              : false,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Enter your ${widget.lableText ?? ""}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Color(0xFFEBF5FF),
            filled: true,

            suffixIcon: widget.textFieldType == AppTextFieldType.password
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisiblePassword = !isVisiblePassword;
                      });
                    },
                    icon: Icon(
                      isVisiblePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
