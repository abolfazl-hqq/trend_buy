import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/data/product.dart';
import 'package:trendbuy/my_theme.dart';
import '../providers/cart_products_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLiked = false;
  void likeButton() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Product',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  widget.product.productPicUrl,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.product.productName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.product.category,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color: isLiked ? Colors.red : Colors.black,
                                size: 25,
                              ),
                              onPressed: likeButton,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '\$${widget.product.productPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          widget.product.productDescription,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 55,
                                      child:
                                          CustomOutlinedButton(widget: widget))),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary, // Button color
                                      foregroundColor: Colors.white, // Text color
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Makes it rectangular
                                      ),
                                    ),
                                    child: Text(
                                      'Buy now',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class CustomOutlinedButton extends ConsumerStatefulWidget {
  const CustomOutlinedButton({
    super.key,
    required this.widget,
  });

  final ProductDetails widget;

  @override
  ConsumerState<CustomOutlinedButton> createState() =>
      _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends ConsumerState<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          ref
              .read(cartProductsProvider.notifier)
              .addProduct(widget.widget.product, context);
        },
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          side:
              const BorderSide(width: 2, color: LightTheme.secondaryTextColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.card_travel_rounded,
              color: Colors.black,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Add to cart',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ));
  }
}
