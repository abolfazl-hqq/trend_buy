import 'package:flutter/material.dart';
import 'package:trendbuy/data/product.dart';
import 'package:trendbuy/widgets/category_slider.dart';
import 'package:trendbuy/widgets/product_item.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: CategorySliderWidget(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemBuilder: (context, index) {
              final product = productList[index];
              return ProductItemWidget(
                productProducer: product.producer,
                id: product.id,
                productName: product.productName,
                productPicUrl: product.productPicUrl,
                productPrice: product.productPrice,
                productDescription: product.productDescription,
              );
            },
          ),
        ),
      ],
    );
  }
}
