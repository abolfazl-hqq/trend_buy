import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_products_provider.dart';
import '../data/product.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  // Track selected payment method (0 for Apple Pay, 1 for Credit Card)
  int selectedPaymentMethod = 0;

  // Color constants based on the UI image
  final Color darkBlue = const Color(0xFF1A1A2E);
  final Color inputFillColor = const Color(0xFFF0F2F5);
  
  double get _shippingCost => 10.00;
  
  double _calculateSubtotal(List<Product> products) {
    return products.fold(0.0, (sum, product) => sum + product.productPrice);
  }
  
  double _calculateTotal(List<Product> products) {
    return _calculateSubtotal(products) + _shippingCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      // Using SafeArea for the bottom button area
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Handle Complete Action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "COMPLETE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle("Delivery Address"),
              const SizedBox(height: 16),
              _buildInputField(hintText: "Full Name"),
              _buildInputField(hintText: "Address Line 1"),
              _buildInputField(hintText: "Address Line 2 (Optional)"),
              Row(
                children: [
                  Expanded(child: _buildInputField(hintText: "City")),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      hintText: "Map view",
                      prefixIcon: Icons.location_on,
                      isMapButton: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildInputField(hintText: "State/Province")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildInputField(hintText: "Zip/Postal Code")),
                ],
              ),
              const SizedBox(height: 30),
              _buildSectionTitle("Order Summary"),
              const SizedBox(height: 16),
              _buildOrderSummaryItems(),
              const Divider(height: 30, color: Colors.grey),
              _buildPriceRow("Shipping", "\$${_shippingCost.toStringAsFixed(2)}"),
              const SizedBox(height: 12),
              _buildPriceRow("Total", "\$${_calculateTotal(ref.watch(cartProductsProvider)).toStringAsFixed(2)}", isTotal: true),
              const SizedBox(height: 30),
              _buildSectionTitle("Payment Method"),
              const SizedBox(height: 16),
              _buildPaymentMethods(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    IconData? prefixIcon,
    bool isMapButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        readOnly: isMapButton, // Make read-only if it's the "Map view" button
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          filled: true,
          fillColor: inputFillColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[600], size: 20)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummaryItems() {
    final cartProducts = ref.watch(cartProductsProvider);
    
    if (cartProducts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    
    return Column(
      children: cartProducts.map((product) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.productPicUrl),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
                child: product.productPicUrl.isEmpty
                    ? const Icon(Icons.image_not_supported, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.producer,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Qty: 1",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Price
              Text(
                "\$${product.productPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Row(
      children: [
        Expanded(
          child: _buildPaymentCard(
            index: 0,
            icon: Icons.apple,
            label: "Pay",
            isSelected: selectedPaymentMethod == 0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPaymentCard(
            index: 1,
            icon: Icons.credit_card,
            label: "Credit Card",
            isSelected: selectedPaymentMethod == 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: inputFillColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // The UI shows a thick dark border for selected state
            color: isSelected ? darkBlue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}