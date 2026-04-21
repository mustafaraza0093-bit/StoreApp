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
      _vm.userImageFile.value = widget.userData!.userImage;
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
            GestureDetector(
              onTap: () {
                showImagePickerSheet(context);
              },
              child: Obx(
                () => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withValues(alpha: 0.15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _vm.userImageFile.value.path.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _vm.userImageFile.value,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.person, color: Colors.grey, size: 50),
                ),
              ),
            ),
            SizedBox(height: 50),
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

  void showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 5),
                Container(
                  height: 3,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _vm.cameraAndPhotoMethod(true);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [Text("Camera"), Spacer(), Icon(Icons.camera)],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _vm.cameraAndPhotoMethod(false);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [Text("Gallery"), Spacer(), Icon(Icons.photo)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
