import 'package:flutter/material.dart';
import 'package:trendbuy/screens/product_details.dart';
import '../data/product.dart';

class ProductItemWidget extends StatelessWidget {
  final int id;
  final String productName;
  final String productPicUrl;
  final double productPrice;
  final String productDescription;
  final String productProducer;
  const ProductItemWidget({
    super.key,
    required this.id,
    required this.productName,
    required this.productPicUrl,
    required this.productPrice,
    required this.productDescription,
    required this.productProducer,
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
            id: id,
            productName: productName,
            productPicUrl: productPicUrl,
            productPrice: productPrice,
            productDescription: productDescription,
            producer: productProducer,
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
                child: Image.network(fit: BoxFit.contain, productPicUrl),
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
                              productName,
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
                          Text('\$$productPrice',
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
