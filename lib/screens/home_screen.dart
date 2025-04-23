import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendbuy/my_theme.dart';
import '../providers/product_provider.dart';
import 'package:trendbuy/screens/cart_screen.dart';
import 'package:trendbuy/screens/explore_screen.dart';
import '../widgets/product_item.dart';
import '../widgets/category_slider.dart';
import '../data/product.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<Product>> _loadedProducts;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadedProducts = ref.read(productProvider.notifier).fetchProducts();
  }

  List<Widget> get _pages => [
        HomeScreenWidget(products: _loadedProducts),
        const ExploreScreen(),
        const CartScreen(),
        const Center(child: Text("Profile Page")),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Icon(Icons.home_rounded),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Icon(Icons.search),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Icon(
                  Icons.shopping_cart,
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
        appBar: AppBar(
          leading: Icon(
            Icons.shopify_rounded,
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
        body: _pages[_selectedIndex]);
  }
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key, required this.products});
  final Future<List<Product>> products;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Image.asset(
            'assets/images/banner.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: 180,
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shop by category',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CategorySliderWidget()),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Curated for you',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: LightTheme.secondaryColor,
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                              "There are no products to show at the moment"),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data!.map(
                            (product) {
                              return ProductItemWidget(
                                productProducer: product.producer,
                                id: product.id,
                                productName: product.productName,
                                productPicUrl: product.productPicUrl,
                                productPrice: product.productPrice,
                                productDescription: product.productDescription,
                              );
                            },
                          ).toList(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
