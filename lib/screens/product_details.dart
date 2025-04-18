import 'package:flutter/material.dart';
import 'package:trendbuy/data/product.dart';
import 'package:trendbuy/my_theme.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {super.key,
      required this.productId,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productDescription,
      required this.productProducer});

  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final String productDescription;
  final String productProducer;

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
        body: Expanded(
            child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                widget.productImage,
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
                            widget.productName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
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
                        '\$${widget.productPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.productDescription,
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
        )));
  }
}

class CustomOutlinedButton extends StatefulWidget {
  const CustomOutlinedButton({
    super.key,
    required this.widget,
  });

  final ProductDetails widget;

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    bool exists =
        cartProducts.any((product) => product.id == widget.widget.productId);
    return OutlinedButton(
        onPressed: () {
          setState(() {
            if (exists) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.remove_circle_outline_rounded,
                          color: LightTheme.secondaryColor),
                      SizedBox(width: 10),
                      Text('Item already exists'),
                    ],
                  ),
                ),
              );
            } else {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Item added to cart!'),
                    ],
                  ),
                ),
              );
              cartProducts.add(Product(
                  producer: widget.widget.productProducer,
                  id: widget.widget.productId,
                  productName: widget.widget.productName,
                  productPrice: widget.widget.productPrice,
                  productPicUrl: widget.widget.productImage,
                  productDescription: widget.widget.productDescription));
            }
          });
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
