import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:trendbuy/screens/checkout_screen.dart';
import 'package:trendbuy/widgets/cart_item.dart';
import '../providers/cart_products_provider.dart';
import '../data/product.dart';
import '../l10n/app_localizations.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProductsProvider);
    double totalPrice =
        cartProducts.fold(0, (sum, product) => sum + product.productPrice);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.shopify_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.archive_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: cartProducts.isEmpty == false
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        product: Product(
                            id: cartProducts[index].id,
                            producer: cartProducts[index].producer,
                            productName: cartProducts[index].productName,
                            productPrice: cartProducts[index].productPrice,
                            productPicUrl: cartProducts[index].productPicUrl,
                            productDescription:
                                cartProducts[index].productDescription,
                            category: cartProducts[index].category),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Total',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18),
                          ),
                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutScreen(),)),
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            minimumSize: const WidgetStatePropertyAll(
                                Size(double.infinity, 50)),
                            backgroundColor: const WidgetStatePropertyAll(
                                LightTheme.secondaryColor)),
                        child: Text(
                          'Checkout',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      'assets/images/vecteezy_empty-shopping-cart-concept-flat-design-icon-illustration_67565912.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n?.translate('your cart is empty') ?? 'Your cart is empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
    );
  }
}
