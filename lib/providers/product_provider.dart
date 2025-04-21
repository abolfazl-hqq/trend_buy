import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/data/product.dart';

final productProvider = Provider(
  (ref) => productList,
);
