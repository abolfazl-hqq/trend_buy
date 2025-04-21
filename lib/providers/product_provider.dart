import 'package:riverpod/riverpod.dart';
import 'package:trendbuy/data/product.dart';

final productProvider = Provider(
  (ref) => productList,
);
