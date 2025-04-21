class Product {
  final int id;
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

final List<Product> productList = [
  Product(
    id: 1,
    productName: 'Curved gaming monitor QHD',
    productPrice: 319.00,
    producer: 'H&M',
    productPicUrl:
        'https://images.philips.com/is/image/philipsconsumer/f7e06b8b531f4e84bca1b01b008e5590?wid=700&hei=700&\$pnglarge\$',
    productDescription:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ),
  Product(
      id: 2,
      productName: 'Macbook Air M3',
      productPrice: 899.00,
      producer: 'Apple',
      productDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      productPicUrl:
          'https://i-lite.ru/wp-content/uploads/2024/03/macbook-air-15-m3-midnight-6.jpg'),
  Product(
      id: 3,
      productName: 'DualShock 4 Gamepad',
      productPrice: 45.00,
      producer: 'Sony',
      productDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      productPicUrl: 'https://img.mvideo.ru/Pdb/40079470b.jpg'),
  Product(
    id: 4,
    productName: 'Curved gaming monitor QHD',
    productPrice: 319.00,
    producer: 'H&M',
    productPicUrl:
        'https://images.philips.com/is/image/philipsconsumer/f7e06b8b531f4e84bca1b01b008e5590?wid=700&hei=700&\$pnglarge\$',
    productDescription:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ),
  Product(
      id: 5,
      productName: 'Macbook Air M3',
      productPrice: 899.00,
      producer: 'Apple',
      productDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      productPicUrl:
          'https://i-lite.ru/wp-content/uploads/2024/03/macbook-air-15-m3-midnight-6.jpg'),
  Product(
      id: 6,
      productName: 'DualShock 4 Gamepad',
      productPrice: 45.00,
      producer: 'Sony',
      productDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      productPicUrl: 'https://img.mvideo.ru/Pdb/40079470b.jpg')
];
