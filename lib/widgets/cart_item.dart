import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/data/product.dart';
import 'package:trendbuy/widgets/quantity_selector.dart';
import '../providers/cart_products_provider.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProductsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(
                      product.productPicUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.producer,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: 140,
                          child: Text(
                            product.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: 120,
                          child: Text(
                            'Color : gray',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 13),
                          )),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.productPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    QuantitySelector(
                      onQuantityChanged: (p0) {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        cartProducts.removeWhere(
                          (element) => element.id == product.id,
                        );
                      },
                      child: TextButton(
                        child: Text(
                          'Remove',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onPressed: () {
                          ref
                              .read(cartProductsProvider.notifier)
                              .removeProduct(product);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
