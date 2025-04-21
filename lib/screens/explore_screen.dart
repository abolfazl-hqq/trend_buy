import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/widgets/category_slider.dart';
import 'package:trendbuy/widgets/product_item.dart';
import '../providers/product_provider.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.read(productProvider);
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
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemBuilder: (context, index) {
              final product = products[index];
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
