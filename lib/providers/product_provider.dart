import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/data/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  Future<List<Product>> fetchProducts() async {
    final url = Uri.https(
        'trendbuy-551cc-default-rtdb.firebaseio.com', '/products.json');
    final response = await http.get(url);
    final Map<String, dynamic> productList = json.decode(response.body);
    final List<Product> loadedItems = [];
    for (final item in productList.entries) {
      loadedItems.add(Product(
          id: item.key,
          producer: item.value['producer'],
          productName: item.value['name'],
          productPrice: item.value['price'],
          productPicUrl: item.value['pictureurl'],
          productDescription: item.value['description']));
    }
    state = loadedItems;
    return state;
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
  (ref) => ProductNotifier(),
);
