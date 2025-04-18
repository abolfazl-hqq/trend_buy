import 'package:flutter/material.dart';
import '../data/categories.dart';

class CategorySliderWidget extends StatelessWidget {
  const CategorySliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryList.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  minRadius: 35,
                  maxRadius: 35,
                ),
                const SizedBox(height: 8),
                Text(
                  item,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
