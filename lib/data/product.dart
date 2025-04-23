class Product {
  final String id;
  final String productName;
  final double productPrice;
  final String productPicUrl;
  final String productDescription;
  final String producer;

  Product(
      {required this.id,
      required this.producer,
      required this.productName,
      required this.productPrice,
      required this.productPicUrl,
      required this.productDescription});
}
