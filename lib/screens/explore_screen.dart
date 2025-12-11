import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/widgets/category_slider.dart';
import 'package:trendbuy/widgets/product_item.dart';
import '../providers/product_provider.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key, this.filterCategory});

  final String? filterCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _searchController = TextEditingController();
    final allProducts = ref.read(productProvider);
    final products = filterCategory == null
        ? allProducts
        : allProducts
            .where((p) =>
                p.category.toLowerCase() ==
                filterCategory!.toLowerCase().trim())
            .toList();
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              if (filterCategory == null) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: CategorySliderWidget(),
                ),
                const SizedBox(height: 8),
              ],
              if (filterCategory != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          filterCategory.toString(),
                          style: Theme.of(context)
                              .textTheme.bodyMedium!
                        ),
                      ),
                    ],
                  ),
                ),
              if (filterCategory != null) const SizedBox(height: 8),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text('No products found'))
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
