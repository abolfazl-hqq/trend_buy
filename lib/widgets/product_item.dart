import 'package:flutter/material.dart';
import 'package:trendbuy/screens/product_details.dart';
import '../data/product.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetails(
              product: Product(
            id: product.id,
            productName: product.productName,
            productPicUrl: product.productPicUrl,
            productPrice: product.productPrice,
            productDescription: product.productDescription,
            producer: product.producer,
            category: product.category,
          )),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Container(
          height: 300,
          width: 200,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(
                            Icons.error,
                            size: 50,
                          ),
                        ),
                    product.productPicUrl),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              product.productName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('\$${product.productPrice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 16)),
                        ],
                      ),
                      const Spacer()
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
