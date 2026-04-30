import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/common/app_button.dart';
import 'package:store_app/modules/detail/model/product_model.dart';
import 'package:store_app/modules/detail/view/add_user_view.dart';
import 'package:store_app/modules/detail/viewmodel/product_viewmodel.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final ProductViewmodel _vm = Get.put(ProductViewmodel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Student Info",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(AddUserView())!.then((val) {
                if (val) {
                  print("object");
                  _vm.getUser();
                }
              });
            },
            child: Text("Add User"),
          ),
        ],

        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => _vm.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : _vm.productList.isEmpty
                  ? Center(child: Text("User Data not found"))
                  : RefreshIndicator(
                      onRefresh: () async {
                        _vm.getUser();
                      },
                      child: ListView.builder(
                        itemCount: _vm.productList.length,
                        itemBuilder: (context, index) {
                          var data = _vm.productList[index];
                          return _buildListTile(
                            userImage: data.imageUrl,
                            userName: data.userName,
                            fatherName: data.fatherName,
                            cnic: data.cnic,
                            phoneNumber: data.phoneNumber,
                            onDelete: () {
                              conformationAlart(context, data);
                            },
                            onEdit: () {
                              Get.to(AddUserView(userData: data));
                            },
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String userImage,
    required String userName,
    required String fatherName,
    required String cnic,
    required String phoneNumber,
    required VoidCallback onDelete,
    required VoidCallback onEdit,
  }) {
    return Container(
      // height: 100,
      padding: EdgeInsets.all(10),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: Offset(5, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                userImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.person));
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardRow("Username: ", userName),
                _buildCardRow("Father Name: ", fatherName),
                _buildCardRow("CNIC No.: ", cnic),
                _buildCardRow("Phone Number: ", phoneNumber),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onEdit();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onDelete();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black.withValues(alpha: 0.7),
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  void conformationAlart(BuildContext context, ProductModel data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete User"),
          content: Text("Are you sure want to delete this user ?"),
          actions: [
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: "Cancel",
                    btnColor: Colors.grey.withValues(alpha: 0.3),
                    height: 40,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    txtColor: Colors.black.withValues(alpha: 0.7),
                    callback: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    title: "Delete",
                    btnColor: Colors.red,
                    height: 40,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    callback: () {
                      _vm.deleteProduct(data);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
