import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/modules/detail/view/add_user_view.dart';
import 'package:store_app/modules/detail/viewmodel/product_viewmodel.dart';

class Product extends StatelessWidget {
  Product({super.key});

  final ProductViewmodel _vm = Get.put(ProductViewmodel());

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
              Get.to(AddUserView());
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
              () => ListView.builder(
                itemCount: _vm.productList.length,
                itemBuilder: (context, index) {
                  var data = _vm.productList[index];
                  return _buildListTile(
                    userImage: data.userImage,
                    userName: data.userName,
                    fatherName: data.fatherName,
                    cnic: data.cnic,
                    phoneNumber: data.phoneNumber,
                    onDelete: () {
                      _vm.deleteProduct(data);
                    },
                    onEdit: () {
                      Get.to(AddUserView(userData :data));
                    },
                  );
                },
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
                height: 50,
                width: 50,
                fit: BoxFit.cover,
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

  // Widget _buildItemTile({
  //   required String title,
  //   required String subtitle,
  //   required String price,
  //   required String image,
  // }) {
  //   return Stack(
  //     alignment: Alignment.bottomCenter,
  //     children: [
  //       Container(
  //         height: 150,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.1),
  //               blurRadius: 10,
  //               offset: Offset(5, 10),
  //             ),
  //           ],
  //         ),
  //         padding: EdgeInsets.all(13),
  //         margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               subtitle,
  //               style: TextStyle(fontSize: 13, color: Colors.grey),
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   "\$$price",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 Spacer(),
  //                 Container(
  //                   height: 30,
  //                   width: 30,
  //                   decoration: BoxDecoration(
  //                     color: Colors.orange,
  //                     borderRadius: BorderRadius.circular(100),
  //                   ),
  //                   child: Icon(Icons.add, color: Colors.white),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //         top: -5,
  //         child: image.contains("http")
  //             ? Image.network(image, height: 100)
  //             : Image.asset(image, height: 100),
  //       ),
  //     ],
  //   );
  // }
}
