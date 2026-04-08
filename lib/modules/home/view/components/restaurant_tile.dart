import 'package:flutter/material.dart';

class RestaurantTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String rating;
  final String distance;
  final String deliveryTime;
  const RestaurantTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    required this.distance,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildComponent(Icons.star, rating),
            SizedBox(width: 10),
            _buildComponent(Icons.location_on, distance),
            SizedBox(width: 10),
            _buildComponent(Icons.access_time, deliveryTime),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildComponent(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.deepOrange),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
