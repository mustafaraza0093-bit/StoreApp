import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_TextField.dart';
import 'package:store_app/common/app_button.dart';
import 'package:store_app/modules/detail/model/product_model.dart';
import 'package:store_app/modules/detail/viewmodel/product_viewmodel.dart';

class AddUserView extends StatefulWidget {
  final ProductModel? userData;
  const AddUserView({super.key, this.userData});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final ProductViewmodel _vm = Get.put(ProductViewmodel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm.removeAllData();
    if (widget.userData != null) {
      _vm.userImage.value.text = widget.userData!.userImage;
      _vm.userName.value.text = widget.userData!.userName;
      _vm.userFatherName.value.text = widget.userData!.fatherName;
      _vm.userCNIC.value.text = widget.userData!.cnic.replaceAll("-", "");
      _vm.userPhone.value.text = widget.userData!.phoneNumber.replaceAll(
        "-",
        "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add User",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _vm.addUser();
            },
            child: Text(widget.userData != null ? "Update" : "Done"),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppTextfield(
              controller: _vm.userImage.value,
              lableText: "User Image",
              hintText: "Enter your image url",
            ),
            SizedBox(height: 16),
            AppTextfield(
              controller: _vm.userName.value,
              lableText: "User Name",
              hintText: "Enter your username",
            ),
            SizedBox(height: 16),
            AppTextfield(
              controller: _vm.userFatherName.value,
              lableText: "Father Name",
              hintText: "Enter your fathername",
            ),
            SizedBox(height: 16),
            AppTextfield(
              controller: _vm.userCNIC.value,
              lableText: "User CNIC",
              hintText: "Enter your cnic",
              maxLength: 13,
            ),
            SizedBox(height: 16),
            AppTextfield(
              controller: _vm.userPhone.value,
              lableText: "Phone Number",
              hintText: "Enter your phone number",
              maxLength: 11,
            ),
            SizedBox(height: 30),
            AppButton(
              callback: () {
                widget.userData != null
                    ? _vm.updateUser(widget.userData!)
                    : _vm.addUser();
              },
              title: widget.userData != null ? "Update" : "Done",
            ),
          ],
        ),
      ),
    );
  }
}
