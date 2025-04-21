import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:trendbuy/widgets/cart_item.dart';
import '../providers/cart_products_provider.dart';
import '../data/product.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProductsProvider);
    double totalPrice =
        cartProducts.fold(0, (sum, product) => sum + product.productPrice);

    return cartProducts.isEmpty == false
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
                              cartProducts[index].productDescription),
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
                      onPressed: () {},
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        : const Center(
            child: Text('your cart is empty'),
          );
  }
}
