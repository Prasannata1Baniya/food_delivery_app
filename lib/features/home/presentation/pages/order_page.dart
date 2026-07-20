import 'package:flutter/material.dart';
import '../../../constants/text_font.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Mock cart items (You will connect this to a CartCubit / Firestore later)
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Pepperoni Pizza",
      "price": 25.00,
      "quantity": 2,
      "image": "assets/material/pizza.png",
    },
    {
      "name": "Cheese Burger",
      "price": 18.00,
      "quantity": 1,
      "image": "assets/material/burger.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF5722);
    const darkOnboard = Color(0xFF1E1E24);

    double subtotal = cartItems.fold(
      0,
          (sum, item) => sum + (item['price'] * item['quantity']),
    );
    double deliveryFee = 3.99;
    double grandTotal = subtotal > 0 ? subtotal + deliveryFee : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: Text(
          "My Cart & Orders",
          style: AppBarTitleText.poppins.copyWith(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkOnboard,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              "Your cart is empty",
              style: BoldTextStyle.poppins.copyWith(fontSize: 18, color: Colors.grey.shade600),
            ),
          ],
        ),
      )
          : Column(
        children: [
          // Delivery Address Header Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryOrange.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on_rounded, color: primaryOrange, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deliver To",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Home - 742 Evergreen Terrace",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkOnboard),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Change", style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),

          // List of Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.fastfood_rounded, color: primaryOrange, size: 32),
                      ),
                      const SizedBox(width: 16),


                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: BoldTextStyle.poppins.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                              style: SemiBoldTextStyle.poppins.copyWith(fontSize: 16, color: primaryOrange),
                            ),
                          ],
                        ),
                      ),

                      // Quantity Selector Controls
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (item['quantity'] > 1) {
                                  item['quantity']--;
                                } else {
                                  cartItems.removeAt(index);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.remove, size: 16, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "${item['quantity']}",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item['quantity']++;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: primaryOrange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.add, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bill Summary & Checkout Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    Text("\$${subtotal.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Fee", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    Text("\$${deliveryFee.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Grand Total", style: BoldTextStyle.poppins.copyWith(fontSize: 16)),
                    Text("\$${grandTotal.toStringAsFixed(2)}", style: BoldTextStyle.poppins.copyWith(fontSize: 20, color: primaryOrange)),
                  ],
                ),
                const SizedBox(height: 20),

                // Checkout CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order placed successfully! 🍕"),
                          backgroundColor: primaryOrange,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      shadowColor: primaryOrange.withValues(alpha:0.4),
                    ),
                    child: const Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}