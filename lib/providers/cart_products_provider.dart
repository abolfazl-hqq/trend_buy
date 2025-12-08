import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../my_theme.dart';
import 'package:flutter/material.dart';
import '../data/product.dart';

final cartProductsProvider =
    StateNotifierProvider<CartProductsNotifier, List<Product>>(
  (ref) => CartProductsNotifier(),
);

class CartProductsNotifier extends StateNotifier<List<Product>> {
  CartProductsNotifier() : super([]);

  void addProduct(Product product, BuildContext context) {
    final bool isInCart = state.any((item) => item.id == product.id);
    if (isInCart) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) => const Padding(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Row(
              children: [
                Icon(Icons.remove_circle_outline_rounded,
                    color: LightTheme.secondaryColor),
                SizedBox(width: 10),
                Text('Item already exists'),
              ],
            ),
          ),
        ),
      );
    } else {
      state = [...state, product];
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) => const Padding(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Item added to cart!'),
              ],
            ),
          ),
        ),
      );
    }
  }

  void removeProduct(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  void clearCart() {
    state = [];
  }
}
