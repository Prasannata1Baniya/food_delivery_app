import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/order_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/profile_page.dart';
import 'package:e_commerce_app/features/home/presentation/pages/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation-cubit/navigation_cubit.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in!")),
      );
    }

    const primaryOrange = Color(0xFFFF5722);
    const darkBackground = Color(0xFF1E1E24);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentTabIndex) {
          return CurvedNavigationBar(
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            color: darkBackground,
            buttonBackgroundColor: primaryOrange,
            index: currentTabIndex,
            onTap: (index) {
              context.read<NavigationCubit>().updateTab(index);
            },
            items: const [
              Icon(Icons.home_rounded, color: Colors.white),
              Icon(Icons.shopping_bag_rounded, color: Colors.white),
              Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
              Icon(Icons.person_rounded, color: Colors.white),
            ],
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentTabIndex) {
          switch (currentTabIndex) {
            case 0:
              return const HomePage();
            case 1:
              return const OrderPage();
            case 2:
              return WalletPage(userId: userId);
            case 3:
              return const ProfilePage();
            default:
              return const Center(child: Text("Page not found"));
          }
        },
      ),
    );
  }
}
