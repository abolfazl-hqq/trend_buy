import 'package:flutter/material.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:trendbuy/widgets/cart_item.dart';
import '../data/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.productList});
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        productList.fold(0, (sum, product) => sum + product.productPrice);

    return productList.isEmpty == false
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                        productName: productList[index].productName,
                        productId: productList[index].id,
                        productPrice: productList[index].productPrice,
                        productPicUrl: productList[index].productPicUrl,
                        productProducer: productList[index].producer);
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
