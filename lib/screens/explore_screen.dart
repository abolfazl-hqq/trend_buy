import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/widgets/category_slider.dart';
import 'package:trendbuy/widgets/product_item.dart';
import '../providers/product_provider.dart';
import '../l10n/app_localizations.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key, this.filterCategory});

  final String? filterCategory;

  // Map product category to standardized category (same as category_screen)
  String _mapToStandardCategory(String productCategory) {
    final category = productCategory.toLowerCase().trim();
    
    // Smartphone mappings
    if (category.contains('phone') || 
        category.contains('smartphone') || 
        category.contains('mobile') ||
        category == 'phone') {
      return 'smartphone';
    }
    
    // Laptop mappings
    if (category.contains('laptop') || 
        category.contains('notebook') ||
        category.contains('computer')) {
      return 'laptop';
    }
    
    // Monitor mappings
    if (category.contains('monitor') || 
        category.contains('display') ||
        category.contains('screen')) {
      return 'monitor';
    }
    
    // Television mappings
    if (category.contains('tv') || 
        category.contains('television') ||
        category.contains('smart tv')) {
      return 'television';
    }
    
    // Tablet mappings
    if (category.contains('tablet') || 
        category.contains('ipad')) {
      return 'tablet';
    }
    
    // Printer mappings
    if (category.contains('printer') || 
        category.contains('print')) {
      return 'printer';
    }
    
    // Accessory mappings
    if (category.contains('accessory') || 
        category.contains('headphone') ||
        category.contains('headset') ||
        category.contains('earphone') ||
        category.contains('cable') ||
        category.contains('charger') ||
        category.contains('case') ||
        category.contains('watch') ||
        category.contains('smartwatch')) {
      return 'accessory';
    }
    
    // Default to etc for anything else
    return 'etc';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    TextEditingController _searchController = TextEditingController();
    final allProducts = ref.read(productProvider);
    final products = filterCategory == null
        ? allProducts
        : allProducts
            .where((p) => _mapToStandardCategory(p.category) == filterCategory)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: l10n?.translate('search') ?? 'Search',
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
                      Chip(
                        label: Text(
                          '${l10n?.translate('categories') ?? 'Category'}: ${l10n?.translate(filterCategory!) ?? filterCategory!}',
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ],
                  ),
                ),
              if (filterCategory != null) const SizedBox(height: 8),
              Expanded(
                child: products.isEmpty
                    ? Center(child: Text(l10n?.translate('noProductsFound') ?? 'No products found'))
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
