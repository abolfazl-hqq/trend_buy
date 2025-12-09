import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/widgets/category_slider.dart';
import 'package:trendbuy/widgets/product_item.dart';
import '../providers/product_provider.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _searchController = TextEditingController();
    final products = ref.read(productProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              icon: Icon(Icons.search_rounded,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
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
                      product: product,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
