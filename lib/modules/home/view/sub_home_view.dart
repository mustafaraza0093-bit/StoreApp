import 'package:flutter/material.dart';
import 'package:store_app/common/app_TextField.dart';
import 'package:store_app/modules/home/view/components/restaurant_tile.dart';

class SubHomeView extends StatelessWidget {
  const SubHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(child: Icon(Icons.menu, size: 25)),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deliver to",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Halal Lab Office"),
                        Icon(Icons.arrow_drop_down, size: 23),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Badge(
                  label: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  padding: EdgeInsets.all(2),
                  backgroundColor: Colors.deepOrange,
                  offset: Offset(-5, 0),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(Icons.store, size: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Hey Halal,",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " Good Afternoon",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppTextfield(
                        hintText: "Search Dishes and Resturants",
                        textFieldType: AppTextFieldType.search,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "All Categories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 15),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(16, 10, 0, 10),
                    children: [
                      _buildCategoryChip(
                        imagePath: "assets/icons/pizzaimage.png",
                        title: "Pizza",
                        subTitle: "Starting",
                        price: "\$10",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Open Restaurants",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 15),
                        ],
                      ),
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          RestaurantTile(
                            imageUrl:
                                "https://i.pinimg.com/1200x/75/15/6b/75156b85e4206ce567a9a0d85c387ef0.jpg",
                            name: "Pizza Hut",
                            description: "Delicious Pizza and more",
                            rating: "4.5",
                            distance: "2.3 km",
                            deliveryTime: "30-40 min",
                          ),

                          RestaurantTile(
                            imageUrl:
                                "https://i.pinimg.com/736x/04/67/d2/0467d2e64a67a76ef2b275f6965669d9.jpg",
                            name: "Bonfire",
                            description: "Grilled to perfection",
                            rating: "5",
                            distance: "2.3 km",
                            deliveryTime: "30-40 min",
                          ),

                          RestaurantTile(
                            imageUrl:
                                "http://i.pinimg.com/1200x/33/27/94/332794b629efc429e589141b0b045f1b.jpg",
                            name: "Moye Moye Restaurant",
                            description: "Authentic Nigerian Cuisine",
                            rating: "2.5",
                            distance: "2.3 km",
                            deliveryTime: "30-40 min",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String imagePath,
    required String title,
    required String subTitle,
    required String price,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 30,
                offset: Offset(20, 20),
              ),
            ],
          ),
          margin: EdgeInsets.only(right: 0),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    price,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          child: Image.asset(imagePath, height: 110, width: 110),
        ),
      ],
    );
  }
}
